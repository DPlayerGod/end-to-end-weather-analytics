{{ config(
  materialized='table',
  partition_by={"field":"event_hour","data_type":"timestamp","granularity":"hour"},
  cluster_by=["country","city"]
) }}

select
  country,
  city,
  event_time,
  api_call_time,
  timestamp_trunc(event_time, hour) as event_hour,

  temp_c,
  humidity,
  rain_1h_mm,
  rain_3h_mm,
  wind_speed_ms,
  wind_deg,
  wind_gust_ms,

  {{ heat_index('temp_c','humidity') }} as heat_index_c,
  {{ classify_heat('temp_c','humidity') }} as heat_category
from {{ ref('stg_openweather_current_dedup') }}