## view all records

select *
from employee_demographics;
select *
from employee_salary;
select *
from parks_departments;

## total numbers of employeees

select count(*)  total_employees
from employee_demographics;

## age distribution 

select age, count(*) count
from employee_demographics
group by age
order by age;

## gender counts

select gender, count(*) count
from employee_demographics
group by gender;

## list of occupations

select distinct occupation
from employee_salary;

## youngest employee

select *
from employee_demographics
order by age asc
limit 1;

## oldest employee

select *
from employee_demographics
order by age desc
limit 1;

## staff above 40

select *
from employee_demographics
where age > 40;

## employee born before 1985

select *
from employee_demographics
where year(birth_date) < 1985;

## names starting with A,B, OR cache index

select *
from employee_demographics
where first_name like 'A%'
   or first_name like 'B%'
   or first_name like 'C%';
   
## sort employees by age

select *
from employee_demographics
order by age;
 
 ## min and max salaries
 
 select min(salary) min_salary,
        max(salary) max_salary
from employee_salary;

## avg salary by occupation

select occupation,
       avg(salary) avg_salary
from employee_salary
group by occupation;

## top 5 highest-earning employees

select d.first_name, d.last_name, d.age, d.gender, s.occupation, s.salary
from employee_demographics d
join employee_salary s
   on d.employee_id = s.employee_id
order by s.salary desc
limit 5;

## unified employee report

select d.employee_id, d.first_name, d.last_name, d.age, d.gender, s.salary, s.occupation,p.department_name
from employee_demographics d
left join employee_salary s
   on d.employee_id = s.employee_id
left join parks_departments p
   on s.dept_id = p.department_id;
   
## employees with missing salary 
 
 select d.*
 from employee_demographics d
 left join employee_salary s
    on d.employee_id = s.employee_id
where s.employee_id is null;

## depts without employees

select p.*
from parks_departments p
left join employee_salary s
   on p.department_id = s.dept_id
where s.dept_id is null;

## calculate age group column

select employee_id,
       first_name, 
       last_name, 
       age,
       case
		  when age < 30 then 'Young'
          when age between 30 and 50 then 'Mid-Level'
          else 'Senior'
		end as age_group
from employee_demographics;

## count employees in each age group
select 
   case 
       when age < 30 then 'Young'
       when age between 30 and 50 then 'Mid-Level'
       else 'Senior'
	end as age_group,
    count(*) count
from employee_demographics
group by age_group;

## avg salary per age agroup

select age_group,
      avg(salary) avg_salary
from (
    select d.employee_id,
           s.salary,
           case
               when age < 30 then 'Young'
				when age between 30 and 50 then 'Mid-Level'
           else 'Senior'
	end as age_group
from employee_demographics d
join employee_salary s
   on d.employee_id = s.employee_id
) as grouped
group by age_group;

## CTE for salary cost per occupation

with salary_cte as (
     select occupation,
            sum(salary) total_salary,
            avg(salary) avg_salary
	from employee_salary
    group by occupation
)
select *
from salary_cte
where total_salary > 10000;



-- NAME: Oguntula Ifeoluwa
-- TECH_ ALPHA

-- Insight: Fom the data provided, it is evident that the male gender is more heavily represented across the employee table.
-- The highest salary expenditure comes from the CITY MANAGER ROLE. This indicates that leadership and Adimistrative positions account for a significant portion of the Organization's payroll.
-- The Mid-Level age group forms the largest portion of the workforce and its show most employees fall within the middle age bracket.
-- The Mid-Level age group also records the highest average salary. This aligns with expectations since employees wuthin this range uasually posses more experience.
-- The data also highlights that the Animal Control and Library departments currently do not have any empolyees assigned to them and it could sihnal staffing gaps,hiring delays. 

       
