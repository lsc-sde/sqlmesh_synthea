
MODEL (
  name @schema_omop.relationship,
  kind FULL,
  cron '@daily'
);

select
  relationship_id,
  relationship_name,
  is_hierarchical,
  defines_ancestry,
  reverse_relationship_id,
  relationship_concept_id
from {{ source('vocab', 'relationship') }}
