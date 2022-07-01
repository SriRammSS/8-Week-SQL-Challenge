with cte1 as
(select pizza_id,group_concat(topping_name) as toppings
from pizza_recipes pr
join pizza_toppings pt on pr.toppings=pt.topping_id
group by pizza_id),
cte2 as(
select cs.pizza_id,pizza_name,pt.topping_name as extras,pp.topping_name as exclusions
from customer_orders cs
left join pizza_names ps on cs.pizza_id=ps.pizza_id
left join pizza_toppings pt on pt.topping_id=cs.extras
left join pizza_toppings pp on pp.topping_id=cs.exclusions)
select cte2.order_id,
case 
when cte2.extras is null and cte2.exclusions is null then concat(pizza_name,":",toppings)
when cte2.extras is not null and cte2.exclusions is null then concat(pizza_name,':',cte2.extras,",",toppings)
when cte2.extras is null and cte2.exclusions is not null then concat(pizza_name,":",cte2.exclusions,",",toppings)
when cte2.extras is not null and cte2.exclusions is not null then concat(pizza_name,":",cte2.extras,",",cte2.exclusions,",",toppings)
else null
end as final
from cte2,cte1
where cte2.pizza_id=cte1.pizza_id

