/*
Find the list of all the employees from a particular country.
Use parametric cursor to fetch and display the data
*/
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_employees_by_country(p_country_name VARCHAR2) IS
        SELECT e.employee_id, 
               e.first_name || ' ' || e.last_name AS full_name, 
               e.salary, 
               c.country_name
        FROM employees e
        JOIN departments d ON e.department_id = d.department_id
        JOIN locations l ON d.location_id = l.location_id
        JOIN countries c ON l.country_id = c.country_id
        WHERE c.country_name = p_country_name;
    v_country_name VARCHAR2(50) := '&p_country_name';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Employees from country: ' || v_country_name);
    FOR emp IN c_employees_by_country(v_country_name) LOOP
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp.employee_id || ', Full Name: ' || emp.full_name || ', Salary: ' || emp.salary || ', Country: ' || emp.country_name);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employees found for the specified country.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

SELECT * FROM Countries;

/*
1. Explain the PL/SQL block diagram.
2. How can we use DML operations in PL/SQL? Explain through any example of your own choice.
3. What are various LOOPS in PL/SQL? Demonstrate reverse FOR LOOP through any example.
4. What is an exception? List any two built-in and also create a user-defined exception. 
    Finally write PL/SQL block to implement them
5. What is a PRAGMA? Explain the use-cases of INIT PRAGMA and RAISE_APPLICATION_ERROR.
6. Describe about the lifecycle of a cursor. Create a cursor to fetch all the employees earning less than specified value.
    Use parametric cursor and cursor for loop.
7. Define nested exceptions. Explain exception propagation in case of nested exception.
8. With a simple example explain nested-IF-ELSE in PL/SQL.

*/
