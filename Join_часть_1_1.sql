SELECT DISTINCT(customers_new.name) as Customer,
EXTRACT(DAY FROM AGE(TO_TIMESTAMP(orders_new.shipment_date, 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP(orders_new.order_date, 'YYYY-MM-DD HH24:MI:SS'))) as day_
from customers_new JOIN orders_new
on customers_new.customer_id = orders_new.customer_id
where EXTRACT(DAY FROM AGE(TO_TIMESTAMP(orders_new.shipment_date, 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP(orders_new.order_date, 'YYYY-MM-DD HH24:MI:SS'))) 
= (SELECT max(EXTRACT(DAY FROM AGE(TO_TIMESTAMP(orders_new.shipment_date, 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP(orders_new.order_date, 'YYYY-MM-DD HH24:MI:SS')))) as day_s
   from orders_new) 
ORDER BY customers_new.name 

--Находим максимально время ожидания среди всех записей таблицы (10 дней), 
--затем выводим уникальные имена покупателей, которые ожидали заказ 10 дней


