create table customer_ordersc as 
select order_id,customer_id,pizza_id,
case 
when exclusions like ("null") then ' ' 
when exclusions is null then" "
else exclusions 
end as exclusions,
case 
when extras like ("null") then ' '
when extras is null then ' '
else extras
end as extras,
order_time
from customer_orders

