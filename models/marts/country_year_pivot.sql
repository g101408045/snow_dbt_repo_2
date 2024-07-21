{%set distinct_years = get_distinct_years(table = ref("orders_incremental"), date_column = "ORDERDATE") %}

SELECT
c.COUNTRY,
{%- for year in distinct_years %}
SUM(CASE WHEN YEAR(o.ORDERDATE) = {{year}} THEN o.SALES ELSE 0 END) AS sales_{{year}}
{%- if not loop.last %}, {% endif %}
{%- endfor %}
FROM {{ref("orders_incremental")}} o
LEFT JOIN {{ref("customers_scd")}} c
ON o.CUSTOMERNAME = c.CUSTOMERNAME
WHERE DBT_VALID_TO IS NULL
GROUP BY 1