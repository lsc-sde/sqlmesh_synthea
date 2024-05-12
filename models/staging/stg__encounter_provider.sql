
MODEL (
  name @schema_staging.stg__encounter_provider,
  kind FULL,
  cron '@daily'
);

{# This bit of SQL gets reused several times in the OMOP layer #}
select
  e.patient,
  e.id,
  pr.provider_id
from @schema_synthea.encounters as e
inner join @schema_omop.provider as pr
  on e.provider = pr.provider_source_value
