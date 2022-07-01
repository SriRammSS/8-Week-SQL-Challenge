with cte1 as(
select category_id,category_name,ss.prod_id as product_id,pd.product_name as product_name,(ss.qty*ss.price) as amount,ss.qty,
segment_id,segment_name
from sales ss
join product_details pd on ss.prod_id=pd.product_id),
cte2 as (
select category_id,category_name,segment_id,product_name,segment_name,sum(qty) total_quantity,sum(amount) as total_amount
from cte1
group by category_id,product_name
order by total_amount desc),
cte3 as(
select * ,row_number() over (partition by category_id order by total_amount desc) as rn
from cte2)
select category_id,category_name,product_name,total_quantity,total_amount
from cte3
where rn=1