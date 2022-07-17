-- Show first 20 rows of sales table
select *
from sales limit 20;

-- Show first 20 rows of employees table
select *
from employees

-- Study Case 1

-- Task 1
-- Show sales records of products with prices higher than Rp. 11,000/kg, only from stores 3, 4, and 5!

-- Study Case 1 - Task 1 - Query 1 
select 
	*,
	quantity * price_per_kg revenue
from sales
where
   price_per_kg > 11000 and
   store_city_id in (3, 4, 5)
order by purchase_date asc;

-- Study Case 1 - Task 1 - Query 2 (Group by Product in each Store)
select
	store_city_id,
	product_name,
	sum(quantity) total_qty,
	price_per_kg,
	sum(quantity * price_per_kg) revenue
from sales
where 
	price_per_kg > 11000 and
	store_city_id in (3, 4, 5)
group by 1, 2, 4
order by 1, 5 desc;

-- Study Case 1 - Task 1 - Query 3 (Group by Product)
select
	product_name,
	sum(quantity) total_qty,
	price_per_kg,
	sum(quantity * price_per_kg) revenue
from sales
where 
	price_per_kg > 11000 and
	store_city_id in (3, 4, 5)
group by 1, 3
order by 4 desc;

-- Study Case 1 - Task 1 - Query 4 (Group by Store)
select
	store_city_id,
	COUNT(quantity) total_transaction,
	sum(quantity) total_qty,
	sum(quantity * price_per_kg) revenue
from sales
where 
	price_per_kg > 11000 and
	store_city_id in (3, 4, 5)
group by 1
order by 3 desc;

-- Task 2
-- Show sales record after Eid Al-Fitr 2022!

-- Study Case 1 - Task 2 - Query 1
select 
	*,
	quantity * price_per_kg revenue
from sales
where purchase_date > '2022-05-02'
order by purchase_date asc;

-- Study Case 1 - Task 2 - Query 2 (Group by Product)
select
	product_name,
	sum(quantity) total_qty,
	price_per_kg,
	sum(quantity * price_per_kg) revenue
from sales
where purchase_date > '2022-05-02'
group by 1, 3
order by 2 desc;

-- Study Case 1 - Task 2 - Query 3 (Group by Store)
select
	store_city_id,
	count(quantity) total_transaction,
	sum(quantity) total_quantity,
	sum(quantity * price_per_kg) revenue
from sales
where purchase_date > '2022-05-02'
group by 1
order by 3 desc;

-- Task 3
-- Show Mangga and Jeruk sales records in stores except store 1, 6, and 7!

-- Study Case 1 - Task 3 - Query 1
select 
	*,
	quantity * price_per_kg revenue
from sales
where
	product_name in ('Mangga', 'Jeruk') and 
	store_city_id not in (1, 6, 7)
order by purchase_date asc;

-- Study Case 1 - Task 3 - Query 2 (Group by Store)
select
	store_city_id,
	count(quantity) total_transaction,
	sum(quantity) total_quantity,
	sum(quantity * price_per_kg) revenue
from sales
where
	product_name in ('Mangga', 'Jeruk') and 
	store_city_id not in (1, 6, 7)
group by 1
order by 4 desc;

-- Study Case 1 - Task 3 - Query 3 (Group by Product)
select 
	product_name,
	count(quantity) transaction,
	sum(quantity) quantity,
	sum(quantity * price_per_kg)  revenue
from sales
where
	product_name in ('Mangga', 'Jeruk') and 
	store_city_id not in (1, 6, 7)
group by 1
order by 4 desc;

-- Task 4
-- Display the list of employees and their respective salaries in 2021!

-- Study Case 1 - Task 4 - Query 1
select 
	first_name, 
    last_name, 
    email, 
    department, 
    hire_date, 
    salary_2021 
from employees
order by salary_2021 desc;

-- Study Case 1 - Task 4 - Query 2 (Group by Department)
select 
    department, 
    count(salary_2021) num_of_employee,
    round(avg(salary_2021)) average_salary_2021
from employees
group by 1
order by 3 desc;

-- Study Case 1 - Task 4 - Query 3 (Group by Store)
select 
    store_city_id, 
    count(salary_2021) num_of_employee,
    round(avg(salary_2021)) average_salary_2021
from employees
group by 1
order by 3 desc;

-- Task 5
-- Display the records of employees who work in store 3, 4, & 7 and have a salary above $5000 in 2022!

-- Study Case 1 - Task 5 - Query 1
select 
	first_name, 
    last_name,
    department, 
  	salary_2022
from employees
where 
	store_city_id in (3, 4, 7) and 
	salary_2022 > 5000
order by first_name asc, last_name asc;

-- Study Case 1 - Task 5 - Query 2 (Group by Department)
select 
    department,
    count(first_name) num_of_employee,
  	round(avg(salary_2022)) avg_salary_2022
from employees
where 
	store_city_id in (3, 4, 7) and 
	salary_2022 > 5000
group by 1
order by 3 desc;

-- Study Case 1 - Task 5 - Query 3 (Group by Store)
select 
    store_city_id,
    count(first_name) num_of_employee,
  	round(avg(salary_2022)) avg_salary_2022,
  	sum(salary_2022) total_salary_2022
from employees
where 
	store_city_id in (3, 4, 7) and 
	salary_2022 > 5000
group by 1
order by 1 asc;

-- Study Case 2

-- Task 1
-- Show the total quantity of Mangga and Apel sold for three weeks after Eid al-Fitr 2022!

-- Study Case 2 - Task 1 - Query 1
select
	product_name, 
	COUNT(quantity) num_of_transaction,
	SUM(quantity) total_qty, 
	SUM(quantity * price_per_kg) revenue
FROM sales
where 
	product_name in('Mangga', 'Apel') and 
	purchase_date between '2022-05-02' and date_add('2022-05-02', interval 3 week)
group by 1;

-- Task 2
-- Show all employees who work in Bali and Yogyakarta region!

-- Study Case 2 - Task 2 - Query 1
select
	e.first_name,
	e.last_name,
	e.department,
	e.salary_2022,
	r.region
from 
	employees e,
	region r 
where 
	e.store_city_id = r.store_city_id and 
	e.store_city_id in (select store_city_id from region where region in ('Bali', 'Yogyakarta'))
order by 1, 2;

-- Study Case 2 - Task 2 - Query 2 (Group by Region)
select
	r.region,
	count(e.employee_id) num_of_employee,
	ROUND(avg(e.salary_2022)) avg_salary_2022
from 
	employees e,
	region r 
where 
	e.store_city_id = r.store_city_id and 
	e.store_city_id in (select store_city_id from region where region in ('Bali', 'Yogyakarta'))
group by 1
order by 2 desc;

-- Task 3
-- Show total revenue from the sale of fruit categorized into two categories 'Outside Java' and 'Java' area based on the location;
-- for example, Bandung is included in the island of 'Java'.

-- Study Case 2 - Task 3 - Query 1
select
	case
		when store_city_id in (
			select store_city_id 
			from region 
			where region in ('Yogyakarta', 'Jawa Timur', 'Jawa Barat', 'Jawa Tengah', 'Bandung', 'Jakarta')) then 'Java'
		else 'Outside Java'
	end as island,
	sum(quantity * price_per_kg) revenue
from 
	sales
group by 1;