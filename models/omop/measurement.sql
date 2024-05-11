
MODEL (
  name @schema_omop.measurement,
  kind FULL,
  cron '@daily'
);

with snomed_measurements as (
  select
    p.person_id as person_id,
    srctostdvm.target_concept_id as measurement_concept_id,
    e.start as measurement_date,
    e.start as measurement_datetime,
    e.start as measurement_time,
    32827 as measurement_type_concept_id,
    0 as operator_concept_id,
    cast(null as float) as value_as_number,
    0 as value_as_concept_id,
    0 as unit_concept_id,
    cast(null as float) as range_low,
    cast(null as float) as range_high,
    prv.provider_id as provider_id,
    fv.visit_occurrence_id_new as visit_occurrence_id,
    fv.visit_occurrence_id_new + 1000000 as visit_detail_id,
    pr.code as measurement_source_value,
    srctosrcvm.source_concept_id as measurement_source_concept_id,
    cast(null as varchar(4)) as unit_source_value,
    cast(null as varchar(4)) as value_source_value,
    cast(null as int) as unit_source_concept_id,
    cast(null as bigint) as measurement_event_id,
    cast(null as int) as meas_event_field_concept_id

  from @schema_synthea.synthea_procedures as pr
  inner join {{ ref ('source_to_standard_vocab_map') }} as srctostdvm
    on
      pr.code = srctostdvm.source_code
      and srctostdvm.target_domain_id = 'Measurement'
      and srctostdvm.source_vocabulary_id = 'SNOMED'
      and srctostdvm.target_standard_concept = 'S'
      and srctostdvm.target_invalid_reason is null
  inner join @schema_vocab.source_to_source_vocab_map as srctosrcvm
    on
      pr.code = srctosrcvm.source_code
      and srctosrcvm.source_vocabulary_id = 'SNOMED'
  left join @schema_staging.stg__final_visit_ids as fv
    on pr.encounter = fv.encounter_id
  left join @schema_synthea.synthea_encounters as e
    on
      pr.encounter = e.id
      and pr.patient = e.patient
  left join {{ ref ('provider') }} as prv
    on e.provider = prv.provider_source_value
  inner join {{ ref ('person') }} as p
    on pr.patient = p.person_source_value
),

loinc_measurements as (

  select
    p.person_id as person_id,
    srctostdvm.target_concept_id as measurement_concept_id,
    o.date as measurement_date,
    o.date as measurement_datetime,
    o.date as measurement_time,
    32827 as measurement_type_concept_id,
    0 as operator_concept_id,
    try_cast(o.value as float) as value_as_number,
    coalesce(srcmap2.target_concept_id, 0) as value_as_concept_id,
    coalesce(srcmap1.target_concept_id, 0) as unit_concept_id,
    cast(null as float) as range_low,
    cast(null as float) as range_high,
    pr.provider_id as provider_id,
    fv.visit_occurrence_id_new as visit_occurrence_id,
    fv.visit_occurrence_id_new + 1000000 as visit_detail_id,
    o.code as measurement_source_value,
    coalesce(srctosrcvm.source_concept_id, 0) as measurement_source_concept_id,
    o.units as unit_source_value,
    o.value as value_source_value,
    cast(null as int) as unit_source_concept_id,
    cast(null as bigint) as measurement_event_id,
    cast(null as int) as meas_event_field_concept_id

  from @schema_synthea.synthea_observations as o
  inner join {{ ref ('source_to_standard_vocab_map') }} as srctostdvm
    on
      o.code = srctostdvm.source_code
      and srctostdvm.target_domain_id = 'Measurement'
      and srctostdvm.source_vocabulary_id = 'LOINC'
      and srctostdvm.target_standard_concept = 'S'
      and srctostdvm.target_invalid_reason is null
  left join {{ ref ('source_to_standard_vocab_map') }} as srcmap1
    on
      o.units = srcmap1.source_code
      and srcmap1.target_vocabulary_id = 'UCUM'
      and srcmap1.source_vocabulary_id = 'UCUM'
      and srcmap1.target_standard_concept = 'S'
      and srcmap1.target_invalid_reason is null
  left join {{ ref ('source_to_standard_vocab_map') }} as srcmap2
    on
      o.value = srcmap2.source_code
      and srcmap2.target_domain_id = 'Meas value'
      and srcmap2.target_standard_concept = 'S'
      and srcmap2.target_invalid_reason is null
  left join @schema_vocab.source_to_source_vocab_map as srctosrcvm
    on
      o.code = srctosrcvm.source_code
      and srctosrcvm.source_vocabulary_id = 'LOINC'
  left join @schema_staging.stg__final_visit_ids as fv
    on o.encounter = fv.encounter_id
  left join @schema_synthea.synthea_encounters as e
    on
      o.encounter = e.id
      and o.patient = e.patient
  left join {{ ref ('provider') }} as pr
    on e.provider = pr.provider_source_value
  inner join {{ ref ('person') }} as p
    on o.patient = p.person_source_value
),

all_measurements as (
  select * from snomed_measurements
  union all
  select * from loinc_measurements
)

select
  row_number() over (order by am.person_id) as measurement_id,
  am.*
from all_measurements as am
