with cte1 as(
select customer_id,node_id,start_date,end_date,datediff(end_date,start_date) as difference
from customer_nodes
where end_date not regexp "^9999"
group by customer_id,start_date,end_date,node_id
order by difference),
cte2 as(
select *,row_number() over (order by difference) as row_num
from cte1)
select "median" as summary,difference
from cte2
where row_num=round(((select max(row_num)/2 from cte2)),0)
union
(with cte3 as(
select customer_id,node_id,start_date,end_date,datediff(end_date,start_date) as difference
from customer_nodes
where end_date not regexp "^9999"
group by customer_id,start_date,end_date,node_id
order by difference),
cte4 as (select *,round(percent_rank() over (order by difference)*100,0) as percentile
from cte3)
select '80 th percentile' as summary,(select distinct difference from cte4 where percentile in (80)) as percentile
from cte4
where percentile in (80))
union
(select '95 th percentile' as summary ,(select distinct difference from cte4 where percentile in (96)) as percentile
from cte4
where percentile in (96))






