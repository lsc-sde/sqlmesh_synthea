
MODEL (
  name @schema_staging.stg__observation_conditions,
  kind FULL,
  cron '@daily'
);

select
  c.patient,
  c.encounter,
  srctostdvm.target_concept_id as observation_concept_id,
  c.start as observation_date,
  c.start as observation_datetime,
  38000280 as observation_type_concept_id,
  c.code as observation_source_value,
  srctosrcvm.source_concept_id as observation_source_concept_id
from @schema_synthea.conditions as c
inner join @schema_vocab.source_to_standard_vocab_map as srctostdvm
  on
    c.code::varchar = srctostdvm.source_code
    and srctostdvm.target_domain_id = 'Observation'
    and srctostdvm.target_vocabulary_id = 'SNOMED'
    and srctostdvm.target_standard_concept = 'S'
    and srctostdvm.target_invalid_reason is null
inner join @schema_vocab.source_to_source_vocab_map as srctosrcvm
  on
    c.code::varchar = srctosrcvm.source_code
    and srctosrcvm.source_vocabulary_id = 'SNOMED'
    and srctosrcvm.source_domain_id = 'Observation'
