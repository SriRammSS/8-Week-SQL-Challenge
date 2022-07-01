select order_id,count(pizza_id),timediff(pickup_time,order_time) as pickup_duration
from runner_orders
join customer_orders using(order_id)
where duration is not null
group by order_id;
