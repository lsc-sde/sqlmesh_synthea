
MODEL (
  name @schema_synthea.synthea_devices,
  kind FULL,
  cron '@daily'
);

select
  start,
  stop,
  patient,
  encounter,
  code,
  description,
  udi
from @schema_synthea.devices
