/*
Create a user defined exception if any employee has salary less than 2000.
It must be raised whenever an employee is hired with salary less than 2000.
Otherwise the record must be successfully inserted
*/
select * from employees;
SET SERVEROUTPUT ON;

DECLARE
   
    v_salary NUMBER := &salary;

    ex_salary_too_low EXCEPTION;

BEGIN
    -- Check salary
    IF v_salary < 2000 THEN
        RAISE ex_salary_too_low;
    ELSE 
    
        INSERT INTO employees (
            employee_id,
            first_name,
            last_name,
            email,
            phone_number,
            hire_date,
            job_id,
            salary,
            commission_pct,
            manager_id,
            department_id
        )
        VALUES (
            207,
            'Dinesh',
            'Rana',
            'dinesh@gmail.com',
            '9876543210',
            TO_DATE('2025-05-09', 'YYYY-MM-DD'),
            'IT_PROG',
            2100,
            0.1,
            146,
            80
        );

        DBMS_OUTPUT.PUT_LINE('Employee record inserted successfully.');
    END IF;

EXCEPTION
    WHEN ex_salary_too_low THEN
        DBMS_OUTPUT.PUT_LINE('Salary must not be less than 2000.');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error');
COMMIT;
END;
/


/*
Create a user defined exception that checks whether the employee
salary is greater than the manager's salary
*/

SET SERVEROUTPUT ON;

DECLARE
    v_salary NUMBER(10) := &salary;
    v_mgr_id NUMBER := &manager_id;
    v_mgr_salary NUMBER;
    ex_salary_higher_than_manager EXCEPTION;

BEGIN
    SELECT salary INTO v_mgr_salary
    FROM employees
    WHERE employee_id = v_mgr_id;

    IF v_salary > v_mgr_salary THEN
        RAISE ex_salary_higher_than_manager;
    ELSE
        INSERT INTO employees (
            employee_id,
            first_name,
            last_name,
            email,
            phone_number,
            hire_date,
            job_id,
            salary,
            commission_pct,
            manager_id,
            department_id
        )
        VALUES (
            208,
            'Dinesh',
            'Rana',
            'dinesh@gmail.com',
            '9876543210',
            TO_DATE('2025-05-09', 'YYYY-MM-DD'),
            'IT_PROG',
            v_salary,
            0.1,
            v_mgr_id,
            80
        );

        DBMS_OUTPUT.PUT_LINE('Employee record inserted successfully.');
    END IF;

-- Exception handling
EXCEPTION
    WHEN ex_salary_higher_than_manager THEN
        DBMS_OUTPUT.PUT_LINE('Employee salary cannot be greater than manager salary.');

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Manager not found with ID ' || v_mgr_id);

    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID 208 already exists.');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error');
COMMIT;
END;
/

/*
RAISE an exception if date hired is greater than the current date
*/
SET SERVEROUTPUT ON;
DECLARE
  v_hire_date DATE;
  ex_future_date EXCEPTION;
BEGIN
  -- Convert the input string to DATE
  v_hire_date := TO_DATE('&Enter_Hire_Date', 'YYYY-MM-DD');

  -- Check if the hire date is in the future
  IF v_hire_date > SYSDATE THEN
    RAISE ex_future_date;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Hire date is valid: ' || TO_CHAR(v_hire_date, 'YYYY-MM-DD'));
  END IF;

EXCEPTION
  WHEN ex_future_date THEN
    DBMS_OUTPUT.PUT_LINE('Error: Hire date cannot be in the future.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/




/*
Write a program using the RAISE_APPLICATION_ERROR to display an error message if the employee_id is negative
*/

SET SERVEROUTPUT ON;

DECLARE
    v_employee_id employees.employee_id%TYPE := &emp_id;
    ex_negative_emp_id EXCEPTION;

BEGIN

    IF v_employee_id < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'The employee ID must not be negative');
        RAISE ex_negative_emp_id;
    ELSE
        DBMS_OUTPUT.PUT_LINE('The Employee ID is: ' || v_employee_id);
    END IF;
EXCEPTION
    WHEN ex_negative_emp_id THEN
    DBMS_OUTPUT.PUT_LINE('Employee ID must not be negative');
COMMIT;
END;
/

 