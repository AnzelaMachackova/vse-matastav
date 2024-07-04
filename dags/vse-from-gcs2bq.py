from airflow.decorators import task
from airflow.models import DAG
from datetime import datetime, timedelta
from google.cloud import bigquery
from google.cloud import storage
import subprocess
import os
import logging

local_mdb_file = 'DAB_data.mdb'
bucket_name = 'vse-matastav-bucket'
gcs_csv_path = 'airflow-test/raw'
dataset_name = 'airflowtest'
project_id = 'vse-matastav'
mdb_path = 'airflow-test/DAB_data.mdb'


default_args = {
    'owner': 'airflow',
    'start_date': datetime(2024, 5, 10),
    'retries': 3,
    'retry_delay': timedelta(minutes=1)
}

with DAG(dag_id='vse_orchestration', 
     default_args=default_args, 
     schedule_interval=None) as dag:

    @task()
    def mdb_to_csv(**kwargs):
        storage_client = storage.Client()

        bucket = storage_client.bucket(bucket_name)
        mdb_blob = bucket.blob(mdb_path)

        local_mdb_file = f'/tmp/{os.path.basename(mdb_path)}'
        
        mdb_blob.download_to_filename(local_mdb_file)
        logging.info(f'Downloaded {mdb_path} to {local_mdb_file}')

        tables = subprocess.check_output(['mdb-tables', '-1', local_mdb_file]).decode().splitlines()

        for table in tables:
            csv_file = f'/tmp/{table}.csv'
            with open(csv_file, 'w') as f:
                subprocess.run(['mdb-export', local_mdb_file, table], stdout=f)
            logging.info(f'Exported {table} to {csv_file}')
            
            # csv file to Google Cloud Storage
            csv_blob = bucket.blob(f'{gcs_csv_path}/{table}.csv')
            csv_blob.upload_from_filename(csv_file)
            logging.info(f'Uploaded {table}.csv to {gcs_csv_path}/{table}.csv')

        ti = kwargs['ti']
        ti.xcom_push(key='tables', value=tables)

        os.remove(local_mdb_file)
        for table in tables:
            os.remove(f'/tmp/{table}.csv')

    csv_creation = mdb_to_csv()

    @task()
    # create tables from sql script
    def create_tables_from_script(**kwargs):
        client = bigquery.Client(project=project_id)

        ti = kwargs['ti']
        tables = ti.xcom_pull(task_ids='mdb_to_csv', key='tables')
        try:
            for table in tables:
                table_name = table.split('.')[0]
                sql = f"""LOAD DATA INTO `{dataset_name}.{table_name}` 
                    FROM FILES (format = 'CSV', uris = ['gs://vse-matastav-bucket/airflow-test/raw/{table_name}.csv']);"""
                formatted_sql = sql.format(dataset_name=dataset_name, table_name=table_name)
                client.query(formatted_sql)
                logging.info(f'Created table {table_name}.')
        
        except Exception as e:
            logging.error(f'Error creating table {table_name}.')
            logging.error(e) 

    script_creation = create_tables_from_script()

    csv_creation >> script_creation


