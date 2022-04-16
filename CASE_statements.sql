SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
	MAX(s.salary) - MIN(s.salary) AS diff_salary,
	CASE WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was higher than 30,000'
        ELSE 'Salary was not higher than 30,000'
    END AS salary_raise
FROM
    dept_manager dm
        LEFT JOIN
    employees e ON dm.emp_no = e.emp_no
    JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP by e.emp_no;


SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > sysdate() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no;

