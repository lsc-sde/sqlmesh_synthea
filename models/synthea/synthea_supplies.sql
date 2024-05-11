
MODEL (
  name @schema_synthea.synthea_supplies,
  kind FULL,
  cron '@daily'
);

select *
from {{ source('synthea', 'supplies') }}
