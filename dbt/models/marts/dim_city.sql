{{ config(materialized='table', cluster_by=['country','city']) }}

select
  country,
  city,
  any_value(lon) as lon,
  any_value(lat) as lat
from {{ ref('stg_openweather_current_dedup') }}
group by 1,2