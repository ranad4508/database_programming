/*
Calculate amount dispersed from the department table
*/
SET SERVEROUTPUT ON;
DECLARE 
    TYPE dept_total_dispersed IS RECORD (
        dept_id Departments.department_id%TYPE,
        dept_name Departments.department_name%TYPE,
        total_amt_dispersed Employees.salary%TYPE
    );
    ty_dept_amt dept_total_dispersed;
BEGIN
    SELECT d.department_id, d.department_name, SUM(e.salary)
    INTO ty_dept_amt
    FROM Departments d
    INNER JOIN Employees e
        ON d.department_id = e.department_id
    WHERE d.department_id = 50
    GROUP BY d.department_id, d.department_name;
    DBMS_OUTPUT.PUT_LINE(
        'Department name ' || ty_dept_amt.dept_name || 
        ' has total fund requirement of: ' || ty_dept_amt.total_amt_dispersed
    );
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Sorry, no record found');
END;
/

     

    
    
    