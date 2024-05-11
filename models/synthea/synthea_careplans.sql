
MODEL (
  name @schema_synthea.synthea_careplans,
  kind FULL,
  cron '@daily'
);

select
  id,
  start,
  stop,
  patient,
  encounter,
  cast(code as varchar(50)),
  description,
  reasoncode,
  reasondescription
from {{ source('synthea', 'careplans') }}
