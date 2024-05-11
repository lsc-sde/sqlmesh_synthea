
MODEL (
  name @schema_omop.concept_synonym,
  kind FULL,
  cron '@daily'
);

select
  concept_id,
  concept_synonym_name,
  language_concept_id
from {{ source('vocab', 'concept_synonym') }}
