
MODEL (
  name @schema_synthea.synthea_medications,
  kind FULL,
  cron '@daily'
);

select
  start,
  stop,
  patient,
  payer,
  encounter,
  cast(code as varchar(50)),
  description,
  base_cost,
  payer_coverage,
  dispenses,
  totalcost,
  reasoncode,
  reasondescription
from @schema_synthea.medications
