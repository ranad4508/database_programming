SET SERVEROUTPUT ON;
DECLARE
    v_first_name NVARCHAR2(35);
    v_last_name NVARCHAR2(35);
    c_counter CONSTANT NUMBER(10):=10;
BEGIN
    SELECT first_name, last_name
    INTO v_first_name, v_last_name
    FROM employees
    WHERE employee_id = 405;
DBMS_OUTPUT.PUT_LINE('The full name is' || v_last_name||' '||v_last_name);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Sorry, the record could not be found');
END;
/

-- find the salary and commission of employee whose employee_id is read from user
DECLARE
    v_emp_id NUMBER(10):=&eid;
    v_salary NUMERIC(8,2);
    v_comm_pct NUMERIC(6,2);
BEGIN
    SELECT salary, commission_pct
    INTO v_salary, v_comm_pct
    FROM employees
    WHERE employee_id = v_emp_id;
DBMS_OUTPUT.PUT_LINE('The salary is '|| v_salary || ' and commission is '|| v_comm_pct);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Sorry, the record could not be found');
END;
/


-- find the salary and commission of employee whose employee_id is read from user
DECLARE
    v_emp_id Employees.employee_id%TYPE:=&eid;
    v_salary Employees.salary%TYPE;
    v_comm_pct Employees.commission_pct%TYPE;
BEGIN
    SELECT salary, commission_pct
    INTO v_salary, v_comm_pct
    FROM employees
    WHERE employee_id = v_emp_id;
DBMS_OUTPUT.PUT_LINE('The salary is '|| v_salary || ' and commission is '|| v_comm_pct);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Sorry, the record could not be found');
END;
/


SET SERVEROUTPUT ON;
<<show_data>>
BEGIN
    DBMS_OUTPUT.PUT_LINE('The procedure is executing');
END show_data;
/

-- Read the employee_id from the user using substitution variable and find the full_name of the manager
SET SERVEROUTPUT ON;
DECLARE
  v_emp_id employees.employee_id%TYPE := &employee_id;
  v_manager_id employees.manager_id%TYPE;
  v_manager_name NVARCHAR2(100);
BEGIN
  -- First get the manager_id of the employee
  SELECT manager_id INTO v_manager_id
  FROM employees
  WHERE employee_id = v_emp_id;

  -- Now get the manager name from that ID
  SELECT first_name || ' ' || last_name
  INTO v_manager_name
  FROM employees
  WHERE employee_id = v_manager_id;

  DBMS_OUTPUT.PUT_LINE('Manager Name: ' || v_manager_name);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No manager found for the given employee ID.');
END;
/


DESCRIBE Locations;

select * from regions;

select * from countries;


select * from locations;

/*
find the region_id of 'Asia', v_reg_id
prepare the INSERT statement with v_reg_id and country_name 'Nepal"
get the country_id of nepal, v_country_id
insert into location, v_country_id and city, Sanepa, chabhill
commit
end
*/
SET SERVEROUTPUT ON;
DECLARE
  v_reg_id regions.region_id%TYPE;
  v_country_id countries.country_id%TYPE := 'NP';
BEGIN
  -- Get region_id of Asia
  SELECT region_id INTO v_reg_id
  FROM regions
  WHERE region_name = 'Asia';

  -- Insert Nepal into countries
  INSERT INTO countries (country_id, country_name, region_id)
  VALUES (v_country_id, 'Nepal', v_reg_id);

  -- Insert two locations in Nepal
  INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id)
  VALUES (3301, 'Sanepa Street', '44700', 'Sanepa', 'Bagmati', v_country_id);

  INSERT INTO locations (location_id, street_address, postal_code, city, state_province, country_id)
  VALUES (3302, 'Chabhill Street', '44800', 'Chabhill', 'Bagmati', v_country_id);

  COMMIT;

  DBMS_OUTPUT.PUT_LINE('Nepal and locations inserted successfully.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Asia region not found.');
END;
/

SELECT * FROM locations;






