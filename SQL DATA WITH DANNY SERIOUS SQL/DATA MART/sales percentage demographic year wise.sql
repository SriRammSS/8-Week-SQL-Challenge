with cte1 as(
select calendar_year,sum(sales) as tsm
from clean_weekly_sales
group by calendar_year)
select cs.calendar_year,demographic,round((sum(cs.sales)/cte1.tsm*100),2)as percentage
from clean_weekly_sales cs
join cte1 on cs.calendar_year=cte1.calendar_year 
group by cs.calendar_year,demographic
order by cs.calendar_year,cs.demographic

