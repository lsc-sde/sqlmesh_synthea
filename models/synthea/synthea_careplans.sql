select
  {{ adapter.quote("id") }},
  {{ adapter.quote("start") }},
  {{ adapter.quote("stop") }},
  {{ adapter.quote("patient") }},
  {{ adapter.quote("encounter") }},
  cast({{ adapter.quote("code") }} as varchar(50)),
  {{ adapter.quote("description") }},
  {{ adapter.quote("reasoncode") }},
  {{ adapter.quote("reasondescription") }}
from {{ source('synthea', 'careplans') }}
