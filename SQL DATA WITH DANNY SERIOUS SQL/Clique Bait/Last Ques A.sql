with cte1 as (select visit_id,event_name,page_name,product_category,
case 
when event_name="page view" and page_name= "checkout"then 1
when event_name="purchase" then 1
else 0
end as encoding
from events
join event_identifier using (event_type)
join page_hierarchy using (page_id)),
cte2 as (
select  visit_id,product_category ,sum(encoding) as bfe
from cte1 
group by visit_id),
cte3 as (
select visit_id 
from cte2 
where bfe=2),
cte4 as(
select page_name
from cte1
join cte3 on cte3.visit_id=cte1.visit_id
where event_name="Add to Cart")
select page_name,count(page_name) as count
from cte4 
group by page_name
order by count desc
limit 3

