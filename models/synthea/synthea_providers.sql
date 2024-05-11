
MODEL (
  name @schema_synthea.synthea_providers,
  kind FULL,
  cron '@daily'
);

select
  id,
  organization,
  name,
  gender,
  speciality,
  address,
  city,
  state,
  zip,
  lat,
  lon,
  utilization
from @schema_synthea.providers
