{% macro get_distinct_years(table, date_column) %}
  {% set get_years_query %}
    SELECT DISTINCT YEAR({{date_column}}) AS year
    FROM {{table}}
    ORDER BY year ASC
  {% endset %}

  {{ log(get_years_query, info=True) }}  <!-- Log the query for debugging -->

  {% set years = [] %}

  {% if execute %}
    {% set results = run_query(get_years_query) %}
    {{ log(results, info=True) }}  <!-- Log the results for debugging -->
    
    {% if results %}
      {% for row in results %}
        {% do log(row, info=True) %}  <!-- Log each row for debugging -->
        {% do years.append(row[0]) %}
      {% endfor %}
    {% else %}
      {{ log("No results returned", info=True) }}  <!-- Log if no results are returned -->
    {% endif %}
  {% endif %}

  {{ log(years, info=True) }}  <!-- Log the years list for debugging -->
  {{ return(years) }}
{% endmacro %}