use employees_mod;
# create procedure that returns average salaries of alll employees
DELIMITER $$ 
CREATE PROCEDURE avg_salary()
BEGIN 
        SELECT avg (salary) as average_salary
        from t_salaries;
END$$ 
DELIMITER ;

call avg_salary();

# Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual,
# and returns their employee number.

DELIMITER $$
create procedure emp_info(in firsti varchar(20), 
in lasti varchar(30))
BEGIN 
		select emp_no as employee_numer
		from t_employees
		where first_name = firsti
		and last_name = lasti;
END $$
DELIMITER ;

select * from t_employees;
call emp_info('Saniya','Kalloufi');

# Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, and returns the salary 
# from the newest contract of that employee. Hint: In the BEGIN-END block of this program, you need to declare and use two 
# variables – v_max_from_date that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.
SELECT from_date
FROM t_salaries
;


DELIMITER $$	
create function emp_info (
			firsti varchar(20),
            lasti varchar(20)
) 
returns DECIMAL (10,2)
#declare v_salary DECIMAL(10,2)
DETERMINISTIC
BEGIN
			declare v_max_from_date date;
            declare v_salary DECIMAL(10,2);
			
            select max(from_date)
				into v_max_from_date
            from t_salaries
            left join t_employees
            on t_salaries.emp_no = t_employees.emp_no
            where first_name = firsti
            and last_name = lasti;
            
			select salary
				into v_salary
            FROM t_salaries
            join t_employees
            on t_salaries.emp_no = t_employees.emp_no
            where from_date = @v_max_from_date
            and first_name = firsti
            and last_name = lasti;
            return v_salary;
End $$
DELIMITER ;

select emp_info('Mary','Sluis') as salary;

select @v_max_from_date := max(from_date)
            from t_salaries
            left join t_employees
            on t_salaries.emp_no = t_employees.emp_no
            where first_name = 'Mary'
            and last_name = 'Sluis';
            
            			select salary
            FROM t_salaries
            join t_employees
            on t_salaries.emp_no = t_employees.emp_no
            where from_date = @v_max_from_date
            and first_name = 'Mary'
            and last_name = 'Sluis';
            
            
	create temporary table max_date (		
            select max(from_date)
            from t_salaries
            left join t_employees
            on t_salaries.emp_no = t_employees.emp_no
            where first_name = 'Mary'
            and last_name = 'Sluis'
            );
            
			select salary
				into v_salary
            FROM t_salaries
            join t_employees
            on t_salaries.emp_no = t_employees.emp_no
            where from_date = @v_max_from_date
            and first_name = 'Mary'
            and last_name = 'Sluis';


drop function emp_info;
select emp_info('Mary','Sluis') as salary;

select * from t_employees;
# Create a trigger that checks if the hire date of an employee is higher than the current date. If true, set this date to be the
# current date. Format the output appropriately (YY-MM-DD)

DELIMITER $$

CREATE TRIGGER check_dates
after insert on t_employees
For each row
BEGIN 
	IF t_employees.hire_date > 2022-06-14 THEN 
		SET t_employees.hire_date = 2022-06-14; 
	END IF; 
END $$
DELIMITER ;

use employees_mod;
insert into t_employees (emp_no,birth_date,first_name,last_name,gender,hire_date)
values (10999923,'1987-02-17','gerri','gardemann', 'M','2022-10-19');

select * from t_employees
where first_name = 'gerri';

select birth_date from t_employees;
select hire_date from t_employees;

# Create ‘i_hire_date’ and Drop the ‘i_hire_date’ index.

alter table t_employees add index i_hire_date (hire_date);
alter table t_employees drop index i_hire_date;


# Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum. Then, create an index
# on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.

# how can I do per annum here ??

create temporary table salaries (
select emp_no, sum(salary)/count(distinct(year(to_date)))  as salary_per_annum
from t_salaries
group by emp_no
); 
drop table salaries;
select * from salaries
where salary_per_annum >89000;

alter table salaries add index salary(salary_per_annum);

select * from salaries
where salary_per_annum > 89000;

# Use Case statement and obtain a result set containing the employee number, first name, and last name of all employees with a 
# number higher than 109990. Create a fourth column in the query, indicating whether this employee is also a manager, according to
# the data provided in the dept_manager table, or a regular employee.

SELECT t_employees.emp_no, first_name,last_name, 
CASE
    WHEN t_employees.emp_no = t_dept_manager.emp_no then 'manager'
    else 'regular employee'
END as 'manager or not'
FROM t_employees
left join t_dept_manager
on t_employees.emp_no = t_dept_manager.emp_no
where t_employees.emp_no > 109990;


SELECT t_employees.emp_no, first_name,last_name
FROM t_employees
left join t_dept_manager
on t_employees.emp_no = t_dept_manager.emp_no
where t_employees.emp_no > 109990;

# Extract a dataset containing the following information about the managers: employee number, first name, and last name. Add two
# columns at the end – one showing the difference between the maximum and minimum salary of that employee, and another one saying
# whether this salary raise was higher than $30,000 or NOT.
create temporary table emp_sal_join(
SELECT t_employees.emp_no, first_name,last_name, salary
FROM t_employees
left join t_salaries
on t_employees.emp_no = t_salaries.emp_no
);

drop table emp_sal_join;
select * from emp_sal_join;

select emp_no, max(salary)-min(salary) as differnce
from t_salaries
group by emp_no;

select emp_no, first_name, last_name, (max(salary)-min(salary)) as difference,
CASE
    WHEN max(salary)-min(salary) > 30000 then 'higher than 30000'
    else 'lower than 30000'
END as 'how high was the raise'
from emp_sal_join
group by emp_no;

# Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, called
# “current_employee” saying “Is still employed” if the employee is still working in the company, or “Not an employee anymore” if
#they aren’t. Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise.

create temporary table employed (
select t_employees.emp_no, first_name, last_name, t_dept_emp.to_date
from t_employees
join t_dept_emp
on t_employees.emp_no = t_dept_emp.emp_no
where t_dept_emp.to_date = '9999-01-01'
);

select * from t_dept_emp; # 999-01-01

select t_employees.emp_no, t_employees.first_name, t_employees.last_name,
case 
	when employed.emp_no = '9999-01-01' then 'employed'
    else 'no longer employed'
end as 'current employee'
from t_employees
left join employed
on t_employees.emp_no = employed.emp_no
group by t_employees.emp_no
;

# check

select * from t_employees;
select * from employed;


select * from t_dept_emp;
