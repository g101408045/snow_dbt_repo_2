{% macro get_distinct_years(table, date_column) %}
  {% set get_years_query %}
    SELECT DISTINCT YEAR({{date_column}}) AS year
    FROM {{table}}
    ORDER BY year ASC
  {% endset %}

  {% set years = [] %}

  {% if execute %}
    {% set results = run_query(get_years_query) %}
    
    {% if results %}
      {% for row in results %}
        {% do years.append(row[0]) %}
      {% endfor %}
    {% endif %}
  {% endif %}

  {{ return(years) }}
{% endmacro %}
