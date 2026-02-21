{{ config(
  materialized='table',
  partition_by={"field":"event_hour","data_type":"timestamp","granularity":"hour"},
  cluster_by=["country","city"]
) }}

select
  country,
  city,
  event_hour,

  count(*) as n_points,
  avg(temp_c) as avg_temp_c,
  min(temp_c) as min_temp_c,
  max(temp_c) as max_temp_c,

  avg(humidity) as avg_humidity,
  avg(wind_speed_ms) as avg_wind_speed_ms,
  max(wind_gust_ms) as max_wind_gust_ms,

  sum(coalesce(rain_1h_mm, 0)) as total_rain_1h_mm,
  avg(heat_index_c) as avg_heat_index_c
from {{ ref('fct_weather_obs') }}
group by 1,2,3