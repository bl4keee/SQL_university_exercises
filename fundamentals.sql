--1 
SELECT * FROM EMPLOYEES;

--2
DESCRIBE employees;

--3
SELECT * FROM DEPARTMENTS;
SELECT * FROM POSITIONS;
SELECT * FROM JOB_GRADES;

--4
SELECT DISTINCT DEP_ID FROM EMPLOYEES WHERE DEP_ID IS NOT null;

--5
SELECT FIRST_NAME, LAST_NAME, SALARY*12 AS ROCZNA_PENSJA FROM EMPLOYEES;

--6
SELECT first_name||' '||last_name AS nazwa, employees.jg_id
FROM employees
WHERE dep_id = '40';

--7
SELECT last_name,manager_id,salary 
FROM employees 
WHERE salary BETWEEN 3000 AND 8000;

--8
SELECT last_name,hire_date,salary 
FROM EMPLOYEES 
WHERE first_name LIKE 'Nic%' OR last_name LIKE 'Nic%';

--9
SELECT name,max_salary - min_salary AS roznica FROM job_grades;

--10
SELECT first_name, last_name, manager_id 
FROM employees 
WHERE first_name NOT LIKE '%i%' AND last_name LIKE '_a%';

--11
SELECT last_name
FROM employees
WHERE dep_id=30
ORDER BY last_name ASC;

--12
SELECT first_name, last_name
FROM employees
WHERE dep_id IS NULL;

--13
SELECT last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1997-01-01' AND '1999-01-01';

--14
SELECT last_name, salary
FROM employees
WHERE dep_id IN (20, 40, 50)
ORDER BY 2 DESC;

--15
SELECT last_name, salary AS pensja, allowance AS dodatek
FROM employees
WHERE salary+allowance<5000
ORDER BY salary DESC, allowance DESC;

--16
SELECT last_name, dep_id, jg_id
FROM employees
WHERE jg_id NOT IN (4, 8)
ORDER BY 2 ASC, last_name DESC;

SELECT last_name, dep_id, jg_id
FROM employees
WHERE jg_id <> 4 AND jg_id <> 8
ORDER BY dep_id ASC, last_name DESC;

--17
SELECT name, location
FROM departments
ORDER BY 1;

--18
SELECT first_name, last_name
FROM employees
WHERE manager_id IS NULL;

--19
SELECT pos_id
FROM employees
WHERE dep_id IN (30);

--20
SELECT last_name, first_name
FROM employees
WHERE salary+allowance > 7000 AND EXTRACT(YEAR FROM hire_date) IN (2001);
