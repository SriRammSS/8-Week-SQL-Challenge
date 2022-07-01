set @a=(select sum(sales) from clean_weekly_sales);
SELECT age_band ,demographic,round((sum(sales)/@a)*100,0 )as percentage
from clean_weekly_sales
group by age_band,demographic
order by percentage 
desc