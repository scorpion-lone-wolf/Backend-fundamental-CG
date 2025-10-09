-- 1. Write a SQL query that returns the id and name of every department,
-- sorted by the department’s name in ascending (alphabetical) order.
-- Your result should include all rows from the departments table.
SELECT id, name FROM
    departments d
ORDER BY d.name ASC;
