
MODEL (
  name @schema_synthea.synthea_claims,
  kind FULL,
  cron '@daily'
);

select
  id,
  patientid,
  providerid,
  primarypatientinsuranceid,
  secondarypatientinsuranceid,
  departmentid,
  patientdepartmentid,
  diagnosis1,
  diagnosis2,
  diagnosis3,
  diagnosis4,
  diagnosis5,
  diagnosis6,
  diagnosis7,
  diagnosis8,
  referringproviderid,
  appointmentid,
  currentillnessdate,
  servicedate,
  supervisingproviderid,
  status1,
  status2,
  statusp,
  outstanding1,
  outstanding2,
  outstandingp,
  lastbilleddate1,
  lastbilleddate2,
  lastbilleddatep,
  healthcareclaimtypeid1,
  healthcareclaimtypeid2
from @schema_synthea.claims
