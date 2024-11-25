select DISTINCT(sellers.seller_id), STRING_AGG(DISTINCT category, ' - ' ORDER BY category) AS category_pair FROM sellers
where sellers.category NOT in ('Bedding') 
group BY sellers.seller_id
HAVING COUNT(sellers.category) = 2 and SUM(sellers.revenue)>75000 and EXTRACT(YEAR FROM MIN(TO_DATE(sellers.date_reg, 'DD/MM/YYYY'))) = 2012
ORDER BY sellers.seller_id;  

--используя результаты, полученные ранее выводим id продавцов и пары с наименованиями категорий, которые продают данные селлеры.



