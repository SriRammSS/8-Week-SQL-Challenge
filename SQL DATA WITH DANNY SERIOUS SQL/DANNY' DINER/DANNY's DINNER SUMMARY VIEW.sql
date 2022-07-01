create view summary as
select customer_id,order_date,product_name,price
from sales join menu using (product_id)

