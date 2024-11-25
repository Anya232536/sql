SELECT DISTINCT(customers_new_3.name) as Customer,
EXTRACT(DAY FROM AGE(TO_TIMESTAMP(orders_new_3.shipment_date, 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP(orders_new_3.order_date, 'YYYY-MM-DD HH24:MI:SS'))) as day_
from customers_new_3 JOIN orders_new_3
on customers_new_3.customer_id = orders_new_3.customer_id
where EXTRACT(DAY FROM AGE(TO_TIMESTAMP(orders_new_3.shipment_date, 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP(orders_new_3.order_date, 'YYYY-MM-DD HH24:MI:SS'))) 
= (SELECT max(EXTRACT(DAY FROM AGE(TO_TIMESTAMP(orders_new_3.shipment_date, 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP(orders_new_3.order_date, 'YYYY-MM-DD HH24:MI:SS')))) as day_s
   from orders_new_3) 
ORDER BY customers_new_3.name 

--Находим максимально время ожидания среди всех записей таблицы (10 дней), 
--затем выводим уникальные имена покупателей, которые ожидали заказ 10 дней


