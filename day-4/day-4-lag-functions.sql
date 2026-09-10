-- SQL Day 4 - LAG() Window Function
-- Topic: Comparing the current row with the previous row.
--
-- Concepts learned today:
-- 1. LAG() returns a value from a previous row.
-- 2. ORDER BY inside OVER() determines what "previous" means.
-- 3. Window-function results can be filtered by wrapping the query in a subquery.
-- 4. salary - previous_salary calculates the change from the previous row.
-- 5. RANK() with PARTITION BY can find the highest-paid employee in each department.
--
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
    (1, 'Alice', 60000, 10),
    (2, 'Bob', 80000, 10),
    (3, 'Charlie', 75000, 10),
    (4, 'David', 90000, 20),
    (5, 'Emma', 85000, 20),
    (6, 'Frank', 95000, 20);

-- ============================================================
-- Problem 1: Employees whose salary is greater than the previous
-- employee's salary when ordered by id.
--
-- LAG(salary) looks at the salary from the previous row.
-- ============================================================
SELECT
    name,
    salary,
    previous_salary
FROM (
    SELECT
        name,
        salary,
        LAG(salary) OVER (ORDER BY id) AS previous_salary
    FROM employee
) t
WHERE salary > previous_salary;

-- Expected result:
-- Bob      80000   60000
-- David    90000   75000
-- Frank    95000   85000

-- ============================================================
-- Problem 2: Find salary increases and calculate the difference.
-- ============================================================
SELECT
    name,
    salary,
    previous_salary,
    salary - previous_salary AS salary_difference
FROM (
    SELECT
        name,
        salary,
        LAG(salary) OVER (ORDER BY id) AS previous_salary
    FROM employee
) t
WHERE salary > previous_salary;

-- Expected result:
-- Bob      80000   60000   20000
-- David    90000   75000   15000
-- Frank    95000   85000   10000

-- ============================================================
-- Problem 3: Highest-paid employee in each department without MAX(),
-- LIMIT, or TOP.
--
-- RANK() assigns rank 1 to the highest salary within each department.
-- PARTITION BY creates a separate ranking for every department.
-- ============================================================
SELECT
    department_id,
    name,
    salary
FROM (
    SELECT
        department_id,
        name,
        salary,
        RANK() OVER (
            PARTITION BY department_id
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employee
) t
WHERE salary_rank = 1;

-- Expected result:
-- 10   Bob    80000
-- 20   Frank  95000

-- ============================================================
-- Key syntax
-- ============================================================
-- Previous row:
-- LAG(column) OVER (ORDER BY id)
--
-- Next row (to be practiced next time):
-- LEAD(column) OVER (ORDER BY id)
--
-- General pattern:
-- SELECT ...
-- FROM (
--     SELECT ..., LAG(column) OVER (ORDER BY something) AS previous_value
--     FROM table
-- ) t
-- WHERE ...;
