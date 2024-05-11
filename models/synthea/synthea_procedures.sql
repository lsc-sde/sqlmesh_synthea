
MODEL (
  name @schema_synthea.synthea_procedures,
  kind FULL,
  cron '@daily'
);

select
  start as date,
  patient,
  encounter,
  cast(code as varchar(50)),
  description,
  base_cost,
  reasoncode,
  reasondescription
from {{ source('synthea', 'procedures') }}
