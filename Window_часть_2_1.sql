SELECT shops.SHOPNUMBER, shops.CITY, shops.ADDRESS, 
SUM(sales.QTY) OVER (PARTITION BY shops.SHOPNUMBER) as SUM_QTY,
SUM(CAST(sales.QTY AS int)*goods.PRICE) OVER (PARTITION BY shops.SHOPNUMBER) as SUM_QTY_PRICE
FROM sales
join shops ON shops.SHOPNUMBER = sales.SHOPNUMBER
join goods ON sales.ID_GOOD = goods.ID_GOOD
where sales.DATE = '1/2/16'

--первая оконная функция находит сумму проданных товаров в штуках, вторая - сумму проданных товаров в рублях.

