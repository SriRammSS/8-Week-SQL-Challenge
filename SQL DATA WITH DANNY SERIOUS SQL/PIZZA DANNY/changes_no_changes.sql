(with cte1 as (select *
from runner_orders
join customer_orders using (order_id)
where duration is not null)
select customer_id,count(*) as pizza,'No changes' as changes
from cte1 where exclusions in (""," ")and extras in (" ","")
group by customer_id)
union
(with cte1 as (select *
from runner_orders
join customer_orders using (order_id)
where duration is not null)
select customer_id,count(*) as pizza,'With Changes' as changes
from cte1 where exclusions not in (""," ")or extras not in (" ","")
group by customer_id )
order by customer_id





