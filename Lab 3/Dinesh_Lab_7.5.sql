/*
For LOOP with nested cursor
*/
SET SERVEROUTPUT ON;
DECLARE
    v_dept_id Departments.department_id%TYPE;
    CURSOR c_department IS
        SELECT department_id, department_name 
        FROM departments;
    CURSOR c_employees IS
        SELECT e.employee_id, last_name ||' '|| first_name AS full_name, salary
        FROM Employees e
        INNER JOIN departments d
        ON e.department_id = d.department_id
        WHERE e.department_id = v_dept_id;
BEGIN
    FOR v_department IN c_department LOOP
        v_dept_id := v_department.department_id;
    
        FOR v_emp IN c_employees LOOP
            DBMS_OUTPUT.PUT_LINE('The employees working in department: '|| v_dept_id||' are ');
            DBMS_OUTPUT.PUT_LINE(chr(25)||'--------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE('Full name '||v_emp.full_name);
            DBMS_OUTPUT.PUT_LINE('Salary '||v_emp.salary);
            
        END LOOP;
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Sorry, no records found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: '||SQLERRM);
    
END;
/