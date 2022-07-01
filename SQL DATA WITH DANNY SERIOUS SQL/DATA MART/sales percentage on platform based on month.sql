with cte1 as(
select calendar_year,month_number,sum(sales) as tsm
from clean_weekly_sales
group by calendar_year,month_number)
select cs.calendar_year,cs.platform,cs.month_number,(sum(cs.sales)/cte1.tsm*100) as percentage
from clean_weekly_sales cs
join cte1 on cs.calendar_year=cte1.calendar_year and cs.month_number=cte1.month_number
group by cs.calendar_year,cs.month_number,cs.platform
