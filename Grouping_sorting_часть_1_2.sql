SELECT products.category, ROUND(AVG(products.price) ::numeric,2) as avg_price from products
where products.name LIKE '%Home%' 
      or products.name LIKE '%Hair%'
GROUP BY category

/* ищутся слова Home и Hair в название товаров, таким образом отбираются строки, с которыми производится работа дальше, 
затем производится сортировка по категориям для расчета средних значений цены */
