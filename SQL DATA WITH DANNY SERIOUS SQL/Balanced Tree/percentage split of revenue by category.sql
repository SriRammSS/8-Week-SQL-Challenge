with cte1 as(
select category_id,category_name,ss.prod_id as product_id,pd.product_name as product_name,(ss.qty*ss.price) as amount,ss.qty,
segment_id,segment_name
from sales ss
join product_details pd on ss.prod_id=pd.product_id),
cte2 as(
select category_id,category_name,sum(qty) total_quantity,sum(amount) as total_amount
from cte1
group by category_id
order by total_amount desc)
select category_id,category_name,total_quantity,round(100*(total_amount/sum(total_amount) over()),2) 
as percentage_split
from cte2
group by category_id

