
MODEL (
  name @schema_omop.concept_class,
  kind FULL,
  cron '@daily'
);

select
  concept_class_id,
  concept_class_name,
  concept_class_concept_id
from {{ source('vocab', 'concept_class') }}
