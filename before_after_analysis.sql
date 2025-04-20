-- 3. BEORE AND AFTER ANALYSIS

-- 3.1. What is the total sales for the 4 weeks before and after 2020-06-15? What is the growth or reduction rate in actual values and percentage of sales?

-- total_before_sales = 2345878357, percentage = 5.76
select sum(sales) as total_before_sales, round(sum(sales)*100/(select sum(sales) from data_mart.weekly_sales), 2) as sales_percentage
from data_mart.weekly_sales
where week_date between '2020-05-18' and '2020-06-14';

-- total_after_sales = 2318994169, percentage = 5.69
select sum(sales) as total_after_sales, round(sum(sales)*100/(select sum(sales) from data_mart.weekly_sales), 2) as sales_percentage
from data_mart.weekly_sales
where week_date between '2020-06-15' and '2020-07-12';

-- Difference between total_before_sales and total_after_sales: 26884188
select (
	(select sum(sales) as total_before_sales
	from data_mart.weekly_sales
	where week_date between '2020-05-18' and '2020-06-14') 
	-
	(select sum(sales) as total_before_sales
	from data_mart.weekly_sales
	where week_date between '2020-06-15' and '2020-07-12')
) as change_in_sales;


-- 3.2. What about the entire 12 weeks before and after?

-- total_before_sales = 4123607373, percentage = 10.12
select sum(sales) as total_before_sales, round(sum(sales)*100/(select sum(sales) from data_mart.weekly_sales), 2) as sales_percentage
from data_mart.weekly_sales
where week_date between '2020-04-23' and '2020-06-14';

-- total_after_sales = 6973947753, percentage = 17.12
select sum(sales) as total_after_sales, round(sum(sales)*100/(select sum(sales) from data_mart.weekly_sales), 2) as sales_percentage
from data_mart.weekly_sales
where week_date between '2020-06-15' and '2020-09-07';

-- Difference between total_before_sales and total_after_sales: -2850340380
select (
	(select sum(sales) as total_before_sales
	from data_mart.weekly_sales
	where week_date between '2020-04-23' and '2020-06-14') 
	-
	(select sum(sales) as total_before_sales
	from data_mart.weekly_sales
	where week_date between '2020-06-15' and '2020-09-07')
) as change_in_sales;


-- 3.3. How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?


-- 3.3.1.  What is the total sales for the 4 weeks before and after 2018-06-15? What is the growth or reduction rate in actual values and percentage of sales? 

-- total_before_sales = 2125140809, percentage = 5.22
select sum(sales) as total_before_sales, round(sum(sales)*100/(select sum(sales) from data_mart.weekly_sales), 2) as sales_percentage
from data_mart.weekly_sales
where week_date between '2018-05-18' and '2018-06-14';

-- total_after_sales = 2129242914, percentage = 5.23
select sum(sales) as total_after_sales, round(sum(sales)*100/(select sum(sales) from data_mart.weekly_sales), 2) as sales_percentage
from data_mart.weekly_sales
where week_date between '2018-06-15' and '2018-07-12';

-- Difference between total_before_sales and total_after_sales: -4102105
select (
	(select sum(sales) as total_before_sales
	from data_mart.weekly_sales
	where week_date between '2018-05-18' and '2018-06-14') 
	-
	(select sum(sales) as total_before_sales
	from data_mart.weekly_sales
	where week_date between '2018-06-15' and '2018-07-12')
) as change_in_sales;


-- 3.3.2. What about the entire 12 weeks before and after in 2018?

-- total_before_sales = 4262709703, percentage = 10.46
select sum(sales) as total_before_sales, round(sum(sales)*100/(select sum(sales) from data_mart.weekly_sales), 2) as sales_percentage
from data_mart.weekly_sales
where week_date between '2018-04-23' and '2018-06-14';

-- total_after_sales = 6500818510, percentage = 15.96
select sum(sales) as total_after_sales, round(sum(sales)*100/(select sum(sales) from data_mart.weekly_sales), 2) as sales_percentage
from data_mart.weekly_sales
where week_date between '2018-06-15' and '2018-09-07';

-- Difference between total_before_sales and total_after_sales: -2238108807
select (
	(select sum(sales) as total_before_sales
	from data_mart.weekly_sales
	where week_date between '2018-04-23' and '2018-06-14') 
	-
	(select sum(sales) as total_before_sales
	from data_mart.weekly_sales
	where week_date between '2018-06-15' and '2018-09-07')
) as change_in_sales;


-- 3.3.3.  What is the total sales for the 4 weeks before and after 2019-06-15? What is the growth or reduction rate in actual values and percentage of sales? 

-- total_before_sales = 2125140809, percentage = 5.22
select sum(sales) as total_before_sales, round(sum(sales)*100/(select sum(sales) from data_mart.weekly_sales), 2) as sales_percentage
from data_mart.weekly_sales
where week_date between '2019-05-18' and '2019-06-14';

-- total_after_sales = 2129242914, percentage = 5.23
select sum(sales) as total_after_sales, round(sum(sales)*100/(select sum(sales) from data_mart.weekly_sales), 2) as sales_percentage
from data_mart.weekly_sales
where week_date between '2019-06-15' and '2019-07-12';

-- Difference between total_before_sales and total_after_sales: -4102105
select (
	(select sum(sales) as total_before_sales
	from data_mart.weekly_sales
	where week_date between '2019-05-18' and '2019-06-14') 
	-
	(select sum(sales) as total_before_sales
	from data_mart.weekly_sales
	where week_date between '2019-06-15' and '2019-07-12')
) as change_in_sales;


-- 3.3.4. What about the entire 12 weeks before and after in 2019?

-- total_before_sales = 3980833222, percentage = 9.77
select sum(sales) as total_before_sales, round(sum(sales)*100/(select sum(sales) from data_mart.weekly_sales), 2) as sales_percentage
from data_mart.weekly_sales
where week_date between '2019-04-23' and '2019-06-14';

-- total_after_sales = 6862646103, percentage = 16.84
select sum(sales) as total_after_sales, round(sum(sales)*100/(select sum(sales) from data_mart.weekly_sales), 2) as sales_percentage
from data_mart.weekly_sales
where week_date between '2019-06-15' and '2019-09-07';

-- Difference between total_before_sales and total_after_sales: -2881812881
select (
	(select sum(sales) as total_before_sales
	from data_mart.weekly_sales
	where week_date between '2019-04-23' and '2019-06-14') 
	-
	(select sum(sales) as total_before_sales
	from data_mart.weekly_sales
	where week_date between '2019-06-15' and '2019-09-07')
) as change_in_sales;
