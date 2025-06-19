/*
Raise value_error if the number entered is -ve if the square root is to be calculated
*/
SET SERVEROUTPUT ON;

DECLARE
    v_number NUMBER := &Enter_Number; 
    v_result NUMBER;
BEGIN
    IF v_number < 0 THEN
        RAISE VALUE_ERROR;  
    ELSE
        v_result := SQRT(v_number);
        DBMS_OUTPUT.PUT_LINE('Square root of ' || v_number || ' is: ' || v_result);
    END IF;

EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: Cannot calculate square root of a negative number.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/

/*
Find the full name of an employee whose employee number is read from the user,
Raise value error or invalid number exception and display appropirate message
Raise no date found exception and display message accordingly
*/
SET SERVEROUTPUT ON;
DECLARE
    v_emp_id employees.employee_id%TYPE := &Enter_Employee_ID;
    v_full_name VARCHAR2(100);
BEGIN
    SELECT first_name || ' ' || last_name
    INTO v_full_name
    FROM employees
    WHERE employee_id = v_emp_id;
    -- Display full name if found
    DBMS_OUTPUT.PUT_LINE('Full name of employee ID ' || v_emp_id || ' is: ' || v_full_name);
-- Exception handling
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('VALUE_ERROR: Invalid input. Please enter a numeric employee ID.');

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND: No employee found with ID ' || v_emp_id || '.');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error occurred: ' || SQLERRM);
END;
/

