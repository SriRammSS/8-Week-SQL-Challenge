(select customer_id,product_id,product_name,join_date,order_date
from members
left join sales using (customer_id)
join menu using (product_id)
where order_date>=(select join_date from members where customer_id="A") and customer_id="A"
group by customer_id)
union
(select customer_id,product_id,product_name,join_date,order_date
from members
left join sales using (customer_id)
join menu using (product_id)
where order_date>=(select join_date from members where customer_id="B") and customer_id="B"
group by customer_id)



