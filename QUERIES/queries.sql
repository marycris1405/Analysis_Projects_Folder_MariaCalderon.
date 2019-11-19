SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01'AND'1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01'AND'1952-12-31';
--21209

-- Retirement Eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01'AND'1955-12-31')
AND (hire_date BETWEEN '1985-01-01'AND '1988-12-31');
--41380

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01'AND'1955-12-31')
AND (hire_date BETWEEN '1985-01-01'AND '1988-12-31');
--41380

-- Creating New Tables of Retiring People
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01'AND'1955-12-31')
AND (hire_date BETWEEN '1985-01-01'AND '1988-12-31');

--Create new table for retiring employess
SELECT emp_no, first_name,last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN'1985-01-01'AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager table
SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no=dept_manager.dept_no;

--Joining retirement_info and dept_emp table
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dep_emp.to_date
FROM retirement_info
LEFT JOIN dep_emp
ON retirement_info.emp_no=dep_emp.emp_no;

--Joining retirement_info and dept_emp table
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dep_emp as de
ON ri.emp_no=de.emp_no
WHERE de.to_date=('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dep_emp as de
ON ce.emp_no=de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN'1952-01-01'AND'1955-12-31')
AND(hire_date BETWEEN '1985-01-01'AND'1988-12-31');

-- List 1. Employee Information
SELECT e.emp_no, e.first_name, e.last_name, e.gender,s.salary, de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no=s.emp_no)
INNER JOIN dep_emp as de
ON (e.emp_no=de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND(e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND(de.to_date='9999-01-01');

-- List 2. Management per department
SELECT dm.dept_no, d.dept_name, dm.emp_no, ce.last_name, ce.first_name, dm.from_date, dm.to_date
INTO manager_info
FROM dept_manager AS dm
INNER JOIN departments AS d 
ON (dm.dept_no=d.dept_no)
INNER JOIN current_emp AS ce
ON (dm.emp_no=ce.emp_no)

----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------            CHALLENGE             -----------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------

-- PART1. 
-- Number of Titles Retiring
SELECT ei.emp_no, ei.first_name, ei.last_name, ti.title, ti.from_date, ei.salary
INTO challenge1
FROM titles AS ti
RIGHT JOIN emp_info AS ei
ON (ti.emp_no=ei.emp_no)

-- PART1.1
-- Most recent titles
SELECT ei.emp_no, ei.first_name, ei.last_name, ti.title, ti.from_date, ei.salary
INTO challenge1
FROM titles AS ti
RIGHT JOIN emp_info AS ei
ON (ti.emp_no=ei.emp_no)

SELECT ei.emp_no, ei.first_name, ei.last_name,
ti.title, ti.from_date, ei.salary
INTO challenge1_1
FROM titles AS ti
RIGHT JOIN emp_info AS ei
ON (ti.emp_no=ei.emp_no)
ORDER BY from_date DESC;

--Most Recent Titles
SELECT first_name, last_name, count(*) AS frequency
FROM challenge1_1
GROUP BY first_name, last_name
HAVING count(*)>1
ORDER BY frequency DESC;
 
-- Ready for a Mentor
SELECT e.emp_no, e.first_name, e.last_name, e.birth_date,
ti.title
INTO challenge_mentor
FROM titles AS ti
RIGHT JOIN employees AS e
ON (ti.emp_no=e.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31');