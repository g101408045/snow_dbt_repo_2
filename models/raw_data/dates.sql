{{ dbt_utils.date_spine(
  datepart="day",
  start_date= "(select min(ORDERDATE) from " + ref('orders_incremental') | string + ")",
  end_date="(select max(ORDERDATE) from " + ref('orders_incremental') | string + ")"
) }}