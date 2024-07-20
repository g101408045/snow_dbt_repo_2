WITH current_sales AS (
SELECT
YEAR(ORDERDATE) AS years,
PRODUCTLINE,
SUM(CASE WHEN STATUS IN('Resolved', 'Shipped') THEN SALES END) AS REVENUE
FROM {{ref("orders_incremental")}}
GROUP BY 1, 2),

prev_revenue AS (
SELECT
* ,
COALESCE(LAG(REVENUE) OVER(PARTITION BY PRODUCTLINE ORDER BY years),0) AS PREV_YEAR_REVENUE,
FROM current_sales
ORDER BY years ASC, REVENUE DESC)

SELECT
*,
{{percent_delta('PREV_YEAR_REVENUE', 'REVENUE')}} AS REVENUE_DELTA
FROM prev_revenue