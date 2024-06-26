
MODEL (
  name @schema_omop.drug_exposure,
  kind FULL,
  cron '@daily'
);

with all_drugs as (
  select * from @schema_staging.stg__drug_medications 
  union all
  select * from @schema_staging.stg__drug_immunisations 
)
select
  row_number() over (order by p.person_id) as drug_exposure_id,
  p.person_id,
  drug_concept_id,
  drug_exposure_start_date,
  drug_exposure_start_datetime,
  drug_exposure_end_date,
  drug_exposure_end_datetime,
  verbatim_end_date,
  drug_type_concept_id,
  stop_reason,
  refills,
  quantity,
  days_supply,
  sig,
  route_concept_id,
  lot_number,
  pr.provider_id as provider_id,
  fv.visit_occurrence_id_new as visit_occurrence_id,
  fv.visit_occurrence_id_new + 1000000 as visit_detail_id,
  drug_source_value,
  drug_source_concept_id,
  route_source_value,
  dose_unit_source_value
from 
  all_drugs as ad
  left join @schema_staging.stg__final_visit_ids as fv
    on ad.encounter = fv.encounter_id
  left join @schema_synthea.encounters as e
    on
      ad.encounter = e.id
      and ad.patient = e.patient
  left join @schema_omop.provider as pr
    on e.provider = pr.provider_source_value
  inner join @schema_omop.person as p
    on ad.patient = p.person_source_value