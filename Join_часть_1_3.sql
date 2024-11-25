SELECT 
    customers_new_3.name,
    COUNT(CASE WHEN orders_new_3.order_status = 'Approved' AND EXTRACT(DAY FROM AGE(TO_TIMESTAMP(orders_new_3.shipment_date, 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP(orders_new_3.order_date, 'YYYY-MM-DD HH24:MI:SS'))) > 5 THEN 1 END) AS delayed_deliveries,
    COUNT(CASE WHEN orders_new_3.order_status = 'Cancel' THEN 1 END) AS canceled_orders, -- считаем строки, в которых выполяняется первое или второе условие (или оба сразу)
    SUM(orders_new_3.order_ammount) AS total_amount
FROM customers_new_3 JOIN orders_new_3
ON customers_new_3.customer_id = orders_new_3.customer_id
WHERE (orders_new_3.order_status = 'Approved' AND EXTRACT(DAY FROM AGE(TO_TIMESTAMP(orders_new_3.shipment_date, 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP(orders_new_3.order_date, 'YYYY-MM-DD HH24:MI:SS'))) > 5)
    OR orders_new_3.order_status = 'Cancel'
-- отбираем клиентов у которых выполняется или первое, или второе условие
GROUP BY customers_new_3.name
HAVING COUNT(CASE WHEN orders_new_3.order_status = 'Approved' AND EXTRACT(DAY FROM AGE(TO_TIMESTAMP(orders_new_3.shipment_date, 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP(orders_new_3.order_date, 'YYYY-MM-DD HH24:MI:SS'))) > 5 THEN 1 END) > 0 OR 
COUNT(CASE WHEN orders_new_3.order_status = 'Cancel' THEN 1 END) > 0
ORDER BY total_amount DESC;

