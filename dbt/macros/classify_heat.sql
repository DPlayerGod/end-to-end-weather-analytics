{% macro classify_heat(temp_c, humidity) %}
    case
        when {{ heat_index(temp_c, humidity) }} < 27 then 'Comfortable'
        when {{ heat_index(temp_c, humidity) }} < 32 then 'Caution'
        when {{ heat_index(temp_c, humidity) }} < 41 then 'Extreme Caution'
        when {{ heat_index(temp_c, humidity) }} < 54 then 'Danger'
        else 'Extreme Danger'
    end
{% endmacro %}