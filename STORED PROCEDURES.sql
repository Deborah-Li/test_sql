use employees;

drop procedure if exists emp_avg_salary;

-- outter parameter 
delimiter //
create procedure emp_avg_salary_out(IN p_emp_no INTEGER, out p_avg_salary DECIMAL(10,2))
begin
	SELECT 
    AVG(s.salary)
    INTO p_avg_salary FROM 
    employees e
    JOIN salaries s ON e.emp_no = s.emp_no
    where 
    e.emp_no = p_emp_no;
end//

delimiter ;

call emp_avg_salary(11300);


delimiter //
CREATE PROCEDURE emp_info(IN p_first_name VARCHAR(225), IN p_last_name VARCHAR(225), out p_emp_no INTEGER)

BEGIN
	SELECT e.emp_no 
    INTO p_emp_no FROM employees e 
    WHERE e.first_name = p_first_name AND e.last_name = p_last_name;
END //
delimiter ;
-- variables
SET @v_emp_no = 0;
CALL employees.emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;

-- user defined funcations
delimiter //
CREATE FUNCTION emp_info (p_first_name VARCHAR(255), p_last_name VARCHAR(255)) RETURNS DECIMAL(10,2)
DETERMINISTIC NO SQL READS SQL DATA
BEGIN
DECLARE v_max_from_date DATE;
DECLARE v_salary DECIMAL(10,2);

SELECT 
    MAX(from_date)
INTO v_max_from_date FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;

SELECT s.salary
INTO v_salary FROM
employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.first_name = p_first_name
    AND s.from_date = v_max_from_date;
    
RETURN v_salary;
END //

delimiter ;




