with cte1 as(
select ss.prod_id as product_id,pd.product_name as product_name,(ss.qty*ss.price) as amount,ss.qty,round(((ss.qty*ss.price)*(discount/100)),2)as discount_amount,
segment_id,segment_name
from sales ss
join product_details pd on ss.prod_id=pd.product_id)
select segment_id,segment_name,sum(qty) total_quantity,sum(amount) as total_amount,sum(discount_amount) as discount_amount
from cte1
group by segment_id
order by segment_id