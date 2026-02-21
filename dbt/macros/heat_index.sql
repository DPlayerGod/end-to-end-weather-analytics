{% macro heat_index(temp_c, humidity) %}
    case
        when {{ temp_c }} >= 27 and {{ humidity }} >= 40 then
            -8.784695
            + 1.61139411 * {{ temp_c }}
            + 2.338549 * {{ humidity }}
            - 0.14611605 * {{ temp_c }} * {{ humidity }}
            - 0.012308094 * pow({{ temp_c }}, 2)
            - 0.016424828 * pow({{ humidity }}, 2)
            + 0.002211732 * pow({{ temp_c }}, 2) * {{ humidity }}
            + 0.00072546 * {{ temp_c }} * pow({{ humidity }}, 2)
            - 0.000003582 * pow({{ temp_c }}, 2) * pow({{ humidity }}, 2)
        else {{ temp_c }}
    end
{% endmacro %}