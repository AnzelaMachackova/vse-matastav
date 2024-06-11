from google.cloud import bigquery
from google.cloud import storage
import subprocess
import os

sql_script_path = "gs://vse-matastav-bucket/sql"
local_mdb_file = 'DAB_data.mdb'
bucket_name = 'vse-matastav-bucket'
csv_data_path = 'raw'
dataset_name = 'stage'
project_id = 'vse-matastav'

client = bigquery.Client(project=project_id)
storage_client = storage.Client()

def mdb_to_csv(local_mdb_file, bucket_name, final_data_path):
    if not os.path.exists(local_mdb_file):
        raise FileNotFoundError(f"Local MDB file '{local_mdb_file}' not found.")

    bucket = storage_client.bucket(bucket_name)
    tables = subprocess.check_output(['mdb-tables', '-1', local_mdb_file]).decode().splitlines()
    print(tables)

    for table in tables:
        csv_file = f'/tmp/{table}.csv'
        with open(csv_file, 'w') as f:
            subprocess.run(['mdb-export', local_mdb_file, table], stdout=f)
        print(f'Exported {table} to {csv_file}')
        
        # csv file to Google Cloud Storage
        csv_blob = bucket.blob(f'{final_data_path}/{table}.csv')
        csv_blob.upload_from_filename(csv_file)
        print(f'Uploaded {table}.csv to {final_data_path}/{table}.csv')
    return tables

# create tables from sql script
def create_tables_from_script(tables):

    for table in tables:
        table_name = table.split('.')[0]
        print(table_name)
        sql = f"""LOAD DATA INTO `{dataset_name}.{table_name}` 
            FROM FILES (format = 'CSV', uris = ['gs://vse-matastav-bucket/raw/{table_name}.csv']);"""
        formatted_sql = sql.format(dataset_name=dataset_name, table_name=table_name)
        client.query(formatted_sql)
        print(f'Created table {table_name}.')

tables = mdb_to_csv(local_mdb_file, bucket_name, csv_data_path)
create_tables_from_script(tables)