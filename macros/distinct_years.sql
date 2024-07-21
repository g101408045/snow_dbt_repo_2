{% macro get_distinct_years(table, date_column) %}
  {% set get_years_query %}
    SELECT DISTINCT YEAR({{date_column}}) AS year
    FROM {{table}}
    ORDER BY year ASC
  {% endset %}

  {% set results = run_query(get_years_query) %}

  {% set years = [] %}
  {% for row in results['data'] %}
    {% do years.append(row[0]) %}
  {% endfor %}

  {{ return(years) }}
{% endmacro %}