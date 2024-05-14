from pathlib import Path
import duckdb
import yaml
from zipfile import ZipFile
from tempfile import TemporaryDirectory
import tqdm
import requests

# Load SQLMesh config
try:
    config = yaml.load(Path("./config.yaml").open(), Loader=yaml.Loader)
except:
    raise FileNotFoundError(
        "Unable to find config.yaml in root directory. Are you running this in the project root?"
    )


# If any of these keys are not present, reasonable to raise an unhandled exception
db_file: str = config["gateways"]["local"]["connection"]["catalogs"]["persistent"]
catalog: str = Path(db_file).stem
schema_synthea: str = config["variables"]["schema_synthea"]
schema_vocab: str = config["variables"]["schema_vocab"]

# Create a data directories
dir_synthea = Path("./data/synthea")
dir_vocab = Path("./data/vocab")

dir_synthea.mkdir(parents=True, exist_ok=True)
dir_vocab.mkdir(parents=True, exist_ok=True)


# Connect to database, optionally creating if it doesn't exist
conn: duckdb.DuckDBPyConnection = duckdb.connect(db_file)

# Create schemas
conn.sql(f"CREATE SCHEMA IF NOT EXISTS {catalog}.{schema_synthea}")
conn.sql(f"CREATE SCHEMA IF NOT EXISTS {catalog}.{schema_vocab}")

# Check if Synthea data is alreay in the directory; else download
synthea_zip_file = dir_synthea.glob('*.zip')
try:
    synthea_zip_file = next(synthea_zip_file)
except StopIteration:
    print('Synthea data not found in ./data/synthea. Downloading...')
    r = requests.get('https://synthetichealth.github.io/synthea-sample-data/downloads/latest/synthea_sample_data_csv_latest.zip')   
    if r.status_code != 200:
        raise requests.HTTPError('Unable to download Synthea data. Download this from https://synthetichealth.github.io/synthea-sample-data/downloads/latest/synthea_sample_data_csv_latest.zip and save in ./data/synthea/')
    
    synthea_zip_file = dir_synthea.joinpath('synthea_sample_data_csv_latest.zip')
    synthea_zip_file.write_bytes(r.content)

print('Extracting Synthea files into temporary directory...')
with TemporaryDirectory() as td:
    with ZipFile(synthea_zip_file) as zf:
        zf.extractall(td)
    
    # Load Synthea data into the database.
    print("Inserting Synthea data into database if tables dont exist...")
    conn.sql(f"use {catalog}.{schema_synthea}")
    synthea_csv_files = Path(td).glob("*.csv")
    for f in tqdm.tqdm(synthea_csv_files):
        sql = f"CREATE TABLE IF NOT EXISTS {f.stem} AS SELECT * FROM read_csv('{str(f)}');"
        conn.sql(sql)

# Load vocab downloaded from Athena into duckdb
# Use the downloaded zip file in the ./data/vocab folder.

user_confirmation:str = input('Press enter after copying Athena vocabulary zip file into ./data/vocab:')

vocab_zip_file = Path("./data/vocab").glob("*.zip")
try:
    vocab_zip_file = next(vocab_zip_file)
except StopIteration:
    raise FileNotFoundError("No zip file found in ./data/vocab")

# The following code will extract the vocab into a temp directory
# load the data into duckdb and delete the temporary directory
with TemporaryDirectory() as td:
    print("Extracting vocabulary to temporary folder...")
    with ZipFile(vocab_zip_file) as zf:
        zf.extractall(td)
    vocab_csv_files = Path(td).glob("*.csv")
    print("Inserting Vocab data into database if tables dont exist...")
    # Use the vocab schema
    conn.sql(f"use {catalog}.{schema_vocab}")
    for f in tqdm.tqdm(vocab_csv_files):
        sql = f"CREATE TABLE IF NOT EXISTS {f.stem} AS SELECT * FROM read_csv('{str(f)}');"
        conn.sql(sql)

# Print the tables in the database
df = conn.sql(
    f"""select table_catalog, table_schema, table_name 
    from information_schema.tables
    where table_schema in ('{schema_synthea}','{schema_vocab}' )
    """ 
)
print(df)

# At this point, one would normally run sqlmesh create_external_models.
# I have done this, have moved the output to ./external_models/schema.yaml and fixed datatypes for some colums
