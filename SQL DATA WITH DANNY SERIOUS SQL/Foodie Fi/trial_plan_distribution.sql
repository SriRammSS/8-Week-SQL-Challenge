create view trial_distribution as
select monthname(start_date) as month,count(customer_id) as distrubution
from subscriptions
join plans using (plan_id)
where plan_name="trial"
group by month(start_date)
order by start_date