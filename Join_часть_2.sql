SELECT table_1_2.category, table_1_2.Sum_, table_1_2.max_category, table_3.name_
from (SELECT first_.category as category, first_.Sum_ as Sum_, second_.max_category as max_category
from 
(SELECT products_31.product_category as category, sum(orders_21.order_ammount) as Sum_
from orders_21 join products_31
on products_31.product_id = orders_21.product_id
GROUP by products_31.product_category) as first_
CROSS JOIN
(SELECT products_31.product_category as max_category
from orders_21 join products_31
on products_31.product_id = orders_21.product_id
GROUP by products_31.product_category
HAVING sum(orders_21.order_ammount) = (SELECT MAX(Sum_) from (SELECT products_31.product_category as category, sum(orders_21.order_ammount) as Sum_
                                                              from orders_21 join products_31
                                                              on products_31.product_id = orders_21.product_id
                                                              GROUP by products_31.product_category))) as second_) as table_1_2
JOIN
(SELECT products_31.product_category as category, products_31.product_name as name_, sum(orders_21.order_ammount) as Sum_
from orders_21 join products_31
on products_31.product_id = orders_21.product_id
GROUP by products_31.product_category, products_31.product_name
HAVING sum(orders_21.order_ammount) in (SELECT max(Sum_) from (SELECT products_31.product_category, products_31.product_name, sum(orders_21.order_ammount) as Sum_
                                                              from orders_21 join products_31
                                                              on products_31.product_id = orders_21.product_id
                                                              GROUP by products_31.product_category, products_31.product_name)
                                       GROUP by product_category)) as table_3
on table_1_2.category = table_3.category              

--объединяем три таблицы: в первой таблице - общая сумма продаж для каждой категории продуктов
-- далее с помощью cross join объединяем первую таблицу с таблицей, где найдена категоря продукта с наибольшей общей суммой продаж
-- затем по строке category происходит объединение получившейся таблицы с таблицей,
-- где для каждой категории продуктов, определит продукт с максимальной суммой продаж в этой категории.

