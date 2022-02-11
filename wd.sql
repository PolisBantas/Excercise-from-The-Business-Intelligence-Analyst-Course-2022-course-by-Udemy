use employees;
DROP TABLE IF EXISTS departments_dup;

CREATE TABLE departments_dup (
    dept_no CHAR(4) NULL,
    dept_name VARCHAR(40) NULL
);

 

INSERT INTO departments_dup

(

    dept_no,

    dept_name

)SELECT

                *

FROM

                departments;

 

INSERT INTO departments_dup (dept_name)

VALUES                ('Public Relations');

 

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002'; 

   

INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');
SELECT 
    *
FROM
    departments_dup;
DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);

 

INSERT INTO dept_manager_dup

select * from dept_manager;

 

INSERT INTO dept_manager_dup (emp_no, from_date)

VALUES                (999904, '2017-01-01'),

                                (999905, '2017-01-01'),

                               (999906, '2017-01-01'),

                               (999907, '2017-01-01');

 

DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001';
SELECT 
    *
FROM
    dept_manager_dup
ORDER BY dept_no;
SELECT 
    *
FROM
    departments_dup
ORDER BY dept_no;
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;
SELECT 
    e.emp_no, e.first_name, e.last_name, m.dept_no, e.hire_date
FROM
    dept_manager_dup m
        INNER JOIN
    employees e ON m.emp_no = e.emp_no
ORDER BY e.emp_no;
SELECT 
    m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
WHERE
    dept_name IS NULL
GROUP BY m.emp_no
ORDER BY m.dept_no;
SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, d.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager_dup d ON e.emp_no = d.emp_no
WHERE
    e.last_name = 'Markovitch'
GROUP BY e.emp_no
ORDER BY d.dept_no DESC , e.emp_no;
SELECT 
    d.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        RIGHT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no;
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m,
    departments_dup d
WHERE
    m.dept_no = d.dept_no
ORDER BY m.dept_no;
SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e,
    dept_manager_dup d
WHERE
    e.emp_no = d.emp_no
GROUP BY e.emp_no
ORDER BY d.dept_no DESC , e.emp_no;
SELECT 
    e.emp_no, e.first_name, e.last_name, s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    s.salary > 145000;
select @@global.sql_mode;
set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');
 SELECT 
    e.first_name, e.last_name, e.hire_date, t.title
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    e.first_name = 'Margareta'
        AND e.last_name = 'Markovitch'
ORDER BY e.emp_no;

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    dm.*, d.*
FROM
    dept_manager dm,
    departments d
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    e.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
        JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no = 'd009';

SELECT 
    e.*, d.*
FROM
    departments d
        CROSS JOIN
    employees e
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no , d.dept_name;    
SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.gender;


SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no;
    
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
        JOIN
    dept_manager m ON t.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
WHERE
    t.title = 'Manager'
ORDER BY e.emp_no;

SELECT 
    d.dept_name, AVG(s.salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING average_salary > 60000
ORDER BY average_salary DESC;

SELECT 
    e.gender, COUNT(m.emp_no) AS total
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
GROUP BY e.gender;

drop table if exists employees_dup;
CREATE TABLE employees_dup (
    emp_no INT(11),
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    gender ENUM('M', 'F'),
    hire_date DATE
);
insert into employees_dup select e.* from employees e limit 20;
SELECT 
    *
FROM
    employees_dup;
insert into employees_dup values ('10001', '1953-09-02', 'Georgi', 'Facello', 'M', '1986-06-26');
SELECT 
    *
FROM
    employees_dup;
    
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    NULL AS dept_no,
    NULL AS from_date
FROM
    employees_dup e
WHERE
    e.emp_no = 10001 
UNION  SELECT 
    NULL AS emp_no,
    NULL AS first_name,
    NULL AS last_name,
    m.dept_no,
    m.from_date
FROM
    dept_manager m;
    
SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY  -a.emp_no desc;

SELECT 
    *
FROM
    dept_manager;
    
SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    e.emp_no IN (SELECT 
            dm.emp_no
        FROM
            dept_manager dm);
            
	SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01')
ORDER BY emp_no;

SELECT 
    e.first_name, e.last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            dept_manager dm
        WHERE
            dm.emp_no = e.emp_no)
