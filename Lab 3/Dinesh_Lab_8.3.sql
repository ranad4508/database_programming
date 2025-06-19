/*creating view for trigger types*/

CREATE VIEW top_earners AS
    SELECT * FROM Employees
    ORDER BY salary DESC;
    
    
select * from top_earners;

CREATE OR REPLACE TRIGGER tr_top_earners
INSTEAD OF DELETE ON top_earners
FOR EACH ROW
BEGIN  
    DELETE FROM employees
    WHERE employee_id = :OLD.employee_id;
END;
/


BEGIN
    DELETE FROM top_earners
    WHERE employee_id = 109;
    COMMIT;
END;
/

select * from top_earners;
select * from employees where employee_id = 109;
