/*
Display the fullname of the employee whose employee_id is 146. use ROWTYPE
*/
SET SERVEROUTPUT ON;
DECLARE
    v_employee Employees%ROWTYPE;
    v_full_name VARCHAR2(100);
BEGIN
    SELECT * INTO v_employee
    FROM Employees
    WHERE employee_id = 146;
    v_full_name := v_employee.last_name || ' ' || v_employee.first_name;
    DBMS_OUTPUT.PUT_LINE('The full name of employee id ' || v_employee.employee_id || ' is ' || v_full_name);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Sorry, no records found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

select * from departments;

/*
Fetch and assign all the employees of the IT department to a cursor
*/
SET SERVEROUTPUT ON;
DECLARE
    CURSOR cr_employee
    IS 
    SELECT * FROM employees
    WHERE department_id = 60;
    vr_emp_record cr_employee%ROWTYPE;    
BEGIN
    -- Open cursor
    OPEN cr_employee;
    -- fetch cursor
    LOOP
        FETCH cr_employee INTO vr_emp_record;
         EXIT WHEN cr_employee%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Emp ID: '||vr_emp_record.employee_id|| ' Fullname: '||vr_emp_record.last_name || ' '||vr_emp_record.first_name ||' Salary: '||vr_emp_record.salary);
    END LOOP;
    -- close cursor
    CLOSE cr_employee;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Sorry, no records found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
COMMIT;
END;
/



SELECT e.employee_id,
               e.first_name || ' ' || e.last_name AS full_name,
               e.salary,
               j.job_title
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id
        JOIN locations l ON d.location_id = l.location_id
        JOIN countries c ON l.country_id = c.country_id
        JOIN jobs j ON e.job_id = j.job_id
        WHERE c.country_name = 'United States of America'
        AND e.salary > (SELECT AVG(salary) FROM employees);



/*
Create a cursor and fetch data of all the employees from United States of America who earns
more than the average salary. Display ther employee_id, full_name and salary as well as job title
*/
SET SERVEROUTPUT ON;
DECLARE
    CURSOR cr_employee IS
        SELECT e.employee_id,
               e.first_name || ' ' || e.last_name AS full_name,
               e.salary,
               j.job_title
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id
        JOIN locations l ON d.location_id = l.location_id
        JOIN countries c ON l.country_id = c.country_id
        JOIN jobs j ON e.job_id = j.job_id
        WHERE c.country_name = 'United States of America'
        AND e.salary > (SELECT AVG(salary) FROM employees);
    v_emp_record cr_employee%ROWTYPE;
BEGIN
    OPEN cr_employee;
    LOOP
        FETCH cr_employee INTO v_emp_record;
        EXIT WHEN cr_employee%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || v_emp_record.employee_id ||', Name: ' || v_emp_record.full_name ||', Salary: ' || v_emp_record.salary ||', Job Title: ' || v_emp_record.job_title);
    END LOOP;
    CLOSE cr_employee;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

/*
Create a cursor to fetch information about the employees who never worked in IT department
but had more than 2 job title changes(change of post/job position)
*/
SET SERVEROUTPUT ON;
DECLARE
    CURSOR cr_employee IS
        SELECT e.employee_id,
               e.first_name || ' ' || e.last_name AS full_name,
               d.department_name,
               COUNT(e.employee_id) AS job_changes
        FROM employees e
        JOIN job_history jh ON e.employee_id = jh.employee_id
        JOIN departments d ON jh.department_id = d.department_id
        -- Uncomment if you want to filter only IT dept
         WHERE d.department_name = 'IT'
        GROUP BY e.employee_id, e.first_name, e.last_name, d.department_name
        HAVING COUNT(e.employee_id) >= 1;
    v_employee_id   employees.employee_id%TYPE;
    v_full_name     VARCHAR2(100);
    v_department    departments.department_name%TYPE;
    v_job_changes   NUMBER;
BEGIN
    OPEN cr_employee;
    LOOP
        FETCH cr_employee INTO v_employee_id, v_full_name, v_department, v_job_changes;
        EXIT WHEN cr_employee%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_employee_id ||', Name: ' || v_full_name ||', Department: ' || v_department ||', Job Title Changes: ' || v_job_changes);
    END LOOP;
    CLOSE cr_employee;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

    
