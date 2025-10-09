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
-- 14. Get a specific course (by ID) with department & instructor info.

-- 15. List all students in a particular course.
SELECT s.id, s.name FROM
    students s
INNER JOIN enrollments e
    ON s.id = e.student_id
WHERE e.course_id = 1;


-- 16. Find how many students are enrolled in each course (aggregated).
-- 17. List all enrollments (student/course pairs).
-- 18. Enroll a student in a course (INSERT into pivot).
-- 19. Unenroll a student from a course (DELETE from pivot).
-- 20. List all assignments.
-- 21. Get all assignments for a particular course.
-- 22. Get assignment details (with course/instructor info).

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
-- 25. Courses with no students enrolled.
