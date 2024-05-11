
MODEL (
  name @schema_synthea.synthea_payers,
  kind FULL,
  cron '@daily'
);

select *
from {{ source('synthea', 'payers') }}
