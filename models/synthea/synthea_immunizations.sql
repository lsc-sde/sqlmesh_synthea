
MODEL (
  name @schema_synthea.synthea_immunizations,
  kind FULL,
  cron '@daily'
);

select
  date,
  patient,
  encounter,
  cast(code as varchar(50)),
  description,
  base_cost
from {{ source('synthea', 'immunizations') }}
