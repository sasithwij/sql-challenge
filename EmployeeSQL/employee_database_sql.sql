DROP VIEW IF EXISTS "1.emp_salary";
DROP VIEW IF EXISTS "2.emp_1986_hires";
DROP VIEW IF EXISTS "3.dept_manager_emp";
DROP VIEW IF EXISTS "4.emp_dept" CASCADE;
DROP VIEW IF EXISTS "5.herculesb_emp";
DROP VIEW IF EXISTS "6.emp_sales";
DROP VIEW IF EXISTS "7.emp_sales_development";
DROP VIEW IF EXISTS "8.count_last_name";

CREATE TABLE "titles" (
    "title_id" VARCHAR(5)   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR(5)   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR(4)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(4)   NOT NULL,
    "emp_no" INTEGER   NOT NULL
);

CREATE VIEW "1.emp_salary" AS
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s
ON (e.emp_no = s.emp_no);


CREATE VIEW "2.emp_1986_hires" AS
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%/1986';

CREATE VIEW "3.dept_manager_emp" AS
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name 
FROM departments d
JOIN dept_manager dm
ON (d.dept_no = dm.dept_no) 
JOIN employees e
ON (dm.emp_no = e.emp_no);

CREATE VIEW "4.emp_dept" AS
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de
ON (e.emp_no = de.emp_no) 
JOIN departments d
ON (de.dept_no = d.dept_no)
ORDER BY emp_no;

CREATE VIEW "5.herculesb_emp" AS
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

CREATE VIEW "6.emp_sales" AS
SELECT * FROM "4.emp_dept"
WHERE dept_name = 'Sales';

CREATE VIEW "7.emp_sales_development" AS
SELECT * FROM "4.emp_dept"
WHERE dept_name = 'Sales' OR dept_name = 'Development';

CREATE VIEW "8.count_last_name" AS
SELECT last_name, COUNT(last_name) AS "count_of_last_name"
FROM employees
GROUP BY last_name 
ORDER BY "count_of_last_name" DESC;

SELECT * FROM employees
WHERE emp_no = '499942';