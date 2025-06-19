/*
To find the name of department where employee with employee_id = 105 works
*/
SET SERVEROUTPUT ON;
DECLARE
    v_dept_name Departments.department_name%TYPE;
BEGIN
    SELECT department_name INTO v_dept_name
    FROM departments d
    INNER JOIN employees e
    ON d.department_id = e.department_id
    WHERE e.employee_id = 105;  
    IF SQL%ROWCOUNT = 1 THEN
    DBMS_OUTPUT.PUT_LINE('The department name is '||v_dept_name);
    ELSIF SQL%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Sorry, no such employees emit');
    ELSE
    DBMS_OUTPUT.PUT_LINE('The application do not have such records');
    END IF;
END;
/

select * from departments;
    