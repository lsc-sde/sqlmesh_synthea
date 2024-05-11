
MODEL (
  name @schema_omop.concept_ancestor,
  kind FULL,
  cron '@daily'
);

select
  ancestor_concept_id,
  descendant_concept_id,
  min_levels_of_separation,
  max_levels_of_separation
from {{ source('vocab', 'concept_ancestor') }}
