with
    agg as (
        select date_day, coalesce(sum(sales), 0) as sales
        from {{ ref("dates") }} d
        left join {{ ref("orders_incremental") }} o on d.date_day = o.orderdate
        where o.status in ('Resolved', 'Shipped')
        group by 1
    )

select
    year(date_day) as years,
    month(date_day) as months,
    round(avg(sales), 2) as avg_sales
from agg
group by 1, 2
order by years, months
