/*                                Assignment III                                 */

--                      Question I
/*
Update all students’ tot_credit (total credits gained by the student.) information.
Note: student can only get credit of a course if he/she get a grade that is not ‘F’.
*/
UPDATE student
SET tot_cred = (SELECT ISNULL(SUM(credits), 0)
                FROM takes JOIN course ON (takes.course_id = course.course_id)
                WHERE student.ID = takes.ID
                  AND takes.grade != 'F'
                  AND takes.grade IS NOT NULL);


--                      Question II
/*
Find the students who have passed the exams of all the courses opened by the department the students are enrolled in.
For each student as such, following information should be listed:
    1. Name of the student
    2. Name of the department which the student is enrolled in
*/
SELECT name, dept_name
FROM student
WHERE NOT EXISTS(SELECT course_id           -- Should Return NULL
                 FROM course
                 WHERE course.dept_name = student.dept_name
                 EXCEPT
                 SELECT course_id
                 FROM takes
                 WHERE takes.ID = student.ID
                   AND grade NOT IN ('F'));  -- 'NOT IN' Won't Return NULL Value


--                      Question III
/*
Get information of 6 th to 10 th students according to the sorting rule that order students by students’ id ascending.
For each student as such, following information should be listed:
    1. ID of the student
    2. Name of the student
ATTENTION: 2 Implementation methods should be provided.
*/
-- Approach I --> Straightforward Syntax Approach
SELECT ID, name
FROM student
ORDER BY ID OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY  -- Default: Ascending

-- Approach II/1 --> Using The row_number() Function
SELECT ID, name
FROM (SELECT row_number() OVER (ORDER BY ID) AS rowNum,  -- Default: Ascending
             ID, name
      FROM student) AS Temp
WHERE rowNum BETWEEN 6 AND 10  -- (rowNUM > 5 AND rowNUM < 11)
-- Approach II/2 --> Using The rank() Function
SELECT ID, name
FROM (SELECT rank() OVER (ORDER BY ID) AS rank,  -- Default: Ascending
             ID, name
      FROM student) AS Temp
WHERE rank BETWEEN 6 AND 10  -- (rank > 5 AND rank < 11)

-- Approach III --> Using The Set Difference
SELECT TOP 10 ID, name
FROM student
EXCEPT
SELECT TOP 5 ID, name
FROM student;


--                      Question IV
/*
Find students who have failed exam(s) before and have also failed the later retake(s).
For each students as such, following information should be listed:
    1. ID of the student
    2. Name of the student
    3. Count of courses that still have failed exam records un-overwrited.
*/
WITH failed AS (SELECT ID, course_id, grade  -- Info of Students Once Failed
                FROM takes
                WHERE grade = 'F' OR grade IS NULL),
     retake AS (SELECT takes.ID, takes.course_id, takes.grade  -- Info of The Retakes
                FROM failed JOIN takes ON ((failed.ID = takes.ID) AND (failed.course_id = takes.course_id))
                WHERE takes.grade NOT IN ('F')),
     refail AS (SELECT ID, course_id
                FROM failed
                EXCEPT
                SELECT ID, course_id
                FROM retake)
-- Failed - Retake --> Remain Failed Info
SELECT student.ID, name, COUNT(course_id) failed
FROM student JOIN refail ON (student.ID = refail.ID)
GROUP BY student.ID, name;


--                      Question V
/*
Find students that has taked some courses more than one time.
For each students as such, following information should be listed:
    1. ID of the student
    2. Name of the student
    3. Title of the course
    4. Count of the student take the course
    5. Count of failed exam records of the student on the course.
*/
WITH retake AS (SELECT ID, course_id, COUNT(*) takes,
                       SUM(CASE WHEN grade = 'F' OR grade IS NULL THEN 1 END) fails
                FROM takes
                GROUP BY ID, course_id
                HAVING COUNT(*) > 1)
SELECT retake.ID, student.name, course.title, retake.takes, retake.fails
FROM retake JOIN student ON (retake.ID = student.ID)
            JOIN course ON (retake.course_id = course.course_id);