# OHDSI Synthea-to-OMOP using SQLMesh

This is a working PoC of the use of [SQLMesh](https://sqlmesh.com/) to generate on OMOP 5.4 CDM using Synthea synthetic data.

## Getting started

1. Clone this repository
2. Create a python virtual environment and activate it
3. Run `pip install -r ./requirements.txt`
4. Run `python ./bootstrap.y`. The following steps are executed.
    - Creates a DuckDb database using the information in schema.yaml as well as create `./data/synthea` and `./data/vocab` folders.
    - Downloads the latest [Synthea 100 sample patients CSV data](https://synthea.mitre.org/downloads), extract the CSV files and upload them into the database.
    - Pauses code execution until user downloads/copies the Athena vocabulary data zip file into `./data/vocab` and presses `Enter` to continue
    - Uploads vocabulary into the database.
    - Prints out the table names in the database
5. You are all set to get started. Run `sqlmesh ui` for next steps.

Please do not hesistate to fork, create a PR, raise an issue or get involved in any other way.


## Related projects:

___DISCLAIMER: The following are all pre-alpha proof-of-concepts with absolutely no guarantees. In fact, running any of these in your data warehouse without guardrails may try to kill your cat. Read more about guardrails [here](https://en.m.wikipedia.org/wiki/Guard_rail).

### SQLMesh

- [SQLMesh Achilles](https://github.com/lsc-sde/sqlmesh_achilles)


### dbt

- [Synthea-to-OMOP - SQLServer](https://github.com/vvcb/dbt-synthea/tree/vc/main)
- [Synthea-to-OMOP - Databricks](https://github.com/vvcb/dbt-synthea/tree/vc/databricks)
- [Synthea-to-OMOP from first principles](https://github.com/OHDSI/dbt-synthea)
- [Achilles and DQD with dbt](https://github.com/lsc-sde/dbt_achilles)