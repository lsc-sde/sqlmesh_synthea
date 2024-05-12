
MODEL (
  name @schema_vocab.source_to_concept_map,
  kind FULL,
  cron '@daily'
);

select
  null::varchar as SOURCE_CODE,
  null as SOURCE_CONCEPT_ID,
  null as SOURCE_VOCABULARY_ID,
  null as SOURCE_CODE_DESCRIPTION,
  null as TARGET_CONCEPT_ID,
  null as TARGET_VOCABULARY_ID,
  null as valid_start_date,
  null as valid_end_date,
  null as invalid_reason
{# from @schema_vocab.source_to_concept_map #}
