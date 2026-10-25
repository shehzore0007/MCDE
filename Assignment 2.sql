											--JOINS--
--2.1. Write a query that lists every product with its brand name, using production.products and production.brands.--

select p.product_name, b.brand_name
from production.products as p
left join production.brands as b
on p.brand_id=b.brand_id

--2.2. Using a LEFT JOIN, write a query that finds every store with zero staff currently assigned to it.--

select s.store_name, st.staff_id
from sales.stores as s
left join sales.staffs as st
on s.store_id=st.store_id
where st.staff_id is null;

--2.3. Explain, in your own words, why the following query returns every product regardless of stock level,
--and rewrite it so that it only returns products with fewer than 5 units in stock at store 1:

select p.product_name, s.quantity
from production.products as p
left join production.stocks as s
    on p.product_id = s.product_id and s.quantity < 5 and s.store_id = 1;

--This query returns all product with NULL quantiy because it wrote wrongly with "AND" there is missing of "where"--

--correct version--
select p.product_name, s.quantity, s.store_id
from production.products as p
left join production.stocks as s
on p.product_id = s.product_id where s.quantity < 5 AND s.store_id = 1;

--2.4. Write a self join on sales.staffs that lists every manager along with a count placeholder column showing 1 for
--each employee they manage (you will replace this with a real COUNT in Chapter 3); for now,
--just produce one row per employee-manager pair.

select e.first_name+' '+e.last_name as employee,
m.first_name+' '+m.last_name as manager
from sales.staffs as e
inner join sales.staffs as m
on e.staff_id=m.staff_id;

--2.5. Write a three-table join across sales.orders, sales.order_items, and production.products
--that lists every item in order #1, including product name and quantity

select p.product_name, o.order_id, q.quantity
from sales.orders as o
inner join sales.order_items as q
on o.order_id=q.order_id
inner join production.products as p
on q.product_id=p.product_id
where o.order_id=1;

--2.6. A colleague joins orders to order_items and reports "we received 4,658 orders last year."
--Explain what actually went wrong with that number and how you would find the true order count instead.

 SELECT COUNT(*) AS total_orders
FROM sales.orders
WHERE order_date BETWEEN '2018-01-01' AND '2018-12-31';

SELECT COUNT(DISTINCT o.order_id) AS total_orders
FROM sales.orders AS o
INNER JOIN sales.order_items AS oi
    ON o.order_id = oi.order_id
    WHERE order_date BETWEEN '2018-01-01' AND '2018-12-31';

  --2.7. Think About It: CROSS JOIN is often considered dangerous
 --because it can accidentally produce millions of rows from two innocent-looking tables.
 --Under what real circumstances would you deliberately want a CROSS JOIN,and how would you guard against using one by accident,
 --for example, by forgetting an ON clause that was meant to be there?--

   A cross join is useful when we need every possible combination of rows, such as combining all product colors with sizes.