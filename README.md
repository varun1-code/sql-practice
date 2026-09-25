# SQL Practice 🚀

A daily SQL practice repository focused on building strong SQL fundamentals and interview-ready problem-solving skills.

## 📚 Progress

### Day 1 — SELECT & Filtering
**Topics:**
- `SELECT`
- Filtering with `WHERE`
- Finding the second-highest salary
- Basic query structure

📁 `01-select-filtering/`

### Day 2 — Subqueries & Department Analysis
**Topics:**
- Employees earning above their department average
- Highest-paid employee per department
- Correlated subqueries
- `AVG()` and `MAX()` with subqueries

📁 `day-2/`

### Day 3 — Window Functions & Subqueries
**Topics:**
- `RANK()`
- `DENSE_RANK()`
- `PARTITION BY`
- Top salary levels per department
- Second-highest salary
- Correlated and uncorrelated subqueries
- Overall company average

📁 `day-3/`

### Day 4 — LAG() Window Function
**Topics learned:**
- `LAG()` for accessing the previous row
- Comparing the current row with the previous row
- Calculating salary differences
- Combining window functions with subqueries
- Using `RANK()` to find the highest salary per department without `MAX()`

📁 `day-4/`

### Day 5 — LEAD() Window Function
**Topics learned:**
- `LEAD()` for accessing the next row
- Comparing the current row with the next row
- Using `PARTITION BY` with `LEAD()`
- Calculating differences between current and next values
- Understanding why the final row in a window returns `NULL`
- Using subqueries with window-function results

📁 `day-5/`

### Day 6 — CTE (Common Table Expression)
**Topics learned:**
- CTEs using `WITH`
- Giving a temporary result a meaningful name
- Calculating department averages with `AVG()` and `GROUP BY`
- Joining a CTE with the original table
- Filtering rows using a value calculated by the CTE

📁 `day-6/`

## 🧠 Key SQL Concepts

### Window Functions
Window functions perform calculations across related rows without collapsing the result into a single row.

Examples:

```sql
RANK() OVER (PARTITION BY department_id ORDER BY salary DESC)
```

```sql
LAG(salary) OVER (ORDER BY id)
```

```sql
LEAD(salary) OVER (ORDER BY id)
```

### LAG() vs LEAD()

| Function | Looks at | Direction |
|---|---|---|
| `LAG()` | Previous row | Backward |
| `LEAD()` | Next row | Forward |

```text
LAG  → previous row
LEAD → next row
```

### LEAD()
`LEAD()` returns a value from a following row based on the ordering defined inside `OVER()`.

```sql
LEAD(salary) OVER (ORDER BY id) AS next_salary
```

When combined with `PARTITION BY`, the next value is calculated separately within each group:

```sql
LEAD(salary) OVER (
    PARTITION BY department
    ORDER BY id
) AS next_salary
```

### Understanding id and ORDER BY

In the practice table, `id` uniquely identifies an employee and is used to define the row order.

```text
id    name    salary
1     A       40000
2     B       50000
3     C       60000
```

Therefore:

```sql
LEAD(salary) OVER (ORDER BY id)
```

means that SQL should use the employee IDs to determine which row comes next.

### RANK() vs DENSE_RANK()

| Function | Ties | Gaps after ties |
|---|---|---|
| `RANK()` | Same rank | Yes |
| `DENSE_RANK()` | Same rank | No |

Example:

```text
Salary:       80000  80000  60000
RANK():           1      1      3
DENSE_RANK():     1      1      2
```

## 🎯 Practice Approach

The goal is to solve **1–2 SQL problems every day** while gradually increasing difficulty.

For each problem:

1. Understand the requirement.
2. Identify the SQL concept needed.
3. Attempt the query independently.
4. Debug syntax and logic errors.
5. Understand why the final query works.
6. Commit the solution to this repository.

## 📈 Upcoming Topics

Future practice will progressively cover:

- More advanced window functions
- Running totals
- Moving averages
- `CASE WHEN`
- CTEs (`WITH`)
- Complex joins
- Date and time problems
- Aggregation challenges
- Interview-style SQL problems

## 💻 Goal

Build strong SQL problem-solving skills for software engineering, backend development, data, and technical interviews.

---

**Practice consistently. Understand the logic. Write the query yourself. 🚀**
