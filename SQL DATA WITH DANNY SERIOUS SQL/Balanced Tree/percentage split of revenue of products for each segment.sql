with cte1 as(
select ss.prod_id as product_id,pd.product_name as product_name,(ss.qty*ss.price) as amount,ss.qty,
segment_id,segment_name
from sales ss
join product_details pd on ss.prod_id=pd.product_id),
cte2 as(
select segment_id,segment_name,product_name,sum(qty) total_quantity,sum(amount) as total_amount
from cte1
group by segment_name,product_name
order by total_amount desc)
select segment_id,segment_name,product_name,total_quantity,total_amount,round(100*(total_amount/sum(total_amount) over (partition by segment_name)),2) 
as percentage_split
from cte2
group by segment_id,product_name
order by segment_id
