{{ config(materialized='table', cluster_by=['country','city']) }}

with ranked as (
  select
    *,
    row_number() over (
      partition by country, city
      order by event_time desc, api_call_time desc
    ) as rn
  from {{ ref('fct_weather_obs') }}
)

select
  country,
  city,
  event_time,
  temp_c,
  humidity,
  wind_speed_ms,
  rain_1h_mm,
  heat_index_c,
  heat_category
from ranked
where rn = 1