WITH final AS (
SELECT
YEAR(ORDERDATE) AS years,
DEALSIZE,
SUM(CASE WHEN STATUS IN('Resolved', 'Shipped') THEN SALES END) AS REVENUE,
COUNT(DISTINCT CASE WHEN STATUS IN('Resolved', 'Shipped') THEN ORDERNUMBER END) AS ORDERS
FROM {{ref("orders_incremental")}}
GROUP BY 1, 2
ORDER BY years, DEALSIZE)

SELECT *,
ROUND(DIV0(REVENUE, ORDERS), 2) AS AOV
FROM final