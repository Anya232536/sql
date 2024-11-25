select sellers.seller_id, 
       COUNT(sellers.category) as total_categ, 
       ROUND(AVG(sellers.rating) ::numeric,2) as avg_rating,
       SUM(sellers.revenue) as total_revenue,
       CASE
       WHEN COUNT(sellers.category) > 1 and SUM(sellers.revenue)<50000 THEN 'poor'
       WHEN COUNT(sellers.category) > 1 and SUM(sellers.revenue)>=50000 THEN 'rich'
       END AS seller_type
       from sellers 
where sellers.category NOT in ('Bedding')
group BY sellers.seller_id
HAVING COUNT(sellers.category) > 1
ORDER BY sellers.seller_id;    

--исключает из рассмотрения категорию 'Bedding', затем категорируем продавцом по условию как 'rich' или 'poor'



