
MODEL (
  name @schema_omop.source_to_concept_map,
  kind FULL,
  cron '@daily'
);

select
  SOURCE_CODE,
  SOURCE_CONCEPT_ID,
  SOURCE_VOCABULARY_ID,
  SOURCE_CODE_DESCRIPTION,
  TARGET_CONCEPT_ID,
  TARGET_VOCABULARY_ID,
  valid_start_date,
  valid_end_date,
  invalid_reason
from {{ source('vocab', 'source_to_concept_map') }}
