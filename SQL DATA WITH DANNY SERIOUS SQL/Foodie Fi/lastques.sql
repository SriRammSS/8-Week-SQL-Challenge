with cte1 as(
select *
from subscriptions
join plans using (plan_id)
where year(start_date)="2020" and plan_name="pro monthly"),
cte2 as (select *
from subscriptions
join plans using (plan_id)
where year(start_date)="2020" and plan_name="basic monthly"),
cte3 as(
select cte1.customer_id,cte1.start_date as prodate,cte2.start_date as basicdate
from cte1,cte2
where cte1.customer_id=cte2.customer_id)
select count(*) as no_of_people
from cte3
where basicdate > prodate

