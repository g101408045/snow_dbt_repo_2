{{
    config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = ['ORDERNUMBER', 'ORDERLINENUMBER'],
    merge_update_columns = ['STATUS']
    )
}}

SELECT
ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE, DAYS_SINCE_LASTORDER, STATUS
, PRODUCTLINE, PRODUCTCODE, DEALSIZE, CUSTOMERNAME
FROM {{source("autosales", "automobile_sales")}} new
{% if is_incremental() %}
WHERE
new.ORDERDATE >= DATEADD(MONTH, -6, (SELECT MAX(ORDERDATE) FROM {{this}}))
{% endif %}