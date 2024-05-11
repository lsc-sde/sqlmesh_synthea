
MODEL (
  name @schema_synthea.synthea_organizations,
  kind FULL,
  cron '@daily'
);

select
  id,
  name,
  address,
  city,
  state,
  zip,
  lat,
  lon,
  phone,
  revenue,
  utilization
from @schema_synthea.organizations
