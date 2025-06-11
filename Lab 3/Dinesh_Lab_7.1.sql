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
