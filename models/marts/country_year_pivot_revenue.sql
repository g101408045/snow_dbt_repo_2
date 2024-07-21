{% set distinct_years = dbt_utils.get_column_values(table=source('autosales', 'automobile_sales'), column='ORDERDATE') %}

SELECT
c.COUNTRY,
{%- for year in distinct_years %}
SUM(CASE WHEN YEAR(o.ORDERDATE) = {{year}} THEN o.SALES ELSE 0 END) AS {{year}}_sales
{%- if not loop.last %},{% endif %}
{%- endfor %}
FROM {{ ref("orders_incremental") }} o
LEFT JOIN {{ ref("customers_scd") }} c
ON o.CUSTOMERNAME = c.CUSTOMERNAME
GROUP BY 1