ORDER BY emp_no;

SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            e.emp_no = t.emp_no
                AND title = 'Assistant Engineer')
ORDER BY first_name;

SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS depertment_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS depertment_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS B;

DROP TABLE IF EXISTS emp_manager;

CREATE TABLE emp_manager (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    manager_no INT(11) NOT NULL
);

INSERT into emp_manager select U.* from (SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS depertment_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS depertment_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10022
    GROUP BY e.emp_no
    ORDER BY e.emp_no 
    LIMIT 20) AS B
    union select C.* from
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS depertment_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 10022
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS C
    UNION SELECT D.* from
    (SELECT 
        e.emp_no AS employee_id,
            MIN(de.dept_no) AS depertment_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_id
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 10039
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS D) AS U;

;

use employees;
drop procedure if exists select_employees;

delimiter $$
create procedure select_employees()
begin 
		select * from employees 
        limit 1000; 
end $$ 
delimiter ;

call employees.select_employees();
call select_employees();

delimiter $$ 
create procedure average_salary()
begin 
		select avg(salary) from salaries;

end$$
delimiter ; 
call average_salary();

DROP PROCEDURE select_employees;

delimiter $$
use employees $$
create procedure emp_avg_salary(in p_emp_no integer)
begin
		select e.first_name, e.last_name, avg(s.salary)
        from employees e
        join 
        salaries s on e.emp_no = s.emp_no
        where e.emp_no = p_emp_no;
end$$
delimiter ;

call emp_salary(11300);

delimiter $$ 
create procedure emp_avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10,2))
begin
		select avg(s.salary)
        into p_avg_salary
        from employees e
        join
        salaries s on e.emp_no = s.emp_no
        where e.emp_no = p_emp_no;
end $$

delimiter ;

delimiter $$
create procedure emp_info(in p_first_name varchar(16), in p_last_name varchar(16))
begin
	select e.emp_no
    from employees e
    where e.first_name = p_first_name and e.last_name = p_last_name;
end$$
delimiter ;

set @v_avg_salary = 0;
call employees.emp_avg_salary_out(11300, @v_avg_salary);
select @v_avg_salary;

set @v_emp_no = 0;
call employees.emp_info('Aruna', 'Journel', @v_emp_no);
select @v_emp_no;

delimiter $$
create function f_emp_avg_salary (p_emp_no integer) returns decimal (10,2)
deterministic
begin
	declare v_avg_salary decimal (10,2);
    select
		avg(s.salary)
	into v_avg_salary from employees e
    join salaries s on e.emp_no = s.emp_no
    where e.emp_no = p_emp_no;
    
    return v_avg_salary;
end$$
delimiter ;

select f_emp_avg_salary(11300);

delimiter $$
create function f_emp_info (p_first_name varchar(255), p_last_name varchar(255)) returns decimal (10,2)
deterministic
begin
	declare v_max_from_date date; declare v_salary decimal(10,2);
    select s.salary
    into v_salary from employees e
    join salaries s on e.emp_no = s.emp_no
    where e.first_name = p_first_name and e.last_name = p_last_name and v_max_from_date = max(s.from_date);
    
    return v_salary;
end$$
delimiter ;
select f_emp_info('Aruna', 'Journel');

set @v_emp_no = 11300;
SELECT 
    emp_no,
    first_name,
    last_name,
    F_EMP_AVG_SALARY(@v_emp_no) AS avg_salary
FROM
    employees
WHERE
    emp_no = @v_emp_no;
    
SELECT 
    emp_no,
    first_name,
    last_name,
    CASE
        WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;
    
SELECT 
    emp_no,
    first_name,
    last_name,
    IF(gender = 'M', 'Male', 'Female') AS gender
FROM
    employees;
    
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than 30000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 'Salary was raised by more than 20000 but less than 30000'
        ELSE 'Slary was raised by less than 20000'
    END AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;
 
 SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS position
FROM
    employees e
      left  JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
HAVING e.emp_no > 109990;
 
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'The raise was more than 30000'
        ELSE 'The raise was under 30000'
    END AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY dm.emp_no;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(d.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp d ON d.emp_no = e.emp_no
GROUP BY e.emp_no
ORDER BY e.emp_no
LIMIT 100;