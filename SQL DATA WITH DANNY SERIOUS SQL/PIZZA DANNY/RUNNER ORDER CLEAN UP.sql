create table runner_ordersc as
select order_id,runner_id,
case 
when distance in ("null") then null
when distance regexp "km$" then trim("km" from distance)
else distance 
end as distance,
case
when pickup_time in ("null") then null
else pickup_time
end as pickup_time,
case 
when cancellation is null or cancellation in ('null') then ' '
else cancellation
end as cancellation,
case
when  duration like "null" then null
else left (duration,2)
end as duration
from runner_orders


