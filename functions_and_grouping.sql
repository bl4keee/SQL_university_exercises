-- SINGLE LINE FUNCTIONS
--1
SELECT emp_id, last_name, salary*1.123 AS UberPensja,
ROUND(salary*1.123,0) AS Nowa_Pensja,
ROUND(salary*1.123)-salary AS Podwy¿ka,
trunc(salary*1.123,0) 
FROM employees;

--2
SELECT UPPER(last_name), LENGTH(first_name)
FROM employees
WHERE SUBSTR(last_name, 1, 1) BETWEEN 'B' AND 'N'
ORDER BY last_name ASC;

--3
SELECT SUBSTR(first_name, 1, 1) || '.' || last_name AS "Pracownik",
NVL(TO_CHAR(allowance), 'brak dodatku') AS "Dodatek"
FROM employees;

--4
SELECT last_name, TO_CHAR(hire_date, 'dd-mm-yyyy')
FROM employees
WHERE MONTHS_BETWEEN(SYSDATE, hire_date)/12 > 20;

--5
SELECT last_name, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date), 0) AS "Okres zatrudnienia"
FROM employees
WHERE SUBSTR(last_name, 1, 1) IN ('B', 'D', 'F')
ORDER BY "Okres zatrudnienia";

--6
SELECT last_name, hire_date "Data zatrudnienia", 
TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), 1),'Day, DD month, YYYY', 'nls_date_language = Polish') "Data weryfikacji"
FROM employees;

--7
SELECT NEXT_DAY('2020-01-01', 'Sobota') "Sobota"
FROM DUAL;

--8
SELECT POWER(2, 10) "2^10="
FROM DUAL;

--9
SELECT last_name, DECODE(jg_id, 2, 'II', 4, 'IV', 7, 'VII', 9, 'IX', jg_id)
FROM employees;

--10
SELECT first_name, last_name, salary+COALESCE(allowance, 0) Pensja,
CASE
    WHEN salary < 5000 THEN 'I'
    WHEN salary <= 8000 THEN 'II'
    WHEN salary > 8000 THEN 'III'
END AS Grupa_dofinansowania
FROM employees;

--11
SELECT last_name, salary, ROUND(COALESCE(allowance, 0)/salary, 2)
FROM employees;

--12
SELECT CONCAT(CAST(first_name AS CHAR(1)), CAST(last_name AS CHAR(1))) Inicja³y, EXTRACT(YEAR FROM hire_date)
FROM employees;

--13
SELECT last_name,
CASE 
    WHEN jg_id = 2 THEN 'II'
    WHEN jg_id = 4 THEN 'IV'
    WHEN jg_id = 7 THEN 'VII'
    WHEN jg_id = 9 THEN 'IX'
    ELSE 'brak'
END AS Grupa_zaszeregowania
FROM employees;


-- GROUP FUNCTIONS AND GROUPING
--1
SELECT MAX(salary), MIN(salary), AVG(salary), SUM(salary)
FROM employees;

--2
SELECT dep_id, MAX(salary), MIN(salary), AVG(salary)
FROM employees
WHERE dep_id IS NOT NULL
GROUP BY dep_id
ORDER BY dep_id;

--3
SELECT TO_CHAR(hire_date, 'YYYY'),
    MAX(salary + NVL(allowance, 0)),
    MIN(salary + NVL(allowance, 0)),
    AVG(salary + NVL(allowance, 0))
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY TO_CHAR(hire_date, 'YYYY');

--4
SELECT dep_id, COUNT(*), COUNT(allowance)
FROM employees
WHERE dep_id IS NOT NULL
GROUP BY dep_id;

--5
SELECT COUNT(DISTINCT dep_id)
FROM employees
WHERE dep_id IS NOT null;

--6
SELECT
    MAX(allowance),
    MIN(allowance),
    AVG(NVL(allowance, 0))
FROM employees;

--7
SELECT manager_id, MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) >= 3000;

--8
SELECT pos_id, MAX(hire_date) AS Najpozniejsza, MIN(hire_date) AS Najwczesniejsza
FROM employees
WHERE pos_id <>1 
GROUP BY pos_id;

--9
SELECT 
    jg_id,
    dep_id,
    AVG(salary)
FROM employees
WHERE dep_id IN (20, 30, 50)
GROUP BY jg_id, dep_id;


SELECT
    jg_id,
    dep_id,
    AVG(salary)
FROM employees
GROUP BY jg_id, dep_id
HAVING dep_id IN (20, 30, 50);

--10
SELECT 
    MAX(salary) Maximum,
    MIN(salary) Minimum,
    MAX(salary) - MIN(salary) Ró¿nica
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) IN (2001);

--11
SELECT
    jg_id,
    dep_id,
    MAX(salary),
    MIN(salary),
    AVG(salary)
FROM employees
GROUP BY jg_id, dep_id
ORDER BY dep_id ASC;

--12 
SELECT 
    dep_id,
    MAX(salary) - MIN(salary) Ró¿nica
FROM employees
GROUP BY dep_id;














