
MODEL (
  name @schema_synthea.synthea_payer_transitions,
  kind FULL,
  cron '@daily'
);

select *
from @schema_synthea.payer_transitions
