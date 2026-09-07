```sql
/*
===========================================================
DAY 1 - PROBLEM 1: SECOND HIGHEST SALARY
===========================================================

Problem:
Find the second-highest DISTINCT salary from the Employee
table.

Employee:
+----+-------+--------+
| id | name  | salary |
+----+-------+--------+
| 1  | John  | 50000  |
| 2  | Alice | 70000  |
| 3  | Bob   | 60000  |
| 4  | David | 70000  |
| 5  | Emma  | 40000  |
+----+-------+--------+

Expected Output:
60000

Important:
The salary must be DISTINCT.
There are two employees earning 70000, but 70000 should
only count as the highest salary once.

===========================================================
APPROACH 1: DISTINCT + ORDER BY + LIMIT + OFFSET
===========================================================

Idea:
1. Remove duplicate salaries using DISTINCT.
2. Sort salaries from highest to lowest.
3. Skip the highest salary using OFFSET 1.
4. Return the next salary using LIMIT 1.

*/

SELECT DISTINCT salary AS second_highest_salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;


/*
Example after DISTINCT and ORDER BY:

70000
60000
50000
40000

OFFSET 1:
Skip 70000

LIMIT 1:
Take 60000

Result:
60000


===========================================================
APPROACH 2: MAX() + SUBQUERY
===========================================================

Idea:
1. Find the highest salary using MAX().
2. Find salaries smaller than the highest salary.
3. From those salaries, find the maximum.
4. That maximum is the second-highest salary.
*/

SELECT MAX(salary) AS second_highest_salary
FROM Employee
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee
);


/*
Inner query:

SELECT MAX(salary)
FROM Employee;

Result:
70000

Then:

WHERE salary < 70000

Remaining salaries:
50000
60000
40000

Finally:

MAX(50000, 60000, 40000)

Result:
60000


===========================================================
APPROACH 3: DENSE_RANK() WINDOW FUNCTION
===========================================================

Idea:
1. Sort salaries from highest to lowest.
2. Assign a rank to each salary.
3. DENSE_RANK() gives the same rank to duplicate salaries.
4. Select rank = 2.

Ranking:

70000 -> 1
70000 -> 1
60000 -> 2
50000 -> 3
40000 -> 4
*/

SELECT salary AS second_highest_salary
FROM (
    SELECT salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
    FROM Employee
) AS ranked_salaries
WHERE salary_rank = 2;


/*
===========================================================
WHY DENSE_RANK()?
===========================================================

Because duplicate salaries should have the same rank.

Example:

Salary    DENSE_RANK
70000     1
70000     1
60000     2
50000     3
40000     4

If we used RANK():

Salary    RANK
70000     1
70000     1
60000     3

There would be no rank 2.

Therefore, DENSE_RANK() is useful when we want the
second-highest DISTINCT value.


===========================================================
SUMMARY
===========================================================

Approach 1:
DISTINCT + ORDER BY + LIMIT/OFFSET
- Simple and short
- PostgreSQL-friendly

Approach 2:
MAX() + Subquery
- Very intuitive
- Good for understanding aggregate functions

Approach 3:
DENSE_RANK()
- Powerful window-function approach
- Useful for more advanced SQL problems
- Handles duplicate values correctly

All three approaches return:

60000
===========================================================
*/
```
