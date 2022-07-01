select (max(duration)-min(duration)) as difference_in_time
from runner_orders
join customer_orders using (order_id)
where duration is not null

