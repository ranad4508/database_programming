/* creating table for the trigger*/

CREATE TABLE tbl_salary_audit (
    emp_id NUMBER,
    updated_by NVARCHAR2(50) NOT NULL,
    old_salary NUMBER(8,2),
    updated_date DATE NOT NULL
);


/*Before trigger to insert into the table*/
SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER tr_salary_audit
BEFORE UPDATE ON Employees
FOR EACH ROW
DECLARE
    v_emp_id Employees.employee_id%TYPE := :OLD.employee_id;
    v_updated_by NVARCHAR2(50) := USER;
    v_old_salary Employees.salary%TYPE := :OLD.salary;
    v_updated_date DATE := SYSDATE;
BEGIN
    INSERT INTO tbl_salary_audit
    VALUES(v_emp_id, v_updated_by, v_old_salary, v_updated_date);
--    COMMIT;
END;
/

UPDATE employees set salary = 1.5*salary
WHERE employee_id IN (199, 200, 201);

select * from tbl_salary_audit;