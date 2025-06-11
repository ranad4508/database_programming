-- Read two substitution variables and identify the greatest of them
SET SERVEROUTPUT ON;
DECLARE 
    v_var1 NUMBER(6,2) :=&a;
    v_var2 NUMBER(6,2) :=&b;
BEGIN

    IF v_var1 > v_var2 THEN
        DBMS_OUTPUT.PUT_LINE('The greater is var1: ' || v_var1);
    END IF;

    IF v_var2 > v_var1 THEN
        DBMS_OUTPUT.PUT_LINE('The greater is var2: ' || v_var2);
    END IF;

    IF v_var1 = v_var2 THEN
        DBMS_OUTPUT.PUT_LINE('Both variables are equal: ' || v_var1);
    END IF;
END;
/

-- Read the gender from the user and display you are male or female

DECLARE
    v_gender NVARCHAR2(1) :='&Gender';
BEGIN
    IF v_gender = 'M' THEN
    DBMS_OUTPUT.PUT_LINE('The gender is Male');
    ELSE 
    DBMS_OUTPUT.PUT_LINE('The gender is Female');
    END IF;
END;
/

-- Read 1-7 from the end user and print the day of the week
DECLARE
    v_day NUMBER(10) :=&day;
BEGIN
    IF v_day = 1 THEN
    DBMS_OUTPUT.PUT_LINE('Sunday');
    ELSIF v_day = 2 THEN
    DBMS_OUTPUT.PUT_LINE('Monday');
    ELSIF v_day = 3 THEN
    DBMS_OUTPUT.PUT_LINE('Tuesday');
    ELSIF v_day = 4 THEN
    DBMS_OUTPUT.PUT_LINE('Wednesday');
    ELSIF v_day = 5 THEN
    DBMS_OUTPUT.PUT_LINE('Thursday');
    ELSIF v_day = 6 THEN
    DBMS_OUTPUT.PUT_LINE('Friday');
    ELSIF v_day = 7 THEN
    DBMS_OUTPUT.PUT_LINE('Saturday');
    ELSE 
    DBMS_OUTPUT.PUT_LINE('Invalid Input');
    END IF;
END;
/

--NULL Statement
DECLARE
    v_var1 NUMBER(10) :=10;
    v_var2 NVARCHAR2(5);
BEGIN
    IF v_var1 = v_var2 THEN
    DBMS_OUTPUT.PUT_LINE('v_var1 = v_var2');
    ELSE
    DBMS_OUTPUT.PUT_LINE('v_var1 != v_var2');
    END IF;
END;
/

select * from employees;

-- Find the list of all the employees hired before a specified date

DECLARE
    v_hire_date DATE := TO_DATE('&hire_date', 'YYYY-MM-DD');
    v_emp_id employees.employee_id%TYPE;
    v_first_name employees.first_name%TYPE;
    v_last_name employees.last_name%TYPE;
    v_h_date employees.hire_date%TYPE;
BEGIN
    SELECT employee_id, first_name, last_name, hire_date
    INTO v_emp_id, v_first_name, v_last_name, v_h_date
    FROM employees
    WHERE hire_date < v_hire_date
    AND ROWNUM = 1;
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_emp_id || ' Employee Name: ' || v_first_name || ' ' || v_last_name || ' Hire date: '||v_hire_date);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No data found');
END;
/



/* Find the average_salary and read on employee_id from the user. If the user earns
more than the average_salary display so, or if they earn less than the average_salary display so
*/
SET SERVEROUTPUT ON;
DECLARE
    v_emp_id employees.employee_id%TYPE := &enter_employee_id; 
    v_emp_salary employees.salary%TYPE;
    v_avg_salary NUMBER;
BEGIN
    -- Get the employee's salary
    SELECT salary INTO v_emp_salary
    FROM employees
    WHERE employee_id = v_emp_id;

    -- Calculate the average salary
    SELECT AVG(salary) INTO v_avg_salary
    FROM employees;

    -- Compare salaries
    IF v_emp_salary > v_avg_salary THEN
        DBMS_OUTPUT.PUT_LINE('Employee earns more than the average salary.');
    ELSIF v_emp_salary < v_avg_salary THEN
        DBMS_OUTPUT.PUT_LINE('Employee earns less than the average salary.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Employee earns the average salary.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found with the given ID.');
END;
/







