--Substitution variable
SET SERVEROUTPUT ON;
-- Insert a new record in departments table
DECLARE
  v_dept_id departments.department_id%TYPE := &Department_ID;
  v_dept_name departments.department_name%TYPE := '&Department_Name';
  v_manager_id departments.manager_id%TYPE := &Manager_ID;
  v_location_id departments.location_id%TYPE := &Location_ID;
BEGIN
  INSERT INTO departments (department_id, department_name, manager_id, location_id)
  VALUES (v_dept_id, v_dept_name, v_manager_id, v_location_id);
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('New record inserted successfully.');
END;
/

Select *  From departments;


--  Update the salary of employee whose employee_id is read from 
--  the user through substitution variable
SET SERVEROUT ON;
DECLARE
  v_emp_id employees.employee_id%TYPE := &emp_id;
  v_new_salary NUMBER := &salary;
BEGIN
  UPDATE employees
  SET salary = v_new_salary
  WHERE employee_id = v_emp_id;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Salary updated successfully.');
END;
/

Select * from employees;


-- find the list of all employees whose salary is less than 2500

