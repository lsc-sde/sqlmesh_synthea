
MODEL (
  name @schema_staging.stg__all_visits,
  kind FULL,
  cron '@daily'
);

select
  *,
  row_number() over (order by patient) as visit_occurrence_id
from
  (
    select * from @schema_staging.stg__ip_visits 
    union all
    select * from @schema_staging.stg__er_visits 
    union all
    select * from @schema_staging.stg__op_visits 
  ) as t1
