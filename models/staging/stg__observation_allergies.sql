
MODEL (
  name @schema_staging.stg__observation_allergies,
  kind FULL,
  cron '@daily'
);

select
  a.patient,
  a.encounter,
  srctostdvm.target_concept_id as observation_concept_id,
  a.start as observation_date,
  a.start as observation_datetime,
  32827 as observation_type_concept_id,
  a.code as observation_source_value,
  srctosrcvm.source_concept_id as observation_source_concept_id
from @schema_synthea.allergies as a
inner join @schema_vocab.source_to_standard_vocab_map as srctostdvm
  on
    a.code::varchar = srctostdvm.source_code
    and srctostdvm.target_domain_id = 'Observation'
    and srctostdvm.target_vocabulary_id = 'SNOMED'
    and srctostdvm.target_standard_concept = 'S'
    and srctostdvm.target_invalid_reason is null
inner join @schema_vocab.source_to_source_vocab_map as srctosrcvm
  on
    a.code::varchar = srctosrcvm.source_code
    and srctosrcvm.source_vocabulary_id = 'SNOMED'
    and srctosrcvm.source_domain_id = 'Observation'
