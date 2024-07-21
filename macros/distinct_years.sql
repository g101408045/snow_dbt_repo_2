{% macro get_distinct_years(table, date_column) %}
  {% set get_years_query %}
    SELECT DISTINCT YEAR({{date_column}}) AS year
    FROM {{table}}
    ORDER BY year ASC
  {% endset %}

  {{ log(get_years_query, info=True) }}  <!-- Log the query -->

  {% set years = [] %}

  {% if execute %}
    {% set results = run_query(get_years_query) %}
    {{ log(results, info=True) }}  <!-- Log the raw results -->
    
    {% for row in results['data'] %}
      {% do log(row, info=True) %}  <!-- Log each row to ensure correct access -->
      {% do years.append(row[0]) %}
    {% endfor %}
  {% endif %}

  {{ log(years, info=True) }}  <!-- Log the years list -->
  {{ return(years) }}
{% endmacro %}
