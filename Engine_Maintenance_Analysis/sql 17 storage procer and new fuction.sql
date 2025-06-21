use employee;

with dept_emp as (
select e.employee_id, e.first_name, e.last_name,e.email, e.salary, l.city, l.country_id from 
employees as e
join departments as d
on e.department_id = d.department_id
join locations as l
on d.location_id = l.location_id)

select * from dept_emp
where city like 's%';

-- view Tbale
create view employee_info as 
select e.employee_id, e.first_name, e.last_name,e.email, e.salary, l.city from 
employees as e
join departments as d
on e.department_id = d.department_id
join locations as l
on d.location_id = l.location_id;

show tables;

select * from employee_info;

select * from employee_info
where city like 's%';

create view high_erners as
select employee_id, first_name, last_name, salary, department_id
from employees
where salary > 10000;

select * from high_erners
order by salary desc;

-- update the view
-- By using create of replace view view_name

select * from employee_info;

create or replace view employee_info as
select e.employee_id, e.first_name, e.last_name, e.email, e.hire_date, e.salary, d.department_name,
l.city, l.country_id
from employees as e
join departments as d
on e.department_id = d.department_id
join locations as l
on d.location_id = l.location_id;

select * from high_erners;

-- drop view
drop view high_erners;

desc employee_info;

-- Storage Procedure

use employee;

DELIMITER //

create procedure getallemployees()
begin
	select * from employees;
end //

DELIMITER ;

call getallemployees();

DELIMITER //

CREATE PROCEDURE EmployeesDepartment(IN dept_id INT)
BEGIN
    SELECT * FROM employees
    WHERE department_id = dept_id;
END //

DELIMITER ;

call employeesdepartment(8);

DELIMITER //

CREATE PROCEDURE Getemployeesalary(IN salary_value INT)
BEGIN
    SELECT * FROM employees
    WHERE salary > salary_value;
END //

DELIMITER ;

call getemployeesalary(17000);

DELIMITER //
create procedure get_dept_name (in dept_id int, out dept_name varchar(50))
begin
	select department_name into dept_name
    from departments
    where department_id = dept_id;
end //
DELIMITER ;

call get_dept_name(3, @dept_name);
select @dept_name;

DELIMITER //
create procedure count_employees_dept(in dept_id int, out emp_count int)
begin
	select count(*) into emp_count
    from employees
    where department_id = dept_id;
end //
DELIMITER ;

call count_employees_dept(3, @emp_count);
select @emp_count;

-- Function
DELIMITER //
create function addnumber (a int, b int)
returns int
deterministic
begin
	return a+b;
end //
DELIMITER ;

select addnumber(10,20) as result;

DELIMITER //
create function square(num int)
returns int
deterministic
begin 
	return num * num;
end //
DELIMITER ;

select square(5) as square;


DELIMITER //
create function full_name(fir varchar(50), las varchar(50))
returns varchar(100)
deterministic
begin 
	return concat(fir, ' ', las);
end //
DELIMITER ;

select employee_id, full_name(first_name, last_name) as Sure_name, email, salary
from employees;

DELIMITER //
create function is_even(num int)
returns varchar(10)
deterministic
begin
	if num % 2 = 0 then
    return 'Even';
    else 
    return 'odd';
    end if;
end //

DELIMITER ;

select is_even(8) as result;

DELIMITER //
create function salary_lavel(salary decimal(10,2))
returns varchar(20)
deterministic
begin
	if salary < 10000 then
    return 'Low';
    elseif salary between 10000 and 15000 then
    return 'Medium';
    else
    return 'High';
    end if;
end //
DELIMITER ;

-- With CTE
with salary_stat as (select first_name, salary_lavel(salary) as salary_status from employees)
select * from salary_stat
where salary_status = 'High';

-- With View
create view salary_stat as
select first_name, salary_lavel(salary) as salary_status from employees;
select * from salary_stat
where salary_status= 'low';