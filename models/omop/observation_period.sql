
MODEL (
  name @schema_omop.observation_period,
  kind FULL,
  cron '@daily'
);

select
  row_number() over (order by person_id) as observation_period_id,
  person_id,
  start_date as observation_period_start_date,
  end_date as observation_period_end_date,
  32882 as period_type_concept_id
from (
  select
    p.person_id,
    min(e.start) as start_date,
    max(e.stop) as end_date
  from @schema_omop.person as p
  inner join @schema_synthea.synthea_encounters as e
    on p.person_source_value = e.patient
  group by p.person_id
) as tmp
