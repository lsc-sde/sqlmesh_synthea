select
  {{ adapter.quote("start") }} as date,
  {{ adapter.quote("patient") }},
  {{ adapter.quote("encounter") }},
  cast({{ adapter.quote("code") }} as varchar(50)),
  {{ adapter.quote("description") }},
  {{ adapter.quote("base_cost") }},
  {{ adapter.quote("reasoncode") }},
  {{ adapter.quote("reasondescription") }}
from {{ source('synthea', 'procedures') }}
