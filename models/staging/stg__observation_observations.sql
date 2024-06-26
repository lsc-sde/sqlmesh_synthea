
MODEL (
  name @schema_staging.stg__observation_observations,
  kind FULL,
  cron '@daily'
);

select
  o.patient,
  o.encounter,
  srctostdvm.target_concept_id as observation_concept_id,
  o.date as observation_date,
  o.date as observation_datetime,
  38000280 as observation_type_concept_id,
  o.code as observation_source_value,
  srctosrcvm.source_concept_id as observation_source_concept_id
from @schema_synthea.observations as o
inner join @schema_vocab.source_to_standard_vocab_map as srctostdvm
  on
    o.code::varchar = srctostdvm.source_code
    and srctostdvm.target_domain_id = 'Observation'
    and srctostdvm.target_vocabulary_id = 'LOINC'
    and srctostdvm.target_standard_concept = 'S'
    and srctostdvm.target_invalid_reason is null
inner join @schema_vocab.source_to_source_vocab_map as srctosrcvm
  on
    o.code::varchar = srctosrcvm.source_code
    and srctosrcvm.source_vocabulary_id = 'LOINC'
    and srctosrcvm.source_domain_id = 'Observation'
