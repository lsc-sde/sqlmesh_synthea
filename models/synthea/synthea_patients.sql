
MODEL (
  name @schema_synthea.synthea_patients,
  kind FULL,
  cron '@daily'
);

select
  id,
  birthdate,
  deathdate,
  ssn,
  drivers,
  passport,
  prefix,
  first,
  last,
  suffix,
  maiden,
  marital,
  race,
  ethnicity,
  gender,
  birthplace,
  address,
  city,
  state,
  county,
  zip,
  lat,
  lon,
  healthcare_expenses,
  healthcare_coverage
from {{ source('synthea', 'patients') }}
