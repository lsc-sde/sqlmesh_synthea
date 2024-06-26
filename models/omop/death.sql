
MODEL (
  name @schema_omop.death,
  kind FULL,
  cron '@daily'
);

-- NB:
-- We observe death records in both the encounters.csv and observations.csv file.
-- that represents an observation of the US standard certificate of death.  To find the
-- corresponding cause of death, we would need to join to conditions on patient and description
-- (specifically conditions.description = observations.value).  Instead, we can use the encounters table.
-- The reasoncode column is the SNOMED code for the condition that caused death, so by using encounters
-- we get both the code for the death certification and the corresponding cause of death.

select
  p.person_id as person_id,
  e.start as death_date,
  e.start as death_datetime,
  32817 as death_type_concept_id,
  srctostdvm.target_concept_id as cause_concept_id,
  e.reasoncode as cause_source_value,
  srctostdvm.source_concept_id as cause_source_concept_id
from @schema_synthea.encounters as e
inner join @schema_vocab.source_to_standard_vocab_map as srctostdvm
  on
    e.reasoncode::varchar = srctostdvm.source_code
    and srctostdvm.target_domain_id = 'Condition'
    and srctostdvm.source_domain_id = 'Condition'
    and srctostdvm.target_vocabulary_id = 'SNOMED'
    and srctostdvm.source_vocabulary_id = 'SNOMED'
    and srctostdvm.target_standard_concept = 'S'
    and srctostdvm.target_invalid_reason is null
inner join @schema_omop.person as p
  on e.patient = p.person_source_value
where e.code::varchar = '308646001'
