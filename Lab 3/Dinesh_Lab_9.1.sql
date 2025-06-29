/*
create a procedure to find the list of all the employees
(employee_id and full_name) who earns less thean the average salary.
*/

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE emp_earn_lt_avg_salary
AS
    v_avg_salary NUMBER;

    CURSOR c_emp_salary IS
    SELECT employee_id, first_name || ' ' || last_name AS full_name, salary
    FROM employees
    WHERE salary < v_avg_salary;
    v_emp c_emp_salary%ROWTYPE;

BEGIN
    SELECT AVG(salary)
    INTO v_avg_salary
    FROM employees;
    
    OPEN c_emp_salary;
    
    DBMS_OUTPUT.PUT_LINE('Employees earning less than average salary (' || v_avg_salary || '):');
    
    LOOP
    FETCH c_emp_salary INTO v_emp;
    EXIT WHEN c_emp_salary%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_emp.employee_id || ', Name: ' || v_emp.full_name || ', Salary: ' || v_emp.salary);
    END LOOP;
    
    CLOSE c_emp_salary;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Sorry, no records found');

END;
/

-- Method 1 to invoke
CALL emp_earn_lt_avg_salary();

-- Method 2 to invoke
EXEC emp_earn_lt_avg_salary();

/*
Find the lsit of all employees hired in IT department between the specified date.
*/
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE get_it_employees_by_hire_date (
    p_start_date IN DATE,
    p_end_date   IN DATE
)
AS
    CURSOR c_it_emps IS
        SELECT e.employee_id,
               e.first_name || ' ' || e.last_name AS full_name,
               e.hire_date
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id
        WHERE d.department_name = 'IT'
          AND e.hire_date BETWEEN p_start_date AND p_end_date;
    
    v_emp_id     employees.employee_id%TYPE;
    v_full_name  VARCHAR2(200);
    v_hire_date  employees.hire_date%TYPE;
BEGIN
    OPEN c_it_emps;
    LOOP
        FETCH c_it_emps INTO v_emp_id, v_full_name, v_hire_date;
        EXIT WHEN c_it_emps%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_emp_id || ', Name: ' || v_full_name || ', Hire Date: ' || v_hire_date);
    END LOOP;
    CLOSE c_it_emps;
END;
/


CALL get_it_employees_by_hire_date(TO_DATE('2000-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));

    
