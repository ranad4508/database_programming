--create a view to find the list of all the departments and salary distributed.
CREATE VIEW dept_salary_distribution AS
SELECT 
    d.department_id,
    d.department_name,
    SUM(e.salary) AS total_salary_distributed
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

SELECT * from dept_salary_distribution;

--find the list of all the employees whose first letter start with M
SELECT * from employees where first_name LIKE 'M%';

select * from employees;

--find the list of all th employee whose first name has third character as 'e'/'E'
SELECT *
FROM employees
WHERE first_name
LIKE '__e%'
OR first_name LIKE '__E%';

--to remove a view
drop view dept_salary_distribution;

--list out all the views
select view_name from user_views;

--describe view
DESCRIBE emp_details_view;



CREATE MATERIALIZED VIEW dept_salary_summary_mv
BUILD IMMEDIATE
REFRESH COMPLETE
ON DEMAND
AS
SELECT 
    d.department_id,
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    AVG(e.salary) AS avg_salary
FROM 
    departments d
JOIN 
    employees e ON d.department_id = e.department_id
GROUP BY 
    d.department_id, d.department_name;
    
    
    
SELECT * FROM dept_salary_summary_mv;




DROP MATERIALIZED VIEW dept_salary_summary_mv;




