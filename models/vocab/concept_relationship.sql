
MODEL (
  name @schema_omop.concept_relationship,
  kind FULL,
  cron '@daily'
);

select
  concept_id_1,
  concept_id_2,
  relationship_id,
  valid_start_date,
  valid_end_date,
  invalid_reason
from @schema_vocab.concept_relationship
