create view points_customer as
select customer_id,sum(points) as points
from (
select customer_id,product_name,price,
case 
when product_name="sushi" then 20*(select price from menu where product_name="sushi")
when product_name="ramen" then 10*(select price from menu where product_name="ramen")
when product_name="curry" then 10*(select price from menu where product_name="curry")
end as points
from sales
left join members using (customer_id)
join menu using (product_id)
)as test
group by test.customer_id
