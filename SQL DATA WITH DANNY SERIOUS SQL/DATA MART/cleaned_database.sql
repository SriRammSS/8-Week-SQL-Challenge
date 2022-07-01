CREATE TABLE clean_weekly_sales as (
select week_date,week(week_date) as week_number,month(week_date) as month_number,year(week_date) as year,segment,
case 
when segment regexp "1$" then "Young Adult"
when segment regexp "2$" then "Middle Aged"
when segment regexp "3$|4$" then "Retirees"
else "unknown"
end as age_band,
case 
when segment regexp "^F" then "Families"
when segment regexp "^C" then "Couples"
else "unknown"
end as demographic,
transactions,
round((sales/transactions),2) as avg_transaction,
sales
from weekly_sales)
