set @datea=(select join_date from members where customer_id="A");
set @dateb=(select join_date from members where customer_id="B");
select customer_id,sum(total_points) as total_points
from(
select customer_id,sum(points) as total_points
from
(select  customer_id,price*20 as points
from sales ss
join members using (customer_id)
join menu using (product_id)
where (order_date between (@datea)  and date_add(@datea,interval 6 day)) and customer_id="A"
)as test group by customer_id
union
select customer_id,sum(points) as total_points
from
(select customer_id,price*20 as points
from sales ss
join members using (customer_id)
join menu using (product_id)
where (order_date between (@dateb)  and date_add(@dateb,interval 6 day)) and customer_id="B"
group by customer_id)as test1 group by customer_id
union
select customer_id,sum(points) as total_points
from(
select customer_id,
case 
when product_name="sushi" then 20*(select price from menu where product_name="sushi")
when product_name="ramen" then 10*(select price from menu where product_name="ramen")
when product_name="curry" then 10*(select price from menu where product_name="curry")
end as points
from sales
join members using (customer_id)
join menu using (product_id)
where order_date between date_add(@datea,interval 6 day) and "29-01-31" and customer_id ="A") as test4
group by test4.customer_id
union
select customer_id,sum(points) as total_points
from(
select customer_id,
case 
when product_name="sushi" then 20*(select price from menu where product_name="sushi")
when product_name="ramen" then 10*(select price from menu where product_name="ramen")
when product_name="curry" then 10*(select price from menu where product_name="curry")
end as points
from sales
join members using (customer_id)
join menu using (product_id)
where order_date between date_add(@dateb,interval 6 day) and "29-01-31" and customer_id ="B"
) as test3
group by test3.customer_id) as test5
group by test5.customer_id



