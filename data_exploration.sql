-- 2. DATA EXPLORATION

-- 2.1. What day of the week is used for each week_date value?
-- FINDINGS: Only Monday is used for each week_date value.

select to_char(week_date, 'Day'), count(1) as day 
from data_mart.weekly_sales
group by to_char(week_date, 'Day');


-- 2.2. What range of week numbers are missing from the dataset?
-- FINDINGS: week numbers 1 to 12 and 37 to 53 are missing.

with weeks_cte as(
	select generate_series(1, 53) as num
),

existing_weeks as(
	select distinct week_number
	from data_mart.weekly_sales
)

select num, week_number from weeks_cte
left join existing_weeks
on weeks_cte.num=existing_weeks.week_number
where week_number is null;


-- 2.3. How many total transactions were there for each year in the dataset?
-- FINDINGS: 2020 year has the max total_transactions of 375813651, followed by 2019 with total_transaction of 365639285 and lastly, 
-- 2018 with total_transaction of 34640640.

select calendar_year, sum(transactions) as total_transactions
from data_mart.weekly_sales
group by calendar_year;


-- 2.4. What is the total sales for each region for each month?
-- FINDINGS: Oceania has the maximum total_sales of 958930687 in 2020/08 and 
-- Europe has the minimum total_sales of 8402183 in 2018/03 across all regions from 2018 to 2020.

select region, calendar_year, month_number, sum(sales) as total_sales
from data_mart.weekly_sales
group by region,calendar_year, month_number
order by calendar_year, month_number;


-- 2.5. What is the total count of transactions for each platform?
-- FINDINGS: Retail has maximum total_transactions, followed by shopify.
-- Customers prefer retail over shopify

select platform, sum(transactions) as total_transactions
from data_mart.weekly_sales
group by platform
order by total_transactions desc;


-- 2.6. What is the percentage of sales for Retail vs Shopify for each month?

with monthly_sales as(
	select calendar_year, month_number, platform, sum(sales) as monthly_sale
	from data_mart.weekly_sales
	group by calendar_year, month_number, platform
),

total_sales as(
	select calendar_year, month_number, sum(sales) as total_sale
	from data_mart.weekly_sales
	group by calendar_year, month_number
)

select m.calendar_year, m.month_number, m.platform, round(m.monthly_sale*100.0/t.total_sale, 2) as percentage_sale
from monthly_sales m
left join total_sales t
on m.calendar_year=t.calendar_year
and m.month_number=t.month_number
order by m.platform, m.calendar_year, m.month_number;


-- 2.7. What is the percentage of sales by demographic for each year in the dataset?

with total_sales as(
	select calendar_year, sum(sales) as yearly_sale
	from data_mart.weekly_sales
	group by calendar_year
),
demographics_sale as(
	select calendar_year, demographics, sum(sales) as sale
	from data_mart.weekly_sales
	group by calendar_year, demographics
)

select d.calendar_year, d.demographics, round(d.sale * 100.0/t.yearly_sale, 2) as percentage_sale
from demographics_sale d
left join total_sales t
on d.calendar_year=t.calendar_year
order by d.calendar_year, percentage_sale desc;


-- 2.8. Which age_band and demographic values contribute the most to Retail sales?

select age_band, demographics, sum(sales) as total_retail_sales
from data_mart.weekly_sales
where platform='Retail'
group by age_band, demographics
order by total_retail_sales desc;


-- 2.9. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?
-- FINDINGS: Retail customers spend around $36 per transaction across 2018 to 2020, whereas, Shopify customers spend around $185 per transaction.

select calendar_year, platform, round(sum(sales)/sum(transactions), 2) as avg_trans_size
from data_mart.weekly_sales
group by calendar_year, platform
order by calendar_year, platform, avg_trans_size desc;