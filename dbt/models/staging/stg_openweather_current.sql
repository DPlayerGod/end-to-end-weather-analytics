{{ config(materialized='view') }}

select
    nullif(trim(cast(city as string)), '') as city,
    nullif(trim(cast(country as string)), '') as country,

    safe_cast(lon as float64) as lon,
    safe_cast(lat as float64) as lat,

    safe_cast(temp_c as float64) as temp_c,
    safe_cast(humidity as int64) as humidity,

    safe_cast(rain_1h_mm as float64) as rain_1h_mm,
    safe_cast(rain_3h_mm as float64) as rain_3h_mm,

    safe_cast(wind_speed_ms as float64) as wind_speed_ms,
    safe_cast(wind_deg as float64) as wind_deg,
    safe_cast(wind_gust_ms as float64) as wind_gust_ms,

    safe_cast(event_time as timestamp) as event_time,
    safe_cast(api_call_time as timestamp) as api_call_time,

    timestamp_trunc(safe_cast(event_time as timestamp), hour) as event_hour

from {{ source('weather_raw', 'openweather_current') }}
where event_time is not null