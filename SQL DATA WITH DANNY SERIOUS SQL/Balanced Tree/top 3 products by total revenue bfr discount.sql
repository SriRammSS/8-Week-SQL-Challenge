with cte1 as(
select ss.prod_id as product_id,pd.product_name as product_name,(ss.qty*ss.price) as amount
from sales ss
join product_details pd on ss.prod_id=pd.product_id)
select product_id,product_name,sum(amount) as revenue
from cte1
group by product_id
order by revenue desc
limit 3
