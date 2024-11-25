select sellers.seller_id, 
       EXTRACT(MONTH FROM AGE(CURRENT_DATE, MIN(TO_DATE(sellers.date_reg, 'DD/MM/YYYY')))) AS month_from_registration,
       (SELECT MAX(max_delivery_days) - MIN(min_delivery_days) 
FROM (
    SELECT 
        sellers.seller_id,
        MAX(sellers.delivery_days) AS max_delivery_days, 
        MIN(sellers.delivery_days) AS min_delivery_days FROM sellers
    where sellers.category NOT in ('Bedding') 
    GROUP BY sellers.seller_id
    HAVING COUNT(sellers.category) > 1 AND SUM(sellers.revenue) < 50000) 
AS subquery) AS max_delivery_difference FROM sellers
where sellers.category NOT in ('Bedding')
group BY sellers.seller_id
HAVING COUNT(sellers.category) > 1 and SUM(sellers.revenue)<50000 
ORDER BY sellers.seller_id;   

--используя результаты, полученные в коде Grouping_sorting_часть_2_1.sql, выводим id продавцом, 
--количество месяцев после регистрации и разницу между максимальным и минимальным сроком доставки среди неуспешных продавцов
-- Здесь под разницей между максимальным и минимальным сроком доставки среди неуспешных продавцов мной 
-- понимается максимальная и минимальный срок среди всех продавцов (не для каждого отдельно)



