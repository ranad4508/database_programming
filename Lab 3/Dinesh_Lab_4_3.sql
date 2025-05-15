/* Use CASE Statement to determine AVG, SUM of three number read from the user*/
SET SERVEROUTPUT ON;
DECLARE
    v_num1   NUMBER := &number_1;
    v_num2   NUMBER := &number_2;
    v_num3   NUMBER := &number_3;
    v_operation VARCHAR2(10);
    v_result   NUMBER;
BEGIN
    -- Show SUM
    v_operation := 'SUM';
    v_result := CASE v_operation
                  WHEN 'SUM' THEN (v_num1 + v_num2 + v_num3)
                END;
    DBMS_OUTPUT.PUT_LINE('Sum is: ' || v_result);

    -- Show AVG
    v_operation := 'AVG';
    v_result := CASE v_operation
                  WHEN 'AVG' THEN (v_num1 + v_num2 + v_num3) / 3
                END;
    DBMS_OUTPUT.PUT_LINE('Average is: ' || v_result);
END;
/


select * from employees;


/*
use searched case to find the list of employees who were hired on 30th jan 2005 and working in IT_dept 
*/
SET SERVEROUTPUT ON;

DECLARE
    v_result VARCHAR2(1000);
BEGIN
    SELECT CASE 
             WHEN e.hire_date = TO_DATE('30-JAN-2005', 'DD-MON-YYYY') 
                  AND d.department_name = 'IT' 
             THEN 'Employee: ' || e.first_name || ' ' || e.last_name || 
                  ' | Hired: ' || TO_CHAR(e.hire_date, 'DD-MON-YYYY')
             ELSE NULL
           END
    INTO v_result
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE ROWNUM = 1;
END;
/

/*
CASE Expression
Read marks obtained of 5 subjects of any student carrying 100 marks each,
Print the message (grage) as per the table attached
if >= 80 'Distinction',
if >=65 & < 80 'First Division',
if >=55 & <65 'Second Division',
if >=45 & <55 'Third Division',
if < 45, 'Failed'

*/
SET SERVEROUTPUT ON;

DECLARE
    v_subject1 NUMBER := &marks_1;
    v_subject2 NUMBER := &marks_2;
    v_subject3 NUMBER := &marks_3;
    v_subject4 NUMBER := &marks_4;
    v_subject5 NUMBER := &marks_5;
    v_total_marks NUMBER;
    v_percentage NUMBER;
    v_grade VARCHAR2(20);
BEGIN
    -- Calculate total marks and percentage
    v_total_marks := v_subject1 + v_subject2 + v_subject3 + v_subject4 + v_subject5;
    v_percentage := (v_total_marks / 500) * 100;
    
    -- Determine grade using searched CASE
    v_grade := CASE 
                  WHEN v_percentage >= 80 THEN 'Distinction'
                  WHEN v_percentage >= 65 AND v_percentage < 80 THEN 'First Division'
                  WHEN v_percentage >= 55 AND v_percentage < 65 THEN 'Second Division'
                  WHEN v_percentage >= 45 AND v_percentage < 55 THEN 'Third Division'
                  WHEN v_percentage < 45 THEN 'Failed'
                  ELSE 'Invalid Input'
               END;
    
    -- Output result
    DBMS_OUTPUT.PUT_LINE('Total Marks: ' || v_total_marks);
    DBMS_OUTPUT.PUT_LINE('Percentage: ' || v_percentage || '%');
    DBMS_OUTPUT.PUT_LINE('Grade: ' || v_grade);
END;
/




