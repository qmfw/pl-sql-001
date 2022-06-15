select employee_id id, salary sal,
	case when salary < 5000 then 'c등급'
		when salary > 5000 and salary < 15000 then 'b등급'
		else 'a등급'
	end as salary_grade
from employees;
----------------------------------------------------------
select * from employees;

select employee_id, salary from employees
where salary = any (2000, 3000, 4000) --any 대신에 in, some도 가능
order by employee_id;

select employee_id, salary from employees
where salary = 2000 or salary = 3000 or salary = 4000
order by employee_id;

select employee_id, salary from employees
where salary = any (2000, 3000, 4000) --any 대신에 some도 가능
order by employee_id;
----------------------------------------------------------
create table ex3_6 (
	ex3_6_num NUMBER,
	ex3_6_name VARCHAR2(20),
	ex3_6_price NUMBER,
	ex3_6_manage NUMBER
);

insert into ex3_6 select employee_id, emp_name, salary, manager_id
from employees where salary between 2000 and 3000;

select * from ex3_6;
drop table ex3_6;