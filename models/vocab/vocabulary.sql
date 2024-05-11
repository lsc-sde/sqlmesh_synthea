
MODEL (
  name @schema_omop.vocabulary,
  kind FULL,
  cron '@daily'
);

select
  vocabulary_id,
  vocabulary_name,
  vocabulary_reference,
  vocabulary_version,
  vocabulary_concept_id
from @schema_vocab.vocabulary
