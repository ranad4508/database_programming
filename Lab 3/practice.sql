--find the list of all the department that has more than three staffs
SELECT d.department_id, d.department_name, 
       COUNT(e.employee_id) AS "Total Staff"
FROM employees e 
INNER JOIN departments d 
    ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) > 3;



--find the countries that have more than 3 staff hired in FY 2005
--SELECT c.country_id, c.country_name, 
--       COUNT(e.employee_id) AS "Total Staff"
--FROM employees e
--INNER JOIN locations l 
--    ON e.location_id = l.location_id
--INNER JOIN countries c 
--    ON l.country_id = c.country_id
--WHERE e.hire_date BETWEEN DATE '2004-07-01' AND DATE '2005-06-30'
--GROUP BY c.country_id, c.country_name
--HAVING COUNT(e.employee_id) > 3;


--Read r, h and l and calculte the volume of the cone, and total surface area of the cone
--Vcone = 1/3 * pie * r^2 * h

--Total surface area =  pie * r *(r+h)

SET SERVEROUTPUT ON;

DECLARE 
    v_radius NUMBER(5,2) := &r;
    v_height NUMBER(5,2) := &h;
    v_length NUMBER(5,2) := &l;
    v_volume_cone NUMBER(10,2);
    v_surface_area NUMBER(10,2);
    c_pi CONSTANT NUMBER := 3.1416;
BEGIN
    -- Calculate volume of the cone
    v_volume_cone := (1.0/3) * c_pi * POWER(v_radius, 2) * v_height;
    
    -- Calculate total surface area of the cone
    v_surface_area := c_pi * v_radius * (v_radius + v_height);
 
    DBMS_OUTPUT.PUT_LINE('Volume of Cone: ' || v_volume_cone);
    DBMS_OUTPUT.PUT_LINE('Total Surface Area: ' || v_surface_area);
END;
/


-- Prepare a PL/SQL that displays the total salary distributed by any department whose department_id is read from user
SET SERVEROUTPUT ON;

DECLARE
    v_dept_id employees.department_id%TYPE := &dept_id;
    v_total_salary NUMBER;
    v_dept_name departments.department_name%TYPE;
BEGIN
    SELECT d.department_name, SUM(e.salary)
    INTO v_dept_name, v_total_salary
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE e.department_id = v_dept_id
    GROUP BY d.department_name;

    DBMS_OUTPUT.PUT_LINE('Department: ' || v_dept_name);
    DBMS_OUTPUT.PUT_LINE('Total Salary Distributed: ' || v_total_salary);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No data found for department ID: ' || v_dept_id);
END;
/


select * from departments;

\
 SET SERVEROUTPUT ON;
 DECLARE 
    N number :=&n;
    factorial number :=1;
BEGIN
    IF N<0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Factorial is not defined for negavtive numbers');
    ELSIF N =0 THEN
    factorial :=1;
    ELSE
    FOR i IN 1..N LOOP
    factorial :=factorial * i;
    END LOOP;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Factorial :' || factorial);
    END;
    /



/*
Prepare a stored procedure to insert a record in employee table.
*/
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE insert_hr_employee (
    p_employee_id IN employees.employee_id%TYPE,
    p_first_name IN employees.first_name%TYPE,
    p_last_name IN employees.last_name%TYPE,
    p_email IN employees.email%TYPE,
    p_phone_number IN employees.phone_number%TYPE,
    p_hire_date IN employees.hire_date%TYPE,
    p_job_id IN employees.job_id%TYPE,
    p_salary IN employees.salary%TYPE,
    p_commission_pct IN employees.commission_pct%TYPE,
    p_manager_id IN employees.manager_id%TYPE,
    p_department_id IN employees.department_id%TYPE
)
AS
BEGIN
    INSERT INTO employees (
        employee_id, first_name, last_name, email, phone_number,
        hire_date, job_id, salary, commission_pct, manager_id, department_id
    )
    VALUES (
        p_employee_id, p_first_name, p_last_name, p_email, p_phone_number,
        p_hire_date, p_job_id, p_salary, p_commission_pct, p_manager_id, p_department_id
    );

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inserting employee: ' || SQLERRM);
END;
/

CALL insert_hr_employee (222, 'Dinesh', 'Rana','dineshadmin@gmail.com', '098767890', SYSDATE, 'IT_PROG', 6000, NULL,103,60);



/*
Prepare a cursor to fetch the records of all departs and total renumeration
*/
    
/*
Write a PL/SQL procedure to delete all employees who have not worked for more than 2 year
*/
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE delete_inactive_employees IS
BEGIN
  DELETE FROM employees
  WHERE hire_date >= SYSDATE - INTERVAL '2' YEAR;

  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' employee deleted who worked less than or equal to 2 years.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

CALL delete_inactive_employees();


