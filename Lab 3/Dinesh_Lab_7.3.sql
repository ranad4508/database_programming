
/*
Using cursor for loops and nested cursors
*/
SET SERVEROUTPUT ON;
DECLARE
    CURSOR cr_emp IS
        SELECT employee_id, last_name || ' ' || first_name AS full_name, salary
        FROM Employees
        WHERE salary < 5000; 
    cr_var cr_emp%ROWTYPE;
BEGIN
    FOR cr_var IN cr_emp
        LOOP
            INSERT INTO temp_employees_2000_less
            (emp_id, full_name, salary)
            VALUES
            (cr_var.employee_id, cr_var.full_name, cr_var.salary);
            
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Record Inserted Successfully');
COMMIT;
END;
/

select * from temp_employees_2000_less;


   
CREATE TABLE temp_employees_2000_less (
  emp_id NUMBER,
  full_name NVARCHAR2(100),
  salary NUMBER(8,2)
);
