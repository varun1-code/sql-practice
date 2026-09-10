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

### LAG()
`LAG()` returns a value from a previous row based on the ordering defined inside `OVER()`.

```sql
LAG(salary) OVER (ORDER BY id) AS previous_salary
```

This is useful for:
- Comparing current and previous values
- Finding increases/decreases
- Calculating changes over time
- Detecting row-to-row differences

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

- `LEAD()`
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
