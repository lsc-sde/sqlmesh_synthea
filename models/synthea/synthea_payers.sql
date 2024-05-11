
MODEL (
  name @schema_synthea.synthea_payers,
  kind FULL,
  cron '@daily'
);

select *
from @schema_synthea.payers
