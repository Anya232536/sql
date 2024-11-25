SELECT sales.date as DATE_, shops.CITY as CITY, 
ROUND(SUM(CAST(sales.QTY AS int)*goods.PRICE) OVER (PARTITION BY sales.date)/
           SUM(CAST(sales.QTY AS int)*goods.PRICE) OVER () ::numeric,2) as SUM_SALES_REL
FROM sales
join shops ON shops.SHOPNUMBER = sales.SHOPNUMBER
join goods ON sales.ID_GOOD = goods.ID_GOOD
where goods.category = 'ЧИСТОТА'
order by sales.date

--с помощью оконной функции находится сумма по датам и делится на сумму по всему столбцу, также найдена с помощью оконной функции

