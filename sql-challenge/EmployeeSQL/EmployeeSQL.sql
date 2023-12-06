CREATE TABLE titles (
	title_id VARCHAR(30) NOT NULL PRIMARY KEY,
	title VARCHAR(30) NOT NULL
);

CREATE TABLE departments (
	dept_no VARCHAR(30) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(30) NOT NULL
);

CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR(30) NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
	birth_date DATE,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(30) NOT NULL,
	hire_date DATE
);

CREATE TABLE salaries (
	emp_no INT NOT NULL PRIMARY KEY,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	salary INT NOT NULL
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	dept_no VARCHAR(30) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);


CREATE TABLE dept_manager (
	dept_no VARCHAR(30) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON
salaries.emp_no=employees.emp_no;

SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE 
		hire_date >= '19860101' 
		AND hire_date <= '19861231';
		
SELECT dept_manager.emp_no, dept_manager.dept_no, departments.dept_name, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN departments ON
departments.dept_no=dept_manager.dept_no 
INNER JOIN employees ON
employees.emp_no=dept_manager.emp_no;

SELECT dept_emp.dept_no, dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN employees ON
employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON
departments.dept_no=dept_emp.dept_no;

SELECT employees.first_name, employees.last_name, employees.sex
FROM employees
WHERE
		first_name = 'Hercules'
		AND last_name like 'B%';
		
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN employees ON
employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON
departments.dept_no=dept_emp.dept_no
WHERE
		dept_name = 'Sales';
		
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN employees ON
employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON
departments.dept_no=dept_emp.dept_no
WHERE
		dept_name = 'Sales'
		OR dept_name = 'Development';
		
SELECT last_name, COUNT(last_name) AS "last name count"
FROM employees
GROUP BY last_name
ORDER BY "last name count" DESC;