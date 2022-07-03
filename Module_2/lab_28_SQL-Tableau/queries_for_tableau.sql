use employees_mod;

select * from t_employees;

select distinct(year(hire_date)) from t_employees;

select * from t_dept_emp;

# 2. Create a visualization that provides a breakdown between the male and female employees working in the company each year,
# starting from 1990. 

select year(d.from_date) as year, e.gender, count(e.emp_no) as emp_count
from t_employees e
join t_dept_emp d
on e.emp_no = d.emp_no

group by year, e.gender
having year >= 1990
order by year asc;

# 3. Compare the number of male managers to the number of female managers from different departments for each year, starting from
# 1990.

select * from t_dept_manager;
select * from t_departments;
select * from t_dept_emp;
select * from t_employees;

# check if managers are in t_dept_emp
select d.hire_date, e.from_date
from t_employees d
join t_dept_manager e
on d.emp_no = e.emp_no;


select year(d.from_date) as year,
d.dept_name as department,
e.gender as gender,
count(d.emp_no) as manag_count
from 
	(select
    t_dept_manager.emp_no, t_dept_manager.from_date, t_departments.dept_name
    from t_dept_manager
    join t_departments
    on t_dept_manager.dept_no = t_departments.dept_no
    ) as d
join t_employees e
on d.emp_no = e.emp_no
group by year, gender
having year >= 1990
order by year asc;

# 4. Compare the average salary of female versus male employees in the entire company until year 2002, and add a filter allowing
#  you to see that per each department.

# start using functions for e.g. select all!!

select * from t_salaries;
select * from t_employees;
select * from t_dept_emp;
select * from t_departments;

select year(de.from_date) as year, d.dept_name as department, e.gender as gender, round(avg(s.salary),2) as avg_salary
from 
	t_salaries s
		join
	t_employees e on s.emp_no = e.emp_no
		join
	t_dept_emp de on e.emp_no = de.emp_no
		join
	t_departments d on de.dept_no = d.dept_no
    
group by year, department, gender
having year <= 2002
order by year asc;

# 5. Create an SQL stored procedure that will allow you to obtain the average male and female salary per department within a
#  certain salary range. Let this range be defined by two values the user can insert when calling the procedure. Finally,
#  visualize the obtained result-set in Tableau as a double bar chart.


DELIMITER $$
create procedure sal_info(in minrange int, 
in maxrange int)
BEGIN 
		select d.dept_name as department,
        e.gender as gender,
        round(avg(s.salary),2) as avgsalary
		from 
			t_salaries s
				join
			t_employees e on s.emp_no = e.emp_no
				join
			t_dept_emp de on e.emp_no = de.emp_no
				join
			t_departments d on de.dept_no = d.dept_no
		where s.salary >= minrange
		and s.salary <= maxrange
        group by department, gender;
END $$
DELIMITER ;
select max(salary) from t_salaries;
select min(salary) from t_salaries;

call sal_info(40000,70000);
    

    

