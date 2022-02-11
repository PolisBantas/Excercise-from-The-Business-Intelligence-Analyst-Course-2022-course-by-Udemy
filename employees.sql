SELECT 
    YEAR(d.from_date) AS year_calendar,
    e.gender,
    COUNT(e.emp_no) AS num_of_employees
FROM
    t_employees e
        JOIN
    t_dept_emp d ON e.emp_no = d.emp_no
GROUP BY year_calendar , e.gender
HAVING year_calendar >= 1990
ORDER BY year_calendar;

SELECT 
    d.dept_name,
    ee.gender,
    dm.emp_no,
    dm.from_date,
    dm.to_date,
    e.year_calendar,
    CASE
        WHEN
            year(dm.from_date) <= e.year_calendar
                AND year(dm.to_date) >= e.year_calendar
        THEN
            1
        ELSE 0
    END AS activee
FROM
    (SELECT 
        YEAR(hire_date) AS year_calendar
    FROM
        t_employees
    GROUP BY year_calendar) e
        CROSS JOIN
    t_dept_manager dm
        JOIN
    t_departments d ON dm.dept_no = d.dept_no
        JOIN
    t_employees ee ON dm.emp_no = ee.emp_no
ORDER BY dm.emp_no , year_calendar;

SELECT 
    e.gender,
    de.dept_name,
    AVG(s.salary) AS salary,
    YEAR(s.from_date) AS calendar_year
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp d ON d.emp_no = e.emp_no
        JOIN
    t_departments de ON de.dept_no = d.dept_no
GROUP BY de.dept_no , e.gender , calendar_year
HAVING calendar_year <= 2002
ORDER BY de.dept_no;

delimiter $$
create procedure filter_salary (in p_min_salary float, in p_max_salary float)
begin
select
e.gender, d.dept_name, avg(s.salary) as avg_salary
from
t_salaries s
join t_employees e on s.emp_no = e.emp_no
join t_dept_emp de on de.emp_no = e.emp_no
join t_departments d on d.dept_no = de.dept_no
where s.salary between p_min_salary and p_max_salary
group by d.dept_name, e.gender;
end$$
delimiter ;

call filter_salary(50000, 90000);



