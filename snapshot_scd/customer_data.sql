{% snapshot customers_scd %}

-- check strategy
{{
    config(
        target_schema = "snapshots_schema",
        strategy = "check",
        unique_key = "CUSTOMERNAME",
        check_cols = ['PHONE', 'CITY', 'POSTALCODE', 'COUNTRY', 'CONTACTLASTNAME', 'CONTACTFIRSTNAME']
    )
}}

SELECT
CUSTOMERNAME, PHONE, CITY, POSTALCODE, COUNTRY, CONTACTLASTNAME, CONTACTFIRSTNAME
FROM {{source("autosales", "automobile_sales")}}
GROUP BY 1, 2, 3, 4, 5, 6, 7

{% endsnapshot %}