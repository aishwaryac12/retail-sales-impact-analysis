-- 4. BONUS QUESTION

-- 4.1. Which areas of the business have the highest negative impact in sales metrics performance in 2020 for the 12 week before and after period?

-- 4.1.1. Region
-- FINDINGS: Europe has the smallest change in sales

select region, 
	sum(case when week_date between '2020-04-23' and '2020-06-14' then sales end) as before_sales,
	sum(case when week_date between '2020-06-15' and '2020-09-07' then sales end) as after_sales,
	sum(case when week_date between '2020-06-15' and '2020-09-07' then sales end) -
	sum(case when week_date between '2020-04-23' and '2020-06-14' then sales end) as change_in_sales
from data_mart.weekly_sales
group by region
order by change_in_sales desc;

-- 4.1.2. Platform
-- FINDINGS: Shopify has the smallest change in sales

select platform, 
	sum(case when week_date between '2020-04-23' and '2020-06-14' then sales end) as before_sales,
	sum(case when week_date between '2020-06-15' and '2020-09-07' then sales end) as after_sales,
	sum(case when week_date between '2020-06-15' and '2020-09-07' then sales end) -
	sum(case when week_date between '2020-04-23' and '2020-06-14' then sales end) as change_in_sales
from data_mart.weekly_sales
group by platform
order by change_in_sales desc;

-- 4.1.3. age_band
-- FINDINGS: Young Adults has the smallest change in sales

select age_band, 
	sum(case when week_date between '2020-04-23' and '2020-06-14' then sales end) as before_sales,
	sum(case when week_date between '2020-06-15' and '2020-09-07' then sales end) as after_sales,
	sum(case when week_date between '2020-06-15' and '2020-09-07' then sales end) -
	sum(case when week_date between '2020-04-23' and '2020-06-14' then sales end) as change_in_sales
from data_mart.weekly_sales
group by age_band
order by change_in_sales desc;

-- 4.1.4. demographic
-- FINDINGS: Couples has the smallest change in sales

select demographics, 
	sum(case when week_date between '2020-04-23' and '2020-06-14' then sales end) as before_sales,
	sum(case when week_date between '2020-06-15' and '2020-09-07' then sales end) as after_sales,
	sum(case when week_date between '2020-06-15' and '2020-09-07' then sales end) -
	sum(case when week_date between '2020-04-23' and '2020-06-14' then sales end) as change_in_sales
from data_mart.weekly_sales
group by demographics
order by change_in_sales desc;

-- 4.1.5. customer_type
-- FINDINGS: New customers has the smallest change in sales

select customer_type, 
	sum(case when week_date between '2020-04-23' and '2020-06-14' then sales end) as before_sales,
	sum(case when week_date between '2020-06-15' and '2020-09-07' then sales end) as after_sales,
	sum(case when week_date between '2020-06-15' and '2020-09-07' then sales end) -
	sum(case when week_date between '2020-04-23' and '2020-06-14' then sales end) as change_in_sales
from data_mart.weekly_sales
group by customer_type
order by change_in_sales desc;