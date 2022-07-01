with cte1 as(select *
from subscriptions
where plan_id=0),
cte2 as(select *
from subscriptions where plan_id=3),
cte3 as(select cte1.customer_id,cte1.start_date as trial_date,cte2.start_date as annual_date
from cte1,cte2
where cte1.customer_id=cte2.customer_id),
cte4 as (select datediff(cte3.annual_date,cte3.trial_date) as trans_days
from cte3),
cte5 as (select case
WHEN trans_days< 31 THEN '0-30 days'
WHEN trans_days BETWEEN 31 AND 60 THEN '31-60 days'
WHEN trans_days BETWEEN 61
AND 90 THEN '61-90 days'
WHEN trans_days BETWEEN 91
AND 120 THEN '91-120 days'
WHEN trans_days BETWEEN 121
AND 150 THEN '121-150 days'
WHEN trans_days BETWEEN 151
AND 180 THEN '151-180 days'
WHEN trans_days BETWEEN 181
AND 210 THEN '181-210 days'
WHEN trans_days BETWEEN 211
AND 240 THEN '211-240 days'
WHEN trans_days BETWEEN 241
AND 270 THEN '241-270 days'
WHEN trans_days BETWEEN 271
AND 300 THEN '271-300 days'
WHEN trans_days BETWEEN 301
AND 330 THEN '301-330 days'
WHEN trans_days BETWEEN 331
AND 360 THEN '331-360 days'
WHEN trans_days> 360 THEN '360+ days' 
else null
end as cats,trans_days
from cte4)
select cte5.cats,count(cte5.cats) as counts,round(avg(cte5.trans_days)) as average_days
from cte5
group by cte5.cats
order by (CASE
WHEN cats= '0-30 days' THEN 1
WHEN cats= '31-60 days' THEN 2
WHEN cats= '61-90 days' THEN 3
WHEN cats= '91-120 days' THEN 4
WHEN cats= '121-150 days' THEN 5
WHEN cats= '151-180 days' THEN 6
WHEN cats= '181-210 days' THEN 7
WHEN cats= '211-240 days' THEN 8
WHEN cats= '241-270 days' THEN 9
WHEN cats= '271-300 days' THEN 10
WHEN cats= '301-330 days' THEN 11
WHEN cats= '331-360 days' THEN 12
WHEN cats= '360+ days' THEN 13
END)



