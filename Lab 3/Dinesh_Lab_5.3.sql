-- Display all even multiples of 3 less than N
SET SERVEROUTPUT ON;
DECLARE
    v_num NUMBER := &num;
    v_result NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Even multiples of 3: ');
    FOR i IN 1 .. v_num LOOP
        v_result := i * 3;

        EXIT WHEN v_result >= v_num;

        IF MOD(v_result, 2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(v_result);
        END IF;
    END LOOP;
END;
/


-- Display the factorial of each number less than N in reverse order using IN REVERSE
SET SERVEROUTPUT ON;

DECLARE
    v_num NUMBER(10) := &num;  
    v_factorial NUMBER(10);
    i NUMBER;
    j NUMBER;
BEGIN

    FOR i IN REVERSE 1 .. v_num - 1 LOOP
        v_factorial := 1;
        
        FOR j IN 1 .. i LOOP
            v_factorial := v_factorial * j;
        END LOOP;

        DBMS_OUTPUT.PUT_LINE('Factorial of '||i || ' = ' || v_factorial);
    END LOOP;
END;
/


-- Find the prime number between 1 and N but not more than 15
SET SERVEROUTPUT ON;

DECLARE
    v_num NUMBER := &N;
    v_is_prime BOOLEAN;
BEGIN
    FOR i IN 2 .. 15 LOOP
        EXIT WHEN i > v_num;

        v_is_prime := TRUE;

        FOR j IN 2 .. i - 1 LOOP
            IF MOD(i, j) = 0 THEN
                v_is_prime := FALSE;
                EXIT;
            END IF;
        END LOOP;

        IF v_is_prime THEN
            DBMS_OUTPUT.PUT_LINE(i || ' is a prime number');
        END IF;
    END LOOP;
END;
/


-- Demonstrate the use of CONTINUE statement to find the sum of odd multiples of 5 less than N
SET SERVEROUTPUT ON;
DECLARE
    v_num NUMBER(10) := &num;
    v_sum NUMBER := 0;
BEGIN
    FOR i IN 1..v_num-1 LOOP
        IF MOD(i, 5) != 0 THEN
            CONTINUE;
        END IF;

        IF MOD(i, 2) = 0 THEN
            CONTINUE;
        END IF;

        v_sum := v_sum + i;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Sum of odd multiples of 5 less than ' || v_num || ' is: ' || v_sum);
END;
/


