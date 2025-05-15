-- Read your anme suing substitution variable and print it 5 times in upper case
SET SERVEROUTPUT ON;

DECLARE
    v_name VARCHAR2(100) := UPPER('&your_name');
    v_counter NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_name);
        v_counter := v_counter + 1;

        IF v_counter > 5 THEN
            EXIT;
        END IF;
    END LOOP;
END;
/

-- print the sum of square of natural number less than N using EXIT WHEN in a simple loop
SET SERVEROUTPUT ON;

DECLARE
    v_n NUMBER := &num;
    v_i NUMBER := 1;
    v_sum_sq NUMBER := 0;
BEGIN
    LOOP
        v_sum_sq := v_sum_sq + (v_i * v_i);
        v_i := v_i + 1;

        EXIT WHEN v_i >= v_n;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Sum of squares of natural numbers less than ' || v_n || ' is: ' || v_sum_sq);
END;
/