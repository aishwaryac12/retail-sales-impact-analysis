select * from data_mart.weekly_sales limit 5;

-- Unique Regions - South America, Asia, Oceania, Europe, Canada, Africa, USA
select distinct region from data_mart.weekly_sales;

-- Unique Platfroms - Shopify, Retail
select distinct platform from data_mart.weekly_sales;

-- Unique Segment - C3, C2, F2, C4, F1, F3, C1
select distinct segment from data_mart.weekly_sales;

-- Unique Customer Type - Guest, New, Existing
select distinct customer_type from data_mart.weekly_sales;




-- 1. DATA CLEANSING STEPS

-- 1.1. Convert the week_date to a DATE format
-- pg_typeof(): to check the data type of a col
select pg_typeof(week_date) from data_mart.weekly_sales limit 1;

select to_date(week_date, 'DD-MM-YY') from data_mart.weekly_sales limit 5;

-- 'USING' is used with ALTER TABLE ... ALTER COLUMN ... to transform the current data to new type.
alter table data_mart.weekly_sales
alter column week_date type DATE
using TO_DATE(week_date, 'DD-MM-YY');

select pg_typeof(week_date) from data_mart.weekly_sales limit 1;


-- 1.2. Add a week_number as the second column for each week_date value, 
--for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc
select week_date, extract(week from week_date) as week_num
from data_mart.weekly_sales;

-- week_number column added
alter table data_mart.weekly_sales
add column week_number integer; 

-- updated the data in week_number with appropriate logic
update data_mart.weekly_sales
set week_number = extract(week from week_date);

-- 1.3. Add a month_number with the calendar month for each week_date value as the 3rd column

select week_date, extract(month from week_date)as week_num
from data_mart.weekly_sales;

alter table data_mart.weekly_sales
add column month_number integer;

update data_mart.weekly_sales
set month_number = extract(month from week_date);

-- 1.4. Add a calendar_year column as the 4th column containing either 2018, 2019 or 2020 values
select distinct extract(year from week_date) as year
from data_mart.weekly_sales;

alter table data_mart.weekly_sales
add column calendar_year integer;

update data_mart.weekly_sales
set calendar_year = extract(year from week_date);

-- 1.5. Add a new column called age_band after the original segment column using the following mapping on the number inside the segment value: 1 Young Adults, 2 Middle Aged, 3 or 4 Retirees

-- checked the data type - character varying
select pg_typeof(segment) from data_mart.weekly_sales limit 1;

select segment, case 
	when substring(segment, 2)='1' then 'Young Adults'
	when substring(segment, 2)='2' then 'Middle Aged'
	when substring(segment, 2) in ('3', '4') then 'Retirees'
	end
from data_mart.weekly_sales;

alter table data_mart.weekly_sales
add column age_band varchar(25);

update data_mart.weekly_sales
set age_band = case 
	when substring(segment, 2)='1' then 'Young Adults'
	when substring(segment, 2)='2' then 'Middle Aged'
	when substring(segment, 2) in ('3', '4') then 'Retirees'
end;

select distinct age_band from data_mart.weekly_sales;

-- 1.6. Add a new demographic column using the following mapping for the first letter in the segment values: C	Couples, F	Families

select substring(segment, 1, 1) from data_mart.weekly_sales;

alter table data_mart.weekly_sales
add column demographics varchar;

update data_mart.weekly_sales
set demographics = case
	when substring(segment, 1, 1)='C' then 'Couples'
	when substring(segment, 1, 1)='F' then 'Families'
	else null
end;

select distinct demographics from data_mart.weekly_sales;

-- 1.7. Ensure all null string values with an "unknown" string value in the original segment column as well as the new age_band and demographic columns

-- replaced null with unknown in segment column
select segment, count(segment)
from data_mart.weekly_sales
group by segment;

select segment from data_mart.weekly_sales where segment = 'null';

alter table data_mart.weekly_sales
alter column segment type varchar;

update data_mart.weekly_sales
set segment = 'unknown'
where segment = 'null';


-- replaced null with unknown in age_band column
select age_band, count(age_band)
from data_mart.weekly_sales
group by age_band;

select age_band from data_mart.weekly_sales where age_band is null;

update data_mart.weekly_sales
set age_band='unknown'
where age_band is null;


-- replaced null with unknown in demographics column
select demographics, count(demographics)
from data_mart.weekly_sales
group by demographics;

select demographics, count(1) from data_mart.weekly_sales where demographics is null group by demographics;

update data_mart.weekly_sales
set demographics = 'unknown'
where demographics is null;


-- 1.8. Generate a new avg_transaction column as the sales value divided by transactions rounded to 2 decimal places for each record
alter table data_mart.weekly_sales
alter column transactions type numeric;

alter table data_mart.weekly_sales
alter column sales type numeric;

select transactions, sales, round((sales/transactions), 2) as avg_transaction
from data_mart.weekly_sales;

alter table data_mart.weekly_sales
add column avg_transaction numeric;

update data_mart.weekly_sales
set avg_transaction = round((sales/transactions), 2);