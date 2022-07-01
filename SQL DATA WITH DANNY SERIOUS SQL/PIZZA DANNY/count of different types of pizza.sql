select customer_id,pizza_name,count(pizza_id)
from customer_orders
join pizza_names using (pizza_id)
group by customer_id,pizza_id
order by customer_id