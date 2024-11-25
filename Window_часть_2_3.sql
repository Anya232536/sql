SELECT DATE_, SHOPNUMBER, id_good from (
    SELECT 
    aggregated_sales.date AS DATE_, 
    aggregated_sales.shopnumber AS SHOPNUMBER,
    aggregated_sales.id_good,
    ROW_NUMBER() OVER (PARTITION BY aggregated_sales.date, aggregated_sales.shopnumber ORDER BY total_qty DESC) AS ID_GOOD_
FROM (
    SELECT 
        date,
        shopnumber,
        id_good,
        SUM(CAST(qty AS int)) AS total_qty
    FROM sales
    GROUP BY date, shopnumber, id_good
) AS aggregated_sales
JOIN shops ON shops.SHOPNUMBER = aggregated_sales.shopnumber
JOIN goods ON aggregated_sales.id_good = goods.ID_GOOD
ORDER BY aggregated_sales.date, aggregated_sales.shopnumber, ID_GOOD_)
where id_good_<=3

--строки отбираются по сгруппированной по столбцам date, shopnumber, id_good, далее с помощью оконной функции нумеруются строки,
-- выбираются те, где значение не больше 3
