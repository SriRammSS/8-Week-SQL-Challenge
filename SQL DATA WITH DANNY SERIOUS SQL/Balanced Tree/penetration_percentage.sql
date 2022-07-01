set @a=(select count(distinct txn_id) from sales);
select product_id,product_name,round((count(txn_id)/@a )* 100,2)as penet_percent
from sales ss
join product_details pd on ss.prod_id=pd.product_id
group by product_id
order by penet_percent desc