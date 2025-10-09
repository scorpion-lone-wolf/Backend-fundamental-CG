-- inner joins between courses and instructors
 SELECT
    c.id,
    c.name,
    c.syllabus,
    i.name AS instructor_name
 FROM courses c
 INNER JOIN instructors i
 on i.id = c.instructor_id;

-- Left Outer join
 SELECT
    d.id,
    d.name,
    i.id AS instrucctor_id,
    i.name AS instructor_name
 from instructors i
 LEFT JOIN departments d
 on d.id = i.department_id ;


-- cross join (return the cartesian product of left X right)
 SELECT
    d.id,
    d.name,
    i.id AS instrucctor_id,
    i.name AS instructor_name
 from instructors i
 CROSS JOIN departments d;
