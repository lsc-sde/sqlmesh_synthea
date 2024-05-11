
MODEL (
  name @schema_synthea.synthea_observations,
  kind FULL,
  cron '@daily'
);

select
  date,
  patient,
  encounter,
  code,
  description,
  value,
  units,
  type
from @schema_synthea.observations
