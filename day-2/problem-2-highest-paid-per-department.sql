-- SQL Day 2 - Problem 2
-- Problem: Find the highest-paid employee in each department.

-- Sample data is the employee table created in Problem 1:
-- id | name    | salary | department_id
-- 1  | Alice   | 60000  | 1
-- 2  | Bob     | 50000  | 1
-- 3  | Charlie | 80000  | 1
-- 4  | David   | 40000  | 2
-- 5  | Emma    | 70000  | 2
-- 6  | Frank   | 60000  | 2

-- ============================================================
-- Solution 1: Correlated Subquery
-- Find the maximum salary within the current employee's department.
-- ============================================================
SELECT e.name,
       e.id,
       e.department_id,
       e.salary
FROM employee e
WHERE e.salary =
(
    SELECT MAX(e1.salary)
    FROM employee e1
    WHERE e.department_id = e1.department_id
);

-- Expected result:
-- Charlie | 3 | 1 | 80000
-- Emma    | 5 | 2 | 70000

-- ============================================================
-- Solution 2: Window Function with RANK()
-- PARTITION BY creates a separate ranking for each department.
-- ORDER BY salary DESC puts the highest salary at rank 1.
-- ============================================================
SELECT name,
       id,
       department_id,
       salary
FROM
(
    SELECT name,
           id,
           department_id,
           salary,
           RANK() OVER (
               PARTITION BY department_id
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employee
) t
WHERE salary_rank = 1;

-- ============================================================
-- Why use a subquery around the window function?
-- Window functions cannot normally be filtered directly in WHERE
-- at the same query level. The inner query calculates the rank,
-- and the outer query filters rank = 1.
--
-- RANK() is useful because if two employees have the same highest
-- salary, both employees receive rank 1 and both are returned.
-- ============================================================
