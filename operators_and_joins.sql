-- Operators

--1
SELECT 1 "Numer", dep_id, last_name
FROM employees
WHERE dep_id = 10
UNION
SELECT 2, dep_id, last_name
FROM employees
WHERE dep_id = 50
UNION
SELECT 3, dep_id, last_name
FROM employees
WHERE dep_id = 20
ORDER BY 1;

--2
SELECT dep_id
FROM employees
GROUP BY dep_id
HAVING COUNT(*) = 4
INTERSECT
SELECT dep_id
FROM departments
WHERE TO_NUMBER(SUBSTR(location, 7, 3)) BETWEEN 200 AND 300;

--3
SELECT dep_id
FROM employees
GROUP BY dep_id
HAVING AVG(salary) > 4000
MINUS
SELECT dep_id
FROM departments
WHERE TO_NUMBER(SUBSTR(location, 7)) IN (113, 205);

--4
SELECT last_name
FROM employees
WHERE jg_id IN (7) AND hire_date < '1998-01-01';

-- JOINS

--1
-- 1a
SELECT last_name, d.dep_id, name
FROM employees e JOIN departments d ON (e.dep_id = d.dep_id)
ORDER BY 3;

-- 1b
SELECT last_name, d.dep_id, name
FROM employees e RIGHT OUTER JOIN departments d ON (e.dep_id = d.dep_id)
ORDER BY 3;

-- 1c
SELECT last_name, d.dep_id, name
FROM employees e LEFT OUTER JOIN departments d ON (e.dep_id = d.dep_id)
ORDER BY 3;

-- 1d
SELECT last_name, d.dep_id, name
FROM employees e FULL OUTER JOIN departments d ON (e.dep_id = d.dep_id)
ORDER BY 3;

--2
SELECT last_name, salary, name
FROM employees e JOIN departments d ON e.dep_id = d.dep_id
WHERE salary > 4000 AND allowance IS NOT NULL;

--3
SELECT last_name, j.name, d.name
FROM employees e JOIN departments d ON e.dep_id = d.dep_id JOIN job_grades j ON e.jg_id = j.jg_id
WHERE min_salary > 4000;

--4
SELECT e.last_name, d.name, m.last_name AS Nazwisko_szefa, g.name AS Dzia³_szefa
FROM employees e 
    JOIN departments d ON (e.dep_id = d.dep_id) 
    JOIN employees m ON (e.manager_id = m.emp_id) 
    JOIN departments g ON (m.dep_id = g.dep_id)
WHERE e.dep_id IN (20, 30);

--5
SELECT e.last_name AS Nazwisko_pracownika, m.last_name AS Nazwisko_szefa
FROM employees e JOIN employees m ON (e.manager_id = m.emp_id)
WHERE e.hire_date < m.hire_date;

--6
SELECT last_name, COALESCE(d.name, 'Brak dzia³u')
FROM employees e LEFT OUTER JOIN departments d ON (e.dep_id = d.dep_id);

--7
SELECT p.name, COUNT(*) Liczba_pracowników
FROM positions p JOIN employees e ON (p.pos_id = e.pos_id)
GROUP BY p.name
ORDER BY Liczba_pracowników;

--8
SELECT d.name Dzia³, p.name Stanowisko,  COUNT(*) Liczba_pracowników
FROM employees e JOIN departments d ON (e.dep_id = d.dep_id) JOIN positions p ON (e.pos_id = p.pos_id)
GROUP BY d.name, p.name
ORDER BY 1, 2;

--9
SELECT COALESCE(d.name, '-') Dzia³, COUNT(*) Liczba_pracowników, COALESCE(SUM(salary), 0) Suma_pensji
FROM employees e FULL OUTER JOIN departments d ON (e.dep_id = d.dep_id)
GROUP BY d.name
ORDER BY d.name;


SELECT NVL(name, '-') "Dzia³", COUNT(emp_id) "Liczba_pracowników", SUM(NVL(salary,0)) "Suma pensji"
FROM departments d FULL OUTER JOIN employees e ON (d.dep_id = e.dep_id)
GROUP BY name
ORDER BY 1;

--10
SELECT e.first_name, 
    e.last_name, 
    COALESCE(d.name, 'brak') Nazwa_dzia³u, 
    p.name Nazwa_stanowiska, 
    j.name Nazwa_grupy_zaszeregowania,
    COALESCE(CONCAT(m.first_name, m.last_name), 'brak') Szef
FROM employees e 
    LEFT JOIN departments d ON (e.dep_id = d.dep_id) 
    LEFT JOIN positions p ON (e.pos_id = p.pos_id) 
    LEFT JOIN job_grades j ON (e.jg_id = j.jg_id) 
    LEFT JOIN employees m ON (e.manager_id = m.emp_id)
ORDER BY e.last_name, e.first_name;


SELECT e.first_name Imie, 
    NVL(d.name, 'brak') Nazwa_dzia³u, 
    p.name Nazwa_stanowiska, 
    j.name Nazwa_grupy_zaszeregowania,
    NVL((m.first_name || ' ' || m.last_name), 'brak') Szef
FROM employees e 
    LEFT JOIN departments d ON (e.dep_id = d.dep_id) 
    LEFT JOIN positions p ON (e.pos_id = p.pos_id) 
    LEFT JOIN job_grades j ON (e.jg_id = j.jg_id) 
    LEFT JOIN employees m ON (e.manager_id = m.emp_id)
ORDER BY e.last_name, e.first_name;

--11
SELECT last_name, salary
FROM employees e JOIN departments d ON (e.dep_id = d.dep_id)
WHERE d.name = 'Sprzeda¿';

--12
SELECT last_name, d.name, d.location
FROM employees e JOIN departments d ON (e.dep_id = d.dep_id)
WHERE TO_NUMBER(SUBSTR(location, 7, 3)) > 200;

--13
SELECT e.last_name, d.name, m.last_name Nazwisko_szefa
FROM employees e JOIN departments d ON (e.dep_id = d.dep_id) JOIN employees m ON (e.manager_id = m.emp_id)
WHERE e.dep_id = m.dep_id;

--14
SELECT j.name, COUNT(*) Liczba_pracowników, AVG(salary) Œrednia_pensja
FROM employees e RIGHT JOIN job_grades j ON (e.jg_id = j.jg_id)
GROUP BY j.name;













