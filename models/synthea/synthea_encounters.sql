
MODEL (
  name @schema_synthea.synthea_encounters,
  kind FULL,
  cron '@daily'
);

select
  id,
  start,
  stop,
  patient,
  organization,
  provider,
  payer,
  encounterclass,
  code,
  description,
  base_encounter_cost,
  total_claim_cost,
  payer_coverage,
  reasoncode,
  reasondescription
from @schema_synthea.encounters
