
MODEL (
  name @schema_synthea.synthea_claims_transactions,
  kind FULL,
  cron '@daily'
);

select
  null as id,
  null as claimid,
  null as chargeid,
  null as patientid,
  null as type,
  null as amount,
  null as method,
  null as fromdate,
  null as todate,
  null as placeofservice,
  null as procedurecode,
  null as modifier1,
  null as modifier2,
  null as diagnosisref1,
  null as diagnosisref2,
  null as diagnosisref3,
  null as diagnosisref4,
  null as units,
  null as departmentid,
  null as notes,
  null as unitamount,
  null as transferoutid,
  null as transfertype,
  null as payments,
  null as adjustments,
  null as transfers,
  null as outstanding,
  null as appointmentid,
  null as linenote,
  null as patientinsuranceid,
  null as feescheduleid,
  null as providerid,
  null as supervisingproviderid
{# from {{ source('synthea', 'claims_transactions') }} #}
