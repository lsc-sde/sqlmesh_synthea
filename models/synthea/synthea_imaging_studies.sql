
MODEL (
  name @schema_synthea.synthea_imaging_studies,
  kind FULL,
  cron '@daily'
);

select
  id,
  date,
  patient,
  encounter,
  series_uid,
  bodysite_code,
  bodysite_description,
  modality_code,
  modality_description,
  instance_uid,
  SOP_code,
  SOP_description,
  procedure_code
from @schema_synthea.imaging_studies
