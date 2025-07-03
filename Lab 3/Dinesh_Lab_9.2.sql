/*
Find the list of all employees working within the department whose id is passed as arguement
*/
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE get_employees_by_dept (
    p_dept_id IN employees.department_id%TYPE
)
AS
BEGIN
    FOR emp_rec IN (
        SELECT employee_id,
               first_name || ' ' || last_name AS full_name,
               email,
               job_id,
               salary
        FROM employees
        WHERE department_id = p_dept_id
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('ID: ' || emp_rec.employee_id || 
                             ', Name: ' || emp_rec.full_name || 
                             ', Email: ' || emp_rec.email || 
                             ', Job: ' || emp_rec.job_id || 
                             ', Salary: ' || emp_rec.salary);
    END LOOP;
END;
/

CALL get_employees_by_dept(60);

SELECT * from employees;
/*
Create a stored procedure that finds the name of the manager whose employee_id is received as an arguement
*/
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE get_manager_name (
    p_employee_id IN EMPLOYEES.EMPLOYEE_ID%TYPE
)
AS
    v_manager_id EMPLOYEES.MANAGER_ID%TYPE;
    v_first_name EMPLOYEES.FIRST_NAME%TYPE;
    v_last_name EMPLOYEES.LAST_NAME%TYPE;
BEGIN

    SELECT manager_id
    INTO v_manager_id
    FROM employees
    WHERE employee_id = p_employee_id;

    IF v_manager_id IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('This employee has no manager.');
    ELSE
        SELECT first_name, last_name
        INTO v_first_name, v_last_name
        FROM employees
        WHERE employee_id = v_manager_id;

        DBMS_OUTPUT.PUT_LINE('Manager Name: ' || v_first_name || ' ' || v_last_name);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Invalid employee ID or manager not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

CALL get_manager_name(103);
