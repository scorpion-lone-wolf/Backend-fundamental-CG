-- 1. List all departments (for an admin dashboard or dropdown).
SELECT * FROM
    departments;

-- 2. Get one department (by ID) with all its details.
SELECT * FROM
    departments
WHERE id = 2;

-- 3. List all instructors in a department.
SELECT * FROM
    instructors i
WHERE i.department_id = 4;

-- 4. List all courses offered in a department.
SELECT * FROM
    courses c
WHERE c.department_id = 3;

-- 5. List all instructors (could be used in an admin panel).
SELECT * FROM
    instructors;

-- 6. Get a specific instructor by ID.
SELECT * FROM
    instructors i
WHERE i.id = 3;

-- 7. Get all courses taught by a specific instructor.
SELECT * FROM
    courses c
INNER JOIN instructors i
    ON c.instructor_id = i.id
WHERE i.email = 'instructor4@example.com';

-- 8. Find which department an instructor belongs to.
SELECT * FROM
    departments d
INNER JOIN instructors i
    ON i.department_id = d.id
WHERE i.name = 'instructor5';

-- 9. List all students.
SELECT * FROM
    students;

-- 10. Get a student by ID.
SELECT * FROM
    students s
WHERE s.id = 3;
