set @a = (select count(distinct customer_id) from subscriptions);

with cte1 as (select customer_id,plan_id,plan_name,
row_number() over (partition by customer_id) as rowrank
from subscriptions
join plans using (plan_id))
select count(*) as churn,round(((count(*)/ @a)*100),0) as percentage
from cte1 where plan_id=4 and rowrank=2