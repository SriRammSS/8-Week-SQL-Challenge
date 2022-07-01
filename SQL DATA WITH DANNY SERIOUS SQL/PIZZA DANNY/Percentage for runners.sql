with cte1 as (select runner_id,count(distinct order_id) as total
from runner_orders s
join customer_orders using (order_id)
group by runner_id),
cte2 as(
select cte1.runner_id,cte1.total as total,count(distinct order_id) as delivered
from runner_orders ro ,cte1
where duration is not null and cte1.runner_id=ro.runner_id
group by cte1.runner_id)
select cte2.runner_id,((delivered/total)*100) as percentage
from cte2


