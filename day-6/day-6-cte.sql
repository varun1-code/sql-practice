-- SQL Day 6 - CTE (Common Table Expression)
-- Topic: Using a CTE with JOIN and GROUP BY.
--
-- Concepts learned:
-- 1. A CTE creates a temporary named result using WITH.
-- 2. The CTE can calculate department-level averages.
-- 3. JOIN connects employees with their department average.
-- 4. WHERE filters employees whose salary is above their department average.
--
-- Sample table
CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

-- Sample data
INSERT INTO employee (id, name, department, salary)
VALUES
    (1, 'Alice', 'IT', 60000),
    (2, 'Bob', 'IT', 80000),
    (3, 'Charlie', 'HR', 50000),
    (4, 'David', 'HR', 70000),
    (5, 'Emma', 'IT', 90000);

-- ============================================================
-- Problem:
-- Find the average salary for each department and display only
-- employees whose salary is greater than their department average.
-- ============================================================

-- Step 1: Create a CTE containing the average salary of each department.
WITH department_average AS (
    SELECT
        department,
        AVG(salary) AS average_salary
    FROM employee
    GROUP BY department
)

-- Step 2: Join employees with their department average
-- and filter employees above that average.
SELECT
    e.name,
    e.department,
    e.salary
FROM employee e
JOIN department_average d
    ON e.department = d.department
WHERE e.salary > d.average_salary;

-- Expected result:
-- Bob   | IT | 80000
-- Emma  | IT | 90000
-- David | HR | 70000

-- ============================================================
-- How it works:
--
-- The CTE creates:
--
-- department | average_salary
-- IT         | 76666.67
-- HR         | 60000
--
-- Then JOIN matches each employee with the average
-- of their own department.
--
-- Finally:
-- WHERE e.salary > d.average_salary
--
-- keeps only employees earning above their department average.
-- ============================================================

-- Key syntax:
--
-- WITH cte_name AS (
--     SELECT ...
-- )
-- SELECT ...
-- FROM table
-- JOIN cte_name
--     ON ...
-- WHERE ...;
