
MODEL (
  name @schema_omop.payer_plan_period,
  kind FULL,
  cron '@daily'
);

select
  row_number() over (order by pat.id, pt.start_date) as payer_plan_period_id,
  per.person_id as person_id,
  try_cast(pt.start_date as timestamp) as payer_plan_period_start_date,
  try_cast(pt.end_date as timestamp) as payer_plan_period_end_date,
  0 as payer_concept_id,
  pt.payer as payer_source_value,
  0 as payer_source_concept_id,
  0 as plan_concept_id,
  pay.name as plan_source_value,
  0 as plan_source_concept_id,
  0 as sponsor_concept_id,
  cast(NULL as VARCHAR(4)) as sponsor_source_value,
  0 as sponsor_source_concept_id,
  cast(NULL as VARCHAR(4)) as family_source_value,
  0 as stop_reason_concept_id,
  cast(NULL as VARCHAR(4)) as stop_reason_source_value,
  0 as stop_reason_source_concept_id
from @schema_synthea.payers as pay
inner join @schema_synthea.payer_transitions as pt
  on pay.id = pt.payer
inner join @schema_synthea.patients as pat
  on pt.patient = pat.id
inner join @schema_omop.person as per
  on pat.id = per.person_source_value
