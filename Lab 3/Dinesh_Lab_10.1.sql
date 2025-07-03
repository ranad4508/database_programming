/*
Find the name of department when the department_id is passed in a function. 
The department name must be returned
*/
SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION getDepartmentName (
    d_id Departments.department_id%TYPE
) RETURN Departments.department_name%TYPE
IS
    d_name Departments.department_name%TYPE;
BEGIN
    SELECT department_name
    INTO d_name
    FROM departments
    WHERE department_id = d_id;

    RETURN d_name;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN('No department found for id: ' || d_id);
    WHEN OTHERS THEN
        RETURN('Technical error occurred: ' || SQLERRM);

END;
/


SELECT getDepartmentName(70) FROM DUAL;

select * from departments;


CREATE VIEW vw_getMaxEmployeeDeptId
AS
SELECT *
FROM (
    SELECT d.department_id
    FROM departments d
    INNER JOIN employees e ON d.department_id = e.department_id
    GROUP BY d.department_id
    ORDER BY COUNT(e.employee_id) DESC
)
WHERE ROWNUM = 1;

SELECT * FROM vw_getMaxEmployeeDeptId;

DECLARE
    Dno Departments.department_id%TYPE; 
    dname Departments.department_name%TYPE;
BEGIN

    SELECT department_id
    INTO Dno 
    FROM vw_getMaxEmployeeDeptId;    

    dname := getDepartmentName(Dno);    
    DBMS_OUTPUT.PUT_LINE('Department name is : '||dname);
END;
/