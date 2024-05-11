select
  {{ adapter.quote("date") }},
  {{ adapter.quote("patient") }},
  {{ adapter.quote("encounter") }},
  cast({{ adapter.quote("code") }} as varchar(50)),
  {{ adapter.quote("description") }},
  {{ adapter.quote("base_cost") }}
from {{ source('synthea', 'immunizations') }}
