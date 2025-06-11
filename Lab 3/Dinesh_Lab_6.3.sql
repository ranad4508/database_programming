/*
use EXCEPTION_INIT pragma to determine and represent a
duplicate value in primary key column
*/   

SELECT * FROM Regions;
INSERT INTO Regions(region_id, region_name) VALUES (4, 'APAC');

SET SERVEROUTPUT ON;

DECLARE 
    ex_duplicate_primary_key EXCEPTION;
    PRAGMA EXCEPTION_INIT(ex_duplicate_primary_key, -1);
BEGIN
    INSERT INTO Regions(region_id, region_name) VALUES (4, 'APAC');
EXCEPTION
    WHEN ex_duplicate_primary_key THEN
    DBMS_OUTPUT.PUT_LINE('Duplicate Primary Key: '||SQLERRM);
END;
/

