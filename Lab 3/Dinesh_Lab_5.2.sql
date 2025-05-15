-- Write a simple program in PL/SQL that prints all the even number less than N. Using WHILE LOOP
SET SERVEROUTPUT ON;

DECLARE
    v_num NUMBER := &num;
    v_i NUMBER := 1;
BEGIN
    WHILE v_i < v_num LOOP
        IF MOD(v_i, 2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(v_i);
        END IF;
        v_i := v_i + 1;
    END LOOP;
END;
/
