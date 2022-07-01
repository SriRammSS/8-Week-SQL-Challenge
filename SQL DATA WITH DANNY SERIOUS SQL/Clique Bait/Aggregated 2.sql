with cte1 as (select *
from events
join event_identifier using (event_type)
join page_hierarchy using (page_id)),
cte2 as(
select page_name,count(event_name) as count_of_views
from cte1 
where event_name="Page View"
group by page_name),
cte3 as(
select cte1.page_name as page_name,cte2.count_of_views as count_of_views,count(event_name) as count_of_add
from cte1
join cte2 on cte1.page_name=cte2.page_name
where event_name="Add to Cart"
group by page_name),
cte4 as(
select visit_id,event_name,page_name,product_category,
case 
when event_name="page view" and page_name= "checkout"then 1
when event_name="purchase" then 1
else 0
end as encoding
from events
join event_identifier using (event_type)
join page_hierarchy using (page_id)),
cte5 as (
select  visit_id,product_category ,sum(encoding) as bfe
from cte4
group by visit_id),
cte6 as (
select visit_id 
from cte5
where bfe=2),
cte7 as(
select page_name
from cte4
join cte6 on cte6.visit_id=cte4.visit_id
where event_name="Add to Cart"),
cte8 as(
select page_name,count(page_name) as count_of_purchase
from cte7
group by page_name),
cte9 as (
select cte3.page_name as page_name,cte3.count_of_views as count_of_views,cte3.count_of_add as count_of_add,
cte8.count_of_purchase as count_of_purchase
from cte8 
join cte3 on cte3.page_name=cte8.page_name),
cte10 as(
select page_name,count_of_views,count_of_add,(count_of_add-count_of_purchase) 
as count_of_abonded,count_of_purchase
from cte9
order by page_name)
select ph.product_category,sum(count_of_views) as total_view,sum(count_of_add) as total_added_cart,
sum(count_of_abonded) as total_abonded,
sum(count_of_purchase) as total_purchase
from cte10 
join page_hierarchy ph using (page_name)
group by ph.product_category
order by product_category desc



