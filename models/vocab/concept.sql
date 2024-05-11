
MODEL (
  name @schema_omop.concept,
  kind FULL,
  cron '@daily'
);

select
  concept_id,
  concept_name,
  domain_id,
  vocabulary_id,
  concept_class_id,
  standard_concept,
  concept_code,
  valid_start_date,
  valid_end_date,
  invalid_reason
from {{ source('vocab', 'concept') }}
