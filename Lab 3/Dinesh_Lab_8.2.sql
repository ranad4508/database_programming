/*
Prepare a AFTER DELETE TRIGGER that reccord the employee_id, sysdate, user information in tbl_delete_audit
*/

CREATE TABLE tbl_delete_audit (
    emp_id NUMBER,
    deleted_on DATE NOT NULL,
    deleted_by NVARCHAR2(50) NOT NULL
);


CREATE OR REPLACE TRIGGER tr_after_delete_employee
AFTER DELETE ON Employees
FOR EACH ROW
DECLARE
    v_emp_id Employees.employee_id%TYPE := :OLD.employee_id;
    v_deleted_on DATE := SYSDATE;
    v_deleted_by NVARCHAR2(50) := USER;
BEGIN
    INSERT INTO tbl_delete_audit (
        emp_id,
        deleted_on,
        deleted_by
    ) VALUES (
        v_emp_id,
        v_deleted_on,
        v_deleted_by
    );
END;
/

DELETE FROM Employees WHERE employee_id = 207;
COMMIT;

select * from employees;

SELECT * FROM tbl_delete_audit;

