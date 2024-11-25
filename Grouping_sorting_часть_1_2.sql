SELECT products.category, ROUND(AVG(products.price) ::numeric,2) as avg_price from products
where products.name LIKE '%Home%' 
      or products.name LIKE '%Hair%'
GROUP BY category