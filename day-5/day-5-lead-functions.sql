-- SQL Day 5 - LEAD() Window Function
-- Topic: Comparing the current row with the next row.
--
-- Concepts learned today:
-- 1. LEAD() returns a value from a following row.
-- 2. ORDER BY inside OVER() determines what "next" means.
-- 3. PARTITION BY creates a separate window for each group.
-- 4. The last row in each window returns NULL because there is no next row.
-- 5. Window functions can be used inside subqueries for further filtering/calculations.
--
-- Sample table
CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department VARCHAR(50)
);

-- Sample data
INSERT INTO employee (id, name, salary, department)
VALUES
    (1, 'A', 40000, 'IT'),
    (2, 'B', 50000, 'IT'),
    (3, 'C', 60000, 'IT'),
    (4, 'D', 35000, 'HR'),
    (5, 'E', 45000, 'HR');

-- ============================================================
-- Problem 1: Find the next employee's salary when ordered by id.
-- ============================================================
SELECT
    name,
    salary,
    LEAD(salary) OVER (ORDER BY id) AS next_salary
FROM employee;

-- Expected result:
-- A   40000   50000
-- B   50000   60000
-- C   60000   35000
-- D   35000   45000
-- E   45000   NULL

-- ============================================================
-- Problem 2: Find the next employee's salary within the same
-- department.
--
-- PARTITION BY department creates a separate window for IT and HR.
-- Therefore, the last IT employee does not get the first HR salary
-- as the next value.
-- ============================================================
SELECT
    name,
    department,
    salary,
    LEAD(salary) OVER (
        PARTITION BY department
        ORDER BY id
    ) AS next_salary
FROM employee;

-- Expected result:
-- A   IT   40000   50000
-- B   IT   50000   60000
-- C   IT   60000   NULL
-- D   HR   35000   45000
-- E   HR   45000   NULL

-- ============================================================
-- Problem 3: Calculate the difference between the next salary
-- and the current salary within each department.
-- ============================================================
SELECT
    name,
    department,
    salary,
    next_salary,
    next_salary - salary AS salary_difference
FROM (
    SELECT
        name,
        department,
        salary,
        LEAD(salary) OVER (
            PARTITION BY department
            ORDER BY id
        ) AS next_salary
    FROM employee
) t;

-- Expected result:
-- A   IT   40000   50000   10000
-- B   IT   50000   60000   10000
-- C   IT   60000   NULL    NULL
-- D   HR   35000   45000   10000
-- E   HR   45000   NULL    NULL

-- ============================================================
-- Key syntax
-- ============================================================
-- Previous row:
-- LAG(column) OVER (ORDER BY id)
--
-- Next row:
-- LEAD(column) OVER (ORDER BY id)
--
-- Next row within each group:
-- LEAD(column) OVER (
--     PARTITION BY group_column
--     ORDER BY id
-- )
--
-- Important:
-- id is a column in the employee table used to define row order.
-- A subquery only exposes columns included in its SELECT list.
