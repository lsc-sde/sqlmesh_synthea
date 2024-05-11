
MODEL (
  name @schema_omop.domain,
  kind FULL,
  cron '@daily'
);

select
  domain_id,
  domain_name,
  domain_concept_id
from @schema_vocab.domain
