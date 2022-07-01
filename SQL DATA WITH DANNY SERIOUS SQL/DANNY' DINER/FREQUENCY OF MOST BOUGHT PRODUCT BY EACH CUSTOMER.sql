create view most_bought_product_and_customer_frequency as
select customer_id,product_id,product_name,count(product_id) as frequency
from sales ss
join menu mu using (product_id)
where product_id=(select product_id from sales group by product_id order by count((product_id)) desc limit 1)
group by customer_id
