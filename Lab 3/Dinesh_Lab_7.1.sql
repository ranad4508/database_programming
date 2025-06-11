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
