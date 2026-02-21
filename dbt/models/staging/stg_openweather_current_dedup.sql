{{ config(materialized='view') }}

with ranked as (
    select
        *,
        row_number() over (
            partition by country, city, event_time
            order by api_call_time desc
        ) as rn
    from {{ ref('stg_openweather_current') }}
)

select * except(rn)
from ranked
where rn = 1