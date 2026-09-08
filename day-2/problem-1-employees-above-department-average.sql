-- SQL Day 2 - Problem 1
-- Problem: Find employees whose salary is greater than the average salary of their department.

-- Sample table
CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department_id INT
);

-- Sample data
INSERT INTO employee (id, name, salary, department_id)
VALUES
    (1, 'Alice', 60000, 1),
    (2, 'Bob', 50000, 1),
    (3, 'Charlie', 80000, 1),
    (4, 'David', 40000, 2),
    (5, 'Emma', 70000, 2),
    (6, 'Frank', 60000, 2);

-- ============================================================
-- Solution 1: Correlated Subquery
-- For each employee, calculate the average salary of their department.
-- ============================================================
SELECT e.name,
       e.salary,
       e.department_id
FROM employee e
WHERE e.salary >
(
    SELECT AVG(e2.salary)
    FROM employee e2
    WHERE e2.department_id = e.department_id
);

-- Expected result:
-- Charlie | 80000 | 1
-- Emma    | 70000 | 2

-- ============================================================
-- Solution 2: GROUP BY + JOIN
-- First calculate one average per department, then join it to employees.
-- ============================================================
SELECT e.name,
       e.salary,
       e.department_id
FROM employee e
JOIN
(
    SELECT department_id,
           AVG(salary) AS avg_salary
    FROM employee
    GROUP BY department_id
) d
ON e.department_id = d.department_id
WHERE e.salary > d.avg_salary;

-- ============================================================
-- Solution 3: Window Function
-- AVG() OVER(PARTITION BY ...) keeps every employee row and adds
-- the average salary of that employee's department.
-- ============================================================
SELECT name,
       salary,
       department_id
FROM
(
    SELECT name,
           salary,
           department_id,
           AVG(salary) OVER (PARTITION BY department_id) AS avg_salary
    FROM employee
) t
WHERE salary > avg_salary;

-- Key concept:
-- GROUP BY collapses rows into groups.
-- Window functions keep the original rows while calculating group-level values.
-- Correlated subquery compares each employee with their department average.
