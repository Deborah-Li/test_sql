drop table if exists departments_dup;
CREATE TABLE departments_dup (
    dept_no CHAR(4) NULL,
    dept_name VARCHAR(40) NULL
);

insert into departments_dup (dept_no, dept_name
)select * from departments;

insert into departments_dup (dept_name)
values	('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002';
    
insert into departments_dup (dept_no) values ('d010'), ('d011');



drop table if exists dept_manager_dup;
CREATE TABLE dept_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);

insert into dept_manager_dup 
select * from dept_manager;

insert into dept_manager_dup (emp_no, from_date)
values 	(999904, '2017-01-01'), 
		(999905, '2017-01-01'), 
        (999906, '2017-01-01'), 
        (999907, '2017-01-01');
        
DELETE FROM dept_manager_dup 
WHERE
    dept_no = 'd001';

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

#left joins - connection of matching values in selected tables only
SELECT
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE t.title = 'Manager';
        

select * from departments;
select * from employees;
select * from titles where title = 'Manager';

#cross joins - connection of all values in the selected tables
SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < '10011'
ORDER BY e.emp_no;


SELECT 
    e.gender, COUNT(dm.emp_no) AS total
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;
