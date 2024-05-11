from pathlib import Path
import duckdb
import yaml

def load_config() -> dict:
    try:
        config = yaml.load(Path('./config.yaml').open(), Loader=yaml.Loader)
        return config
    except:
        raise FileNotFoundError('Unable to find config.yaml in root directory. Are you running this in the project root?')


def main():

    config = load_config()


    db_file = config['gateways']['local']['connection']['catalogs']['persistent']
    catalog:str = Path(db_file).stem
    schema_synthea:str = config['variables']['schema_synthea']
    schema_vocab:str = config['variables']['schema_vocab']

    # Connect to database, optionally creating if it doesn't exist
    conn:duckdb.DuckDBPyConnection = duckdb.connect(db_file)

    # Create schemas
    conn.sql(f'create schema if not exists {catalog}.{schema_synthea}')
    conn.sql(f'create schema if not exists {catalog}.{schema_vocab}')


    # Load Synthea data into the database
    # Use the synthea schema
    conn.sql(f'use {catalog}.{schema_synthea}')
    synthea_csv_files = Path('./data/synthea').glob('*.csv')
    for f in synthea_csv_files:
        sql = f"CREATE TABLE IF NOT EXISTS {f.stem} AS SELECT * FROM read_csv('{str(f)}');"
        conn.sql(sql )
