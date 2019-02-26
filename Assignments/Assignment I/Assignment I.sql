/*                                Assignment I                                 */

--                      Question I
/*
Find the students who have registered some course at least 2 times.
For each student as such, following information should be listed:
    1. Name of the student  --> name
    2. Title of the course  --> title
    3. Count of registered record of the student for the course  --> cnt
*/

-- First Approach -> Using The 'WHERE' Clause For Better Code Readability
SELECT name, course.title AS title, cnt
FROM (
      SELECT ID, course_id, COUNT(course_id) AS cnt
      FROM takes
      GROUP BY ID, course_id
      HAVING COUNT(course_id) > 1
     ) AS Dupl_LookUp, course, student
WHERE (Dupl_LookUp.course_id = course.course_id)
  AND (Dupl_LookUp.ID = student.ID)

-- Another Approach -> Using The 'JOIN ON' Clause For A Slightly Better Performance
SELECT name, course.title AS title, cnt
FROM (
     SELECT ID, course_id, COUNT(course_id) AS cnt
     FROM takes
     GROUP BY ID, course_id
     HAVING COUNT(course_id) > 1
     ) AS Dupl_LookUp JOIN course ON (Dupl_LookUp.course_id = course.course_id)
                      JOIN student ON (Dupl_LookUp.ID = student.ID)


--                      Question II
/*
Find the students who have never registered any course.
For each student as such, following information should be listed:
    1. ID of the student  --> ID
    2. Name of the student  --> name
*/

SELECT ID, name
FROM student
WHERE ID NOT IN (
                SELECT takes.ID
                FROM takes
                GROUP BY takes.ID
                )


--                      Question III
/*
Find the sections which have register records having unknown grade information.
For each section as such, following information should be listed:
    1. Title of the course corresponding to the section  --> course_id & title
    2. Id of the section  --> sec_id
    3. Year of the section  --> year
    4. Semester of the section  --> semester
*/

SELECT course.course_id, title, sec_id, year, semester
FROM (
     SELECT DISTINCT course_id, sec_id, year, semester
     FROM takes
     WHERE grade IS NULL
     ) AS null_course JOIN course ON (null_course.course_id = course.course_id)


--                      Question IV
/*
Find the students who enroll to the department having 4 instructors at least.
PROVIDE TWO METHODS for the query.
For each student as such, following information should be listed:
    1. Id of the student  --> ID
    2. Name of the student  --> name
    3. Name of the department the student enrolled to  --> dept_name
*/

-- First Approach -> Using Nested Subquery
SELECT ID, name, student.dept_name
FROM student JOIN (
                  SELECT dept_name
                  FROM instructor
                  GROUP BY dept_name
                  HAVING COUNT(name) > 3
                  ) AS target_dept ON (student.dept_name = target_dept.dept_name)
ORDER BY ID

-- Second Approach -> Using The 'LEFT JOIN ON' Clause
SELECT student.ID, student.name, student.dept_name
FROM student LEFT JOIN instructor ON (student.dept_name = instructor.dept_name)
GROUP BY student.ID, student.name, student.dept_name
HAVING COUNT(student.name) > 3
ORDER BY ID


--                      Question V
/*
Find the department which hired instructors whose name contain ‘世’.
For each department as such, following information should be listed:
1. Name of the department  --> dept_name
2. Building of the department  --> building
3. Instructor count of the department  --> cnt
*/

-- First Approach -> Using JOIN ON
SELECT department.dept_name, building, COUNT(ID) AS cnt
FROM department JOIN instructor ON (department.dept_name = instructor.dept_name)
WHERE name LIKE '%世%'
GROUP BY department.dept_name, building

-- Second Approach -> Using Nested Query
SELECT department.dept_name, building, cnt
FROM department JOIN (
                     SELECT dept_name, COUNT(name) AS cnt
                     FROM instructor
                     GROUP BY dept_name
                     HAVING dept_name IN (
                                         SELECT dept_name
                                         FROM instructor
                                         WHERE name LIKE '%世%'
                                         )
                     ) AS target_dept
         ON (department.dept_name = target_dept.dept_name)