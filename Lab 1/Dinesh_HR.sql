SELECT SUM(salary) FROM employees GROUP BY department_id;

-- to find the list of all the employees who earns not less than 25000
SELECT *  
FROM employees
WHERE salary >= 25000;


--find all the regions
SELECT * FROM regions;


--find the list of total salary paid each month
SELECT TO_CHAR(SYSDATE, 'Month') AS salary_month,
       SUM(salary) AS total_salary_paid
FROM employees;


--find the list of total salary paid each month in each department
SELECT d.department_id,
       d.department_name,
       TO_CHAR(SYSDATE, 'Month') AS salary_month,
       SUM(e.salary) AS total_salary_paid
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name;


-- find the total number of employees in each department
SELECT department_id,
       COUNT(*) AS total_employees
FROM employees
GROUP BY department_id;


--find the list of all the departments and total staff working in each department
SELECT d.department_id, department_name, 
count(employee_id) "Total Staff" 
FROM employees e 
INNER JOIN departments d 
ON e.department_id = d.department_id 
GROUP BY d.department_id, department_name;


select * from departments;
select * from employees;

--find the list of all the employees who earns more than the average salary [sub-query]
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);


-- find the list of all the employees who is from department_id 10, 30, 50 [OR operator, IN Operator]
--using or operator
SELECT *
FROM employees
WHERE department_id = 10
   OR department_id = 30
   OR department_id = 50;
   
--using in operator
SELECT *
FROM employees
WHERE department_id IN (10, 30, 50);

--find the list of all employees who earns between 2500 & 5000 [Between operator]
SELECT *
FROM employees
WHERE salary BETWEEN 2500 AND 5000;

--find the list of all the regions and total staff in that region
--Step-1:
SELECT *
FROM regions R
INNER JOIN countries C ON R.region_id = C.region_id
INNER JOIN locations L ON C.country_id = L.country_id
INNER JOIN departments D ON L.location_id = D.location_id
INNER JOIN employees E ON D.department_id = E.department_id;

--Step-2:
SELECT 
    R.region_id, 
    R.region_name, 
    COUNT(E.employee_id) AS "Total Staff"
FROM regions R
INNER JOIN countries C ON R.region_id = C.region_id
INNER JOIN locations L ON C.country_id = L.country_id
INNER JOIN departments D ON L.location_id = D.location_id
INNER JOIN employees E ON D.department_id = E.department_id
GROUP BY R.region_id, R.region_name;



