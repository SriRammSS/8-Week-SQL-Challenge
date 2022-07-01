with cte1 as(select customer_id,monthname(txn_date) as month_name,txn_type,count(customer_id) as cnt_p
from customer_transactions
where txn_type="purchase"
group by month_name,customer_id),
cte2 as(select customer_id,monthname(txn_date) as month_name,txn_type,count(customer_id) as cnt_w
from customer_transactions
where txn_type="withdrawal"
group by month_name,customer_id),
cte3 as(select customer_id,monthname(txn_date) as month_name,txn_type,count(customer_id) as cnt_d
from customer_transactions
where txn_type="deposit"
group by month_name,customer_id),
cte4 as (
select cte1.customer_id,cte1.month_name,cnt_p,cnt_w,cnt_d
from cte1
join cte2 on cte1.customer_id=cte2.customer_id and cte1.month_name=cte2.month_name
join cte3 on cte1.customer_id=cte3.customer_id and cte1.month_name=cte3.month_name
where cnt_d>1 and (cnt_w > 1 or cnt_p > 1))
select cte4.month_name,count(customer_id) as people
from cte4
group by month_name




