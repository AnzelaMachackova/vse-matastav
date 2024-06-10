from google.cloud import bigquery
from google.cloud import storage
import subprocess
import os

sql_script_path = "gs://vse-matastav-bucket/sql"

local_mdb_file = 'DAB_data.mdb'
bucket_name = 'vse-matastav-bucket'
csv_data_path = 'raw/csv'

client = bigquery.Client()
storage_client = storage.Client()

def mdb_to_csv(local_mdb_file, bucket_name, final_data_path):
    if not os.path.exists(local_mdb_file):
        raise FileNotFoundError(f"Local MDB file '{local_mdb_file}' not found.")

    bucket = storage_client.bucket(bucket_name)
    tables = subprocess.check_output(['mdb-tables', '-1', local_mdb_file]).decode().splitlines()

    for table in tables:
        csv_file = f'/tmp/{table}.csv'
        with open(csv_file, 'w') as f:
            subprocess.run(['mdb-export', local_mdb_file, table], stdout=f)
        print(f'Exported {table} to {csv_file}')
        
        # csv file to Google Cloud Storage
        csv_blob = bucket.blob(f'{final_data_path}/{table}.csv')
        csv_blob.upload_from_filename(csv_file)
        print(f'Uploaded {table}.csv to {final_data_path}/{table}.csv')

mdb_to_csv(local_mdb_file, bucket_name, csv_data_path)
