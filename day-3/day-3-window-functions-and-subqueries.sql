-- SQL Day 3 - Window Functions and Subqueries
-- Topic: RANK(), DENSE_RANK(), correlated subqueries, and overall averages.

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
    (3, 'Charlie', 80000, 10),
    (4, 'David', 70000, 20),
    (5, 'Emma', 90000, 20),
    (6, 'Frank', 75000, 20),
    (7, 'Grace', 50000, 30),
    (8, 'Henry', 50000, 30);

-- ============================================================
-- Problem 1: Highest-paid employee(s) in each department
-- RANK() returns all employees tied for the highest salary.
-- ============================================================
SELECT department_id,
       name,
       salary
FROM
(
    SELECT *,
           RANK() OVER (
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employee
) t
WHERE salary_rank = 1;

-- ============================================================
-- Problem 2: Second-highest salary level in each department
-- RANK() can skip rank numbers after a tie.
-- Example: 80000, 80000, 60000 -> ranks 1, 1, 3.
-- ============================================================
SELECT department_id,
       name,
       salary
FROM
(
    SELECT *,
           RANK() OVER (
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employee
) t
WHERE salary_rank = 2;

-- ============================================================
-- Problem 3: Second-highest DISTINCT salary in each department
-- DENSE_RANK() does not skip rank numbers after ties.
-- Example: 80000, 80000, 60000 -> ranks 1, 1, 2.
-- ============================================================
SELECT department_id,
       name,
       salary
FROM
(
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employee
) t
WHERE salary_rank = 2;

-- ============================================================
-- Problem 4: Top 2 salary levels from each department, including ties
-- DENSE_RANK() keeps all employees sharing a salary level.
-- ============================================================
SELECT department_id,
       name,
       salary
FROM
(
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employee
) t
WHERE salary_rank <= 2;

-- ============================================================
-- Problem 5: Highest-paid employee(s) in each department
-- using a correlated subquery instead of a window function.
-- ============================================================
SELECT e.department_id,
       e.name,
       e.salary
FROM employee e
WHERE e.salary =
(
    SELECT MAX(e1.salary)
    FROM employee e1
    WHERE e1.department_id = e.department_id
);

-- ============================================================
-- Problem 6: Employees whose salary is above their department average
-- Correlated subquery: the inner query depends on the outer employee.
-- ============================================================
SELECT e.department_id,
       e.name,
       e.salary
FROM employee e
WHERE e.salary >
(
    SELECT AVG(e1.salary)
    FROM employee e1
    WHERE e1.department_id = e.department_id
);

-- ============================================================
-- Problem 7: Highest-paid employee(s) in each department whose salary
-- is also greater than the overall company average.
-- ============================================================
SELECT department_id,
       name,
       salary
FROM
(
    SELECT *,
           RANK() OVER (
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employee
) t
WHERE salary_rank = 1
  AND salary >
  (
      SELECT AVG(salary)
      FROM employee
  );

-- ============================================================
-- Problem 8: Second-highest salary in the entire company
-- No LIMIT, TOP, OFFSET, or window functions.
-- The inner MAX() removes the highest salary; the outer MAX()
-- finds the largest salary below it.
-- ============================================================
SELECT MAX(salary) AS second_highest_salary
FROM employee
WHERE salary <
(
    SELECT MAX(salary)
    FROM employee
);

-- If employee names are also required:
SELECT name,
       salary
FROM employee
WHERE salary =
(
    SELECT MAX(salary)
    FROM employee
    WHERE salary <
    (
        SELECT MAX(salary)
        FROM employee
    )
);

-- ============================================================
-- Key concepts learned today:
-- 1. RANK() gives the same rank to ties and can skip numbers.
-- 2. DENSE_RANK() gives the same rank to ties without gaps.
-- 3. Window functions are calculated in a subquery before filtering.
-- 4. PARTITION BY creates independent ranking/aggregation groups.
-- 5. Correlated subqueries compare each row with its own department.
-- 6. An uncorrelated AVG(salary) subquery gives the company average.
-- ============================================================
