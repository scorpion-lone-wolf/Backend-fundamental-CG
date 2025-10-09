-- 11. Find all courses a student is enrolled in.
SELECT * FROM
    enrollments e
INNER JOIN courses c
    ON e.course_id = c.id
WHERE e.student_id = 1;

-- 12. List all students not enrolled in any courses.
SELECT s.id, s.name FROM
    students s
LEFT JOIN enrollments e
    ON s.id = e.student_id
WHERE e.student_id IS NULL;

-- 13. List all courses (show instructor name too).
SELECT
    c.id AS course_id,
    c.name AS course_name,
    i.id AS instructor_id,
    i.name AS instructor_name
FROM courses c
LEFT JOIN instructors i
    ON c.instructor_id = i.id
ORDER BY c.id;


-- 14. Get a specific course (by ID) with department & instructor info.
SELECT
    c.id AS course_id,
    c.name AS course_name,
    c.syllabus AS course_syllabus,
    i.name AS instructor_name,
    i.email AS instructor_email,
    d.name AS depart_name
FROM courses c
INNER JOIN instructors i
    ON i.id = c.instructor_id
INNER JOIN departments d
    ON d.id = c.department_id
WHERE c.id = 3;

-- 15. List all students in a particular course.
SELECT s.id, s.name FROM
    students s
INNER JOIN enrollments e
    ON s.id = e.student_id
WHERE e.course_id = 1;


-- 16. Find how many students are enrolled in each course (aggregated).
SELECT e.course_id , COUNT(e.student_id ) FROM
    enrollments  e
GROUP BY e.course_id
ORDER BY e.course_id ASC;

-- 17. List all enrollments (student/course pairs).
SELECT
    s.id AS student_id,
    s.name AS student_name,
    c.id AS course_id,
    c.name AS course_name
FROM enrollments e
INNER JOIN students s
    ON s.id = e.student_id
INNER JOIN courses c
    ON c.id = e.course_id;


-- 18. Enroll a student in a course (INSERT into pivot).
INSERT INTO enrollments (student_id, course_id) VALUES (1, 12);

-- 19. Unenroll a student from a course (DELETE from pivot).
DELETE FROM enrollments e
WHERE e.student_id = 1 AND e.course_id = 12;

-- 20. List all assignments.
SELECT * FROM assignments;

-- 21. Get all assignments for a particular course.
SELECT * FROM assignments
WHERE course_id = 5;

-- 22. Get assignment details (with course/instructor info).
SELECT
    a.id AS assign_id,
    a.title AS assignment_title,
    c.id AS course_id,
    c.name AS course_name,
    c.syllabus AS course_syllabus,
    i.id AS instructor_id,
    i.name AS instructor_name,
    i.email AS instructor_email
FROM assignments a
LEFT JOIN courses c
    ON c.id = a.course_id
LEFT JOIN instructors i
    ON i.id = c.instructor_id;

-- 23. Which instructor teaches the most courses? (count courses per instructor).
SELECT i.id,
     i.name,
     COUNT(c.id) AS total_courses
FROM instructors i
LEFT JOIN courses c
    ON i.id = c.instructor_id
GROUP BY i.id, i.name
ORDER BY total_courses DESC
LIMIT 1;

-- 24. Which student is enrolled in the most courses? (count enrollments).
SELECT
    s.id,
    s.name,
    COUNT(e.student_id) AS total_courses
FROM students s
LEFT JOIN enrollments e
    ON e.student_id = s.id
GROUP BY s.id, s.name
ORDER BY total_courses DESC;

-- 25. Courses with no students enrolled.
SELECT c.name, c.id
FROM enrollments e
RIGHT JOIN courses c
    ON e.course_id = c.id
WHERE e.course_id IS NULL;

