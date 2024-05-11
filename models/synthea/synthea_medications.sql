select
  {{ adapter.quote("start") }},
  {{ adapter.quote("stop") }},
  {{ adapter.quote("patient") }},
  {{ adapter.quote("payer") }},
  {{ adapter.quote("encounter") }},
  cast({{ adapter.quote("code") }} as varchar(50)),
  {{ adapter.quote("description") }},
  {{ adapter.quote("base_cost") }},
  {{ adapter.quote("payer_coverage") }},
  {{ adapter.quote("dispenses") }},
  {{ adapter.quote("totalcost") }},
  {{ adapter.quote("reasoncode") }},
  {{ adapter.quote("reasondescription") }}
from {{ source('synthea', 'medications') }}
