
MODEL (
  name @schema_synthea.synthea_allergies,
  kind FULL,
  cron '@daily'
);

select
  start,
  stop,
  patient,
  encounter,
  cast(code as varchar(50)),
  description
from @schema_synthea.allergies
