select
  {{ adapter.quote("start") }},
  {{ adapter.quote("stop") }},
  {{ adapter.quote("patient") }},
  {{ adapter.quote("encounter") }},
  cast({{ adapter.quote("code") }} as varchar(50)),
  {{ adapter.quote("description") }}
from {{ source('synthea', 'allergies') }}
