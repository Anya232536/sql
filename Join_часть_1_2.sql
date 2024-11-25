SELECT customers_new.name as Customer,
ROUND(AVG(EXTRACT(DAY FROM AGE(TO_TIMESTAMP(orders_new.shipment_date, 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP(orders_new.order_date, 'YYYY-MM-DD HH24:MI:SS'))))::numeric,1) as day_,
SUM(orders_new.order_ammount) as sum_ammount, 
COUNT(orders_new.customer_id)
  from customers_new JOIN orders_new
on customers_new.customer_id = orders_new.customer_id
GROUP BY customers_new.name
HAVING COUNT(orders_new.customer_id) = (select max(count_s) from (SELECT COUNT(orders_new.customer_id) as count_s FROM orders_new
                                          GROUP by orders_new.customer_id))
ORDER BY SUM(orders_new.order_ammount) DESC

--Среди клиентов, которые сделали максимальное количество заказов (Having), 
--находим среднее время между заказом и доставкой, а также общую сумму всех их заказов, затем сортируем по убыванию суммы 


