
MODEL (
  name @schema_synthea.synthea_payer_transitions,
  kind FULL,
  cron '@daily'
);

select *
from {{ source('synthea', 'payer_transitions') }}
