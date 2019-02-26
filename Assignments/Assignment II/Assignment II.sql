/*                                Assignment II                                 */

--                      Question I
/*
Find the courses which have no ‘F’ grade record ever. Note: the courses
which have never be registered should be included.
For each course as such, following information should be listed:
    1. Title of the course
    2. Count of section corresponding to the course
*/
-- Approach I --> Rule Out The 'course_id' Which Contains 'F' Grade
SELECT title, count(section.course_id) AS section_cnt
FROM course LEFT JOIN section ON (course.course_id = section.course_id)
GROUP BY title, course.course_id
HAVING course.course_id NOT IN (SELECT DISTINCT course_id
                                FROM takes
                                WHERE grade = 'F')
ORDER BY course.course_id;

-- Approach II --> Rule Out The 'title' Which Contains 'F' Grade
SELECT title, count(section.course_id) AS section_cnt
FROM course LEFT JOIN section ON (course.course_id = section.course_id)
WHERE title NOT IN (SELECT DISTINCT title
                    FROM course JOIN takes ON (course.course_id = takes.course_id)
                    WHERE grade = 'F')
GROUP BY title, course.course_id
ORDER BY course.course_id;

-- Approach III/1 --> Using The Difference Set (Aggregate) In HAVING Clause
SELECT title, count(section.course_id) AS section_cnt
FROM course LEFT JOIN section ON (course.course_id = section.course_id)
GROUP BY title, course.course_id
HAVING title IN (SELECT title
                 FROM course
                 EXCEPT
                 SELECT DISTINCT course.title
                 FROM course JOIN takes ON (course.course_id = takes.course_id)
                 WHERE grade = 'F')
ORDER BY course.course_id;
-- Approach III/2 --> Using The Difference Set (Aggregate) In WHERE Clause
SELECT title, count(section.course_id) AS section_cnt
FROM course LEFT JOIN section ON (course.course_id = section.course_id)
WHERE title IN (SELECT title
                FROM course
                EXCEPT
                SELECT DISTINCT course.title
                FROM course JOIN takes ON (course.course_id = takes.course_id)
                WHERE grade = 'F')
GROUP BY title, course.course_id
ORDER BY course.course_id;

-- Approach IV/1 --> Using (NOT) EXISTS Subquery In HAVING Clause
SELECT title, count(section.course_id) AS section_cnt
FROM course LEFT JOIN section ON (course.course_id = section.course_id)
GROUP BY title, course.course_id
HAVING NOT EXISTS(SELECT 1                       -- EXISTS / NOT EXISTS Subquery
                  FROM takes
                  WHERE (grade = 'F') AND (takes.course_id = course.course_id))
ORDER BY course.course_id;
-- Approach IV/2 --> Using (NOT) EXISTS Subquery In WHERE Clause
SELECT title, count(section.course_id) AS section_cnt
FROM course LEFT JOIN section ON (course.course_id = section.course_id)
WHERE NOT EXISTS(SELECT 1                        -- EXISTS / NOT EXISTS Subquery
                 FROM takes
                 WHERE (grade = 'F') AND (takes.course_id = course.course_id))
GROUP BY title, course.course_id
ORDER BY course.course_id;

-- Approach V --> Using WITH Clause / View Function to Create Temporary Table
WITH target_title AS (SELECT title, course_id
                      FROM course
                      WHERE course_id NOT IN (SELECT course_id
                                              FROM takes
                                              WHERE grade = 'F')),
     target_cnt AS (SELECT course_id, COUNT(*) AS section_cnt
                    FROM section
                    GROUP BY course_id)
SELECT title, ISNULL(section_cnt, 0) AS section_cnt
FROM target_title LEFT JOIN target_cnt ON (target_title.course_id = target_cnt.course_id)
ORDER BY target_title.course_id;


--                      Question II
/*
Get the grade distribution of all the sections. Note: there’s some grade like ‘A-’.
For each section grade distribution as such, following information should be listed:
    1. Course title of the section
    2. Year of the section
    3. Semester of the section
    4. ID number of the section
    5. Count of grade A records
    6. Count of grade B records
    7. Count of grade C records
    8. Count of grade D records
    9. Count of grade F records
    10. Count of records without grade information
*/
SELECT section.course_id, section.year, section.semester, section.sec_id,
       sum(CASE WHEN grade IN ('A+', 'A', 'A-') THEN 1 ELSE 0 END) AS A,
       sum(CASE WHEN grade IN ('B+', 'B', 'B-') THEN 1 ELSE 0 END) AS B,
       sum(CASE WHEN grade IN ('C+', 'C', 'C-') THEN 1 ELSE 0 END) AS C,
       sum(CASE WHEN grade IN ('D+', 'D', 'D-') THEN 1 ELSE 0 END) AS D,
       sum(CASE WHEN grade = 'F' THEN 1 ELSE 0 END) AS F,
       sum(CASE WHEN grade IS NULL THEN 1 ELSE 0 END) AS No_Grade
FROM section INNER JOIN takes ON (section.course_id = takes.course_id AND
                                  section.sec_id = takes.sec_id AND
                                  section.semester = takes.semester AND
                                  section.year = takes.year)
GROUP BY section.course_id, section.year, section.semester, section.sec_id;


--                      Question III
/*
Get the total credit hours in a week for every course which has corresponding sections in every semester.
For each course as such, following information should be listed:
    1. Title of the course
    2. Year of the course’s sections
    3. Semester of the course’s sections
    4. Count of the course’s sections in the corresponding year and semester
    5. Total Credit hours in a week.
Note: 1 credit hour = 50 minutes
*/
WITH slot_length AS (SELECT time_slot_id, sum((60 * end_hr + end_min) - (60 * start_hr + start_min)) AS t_len
                     FROM time_slot
                     GROUP BY time_slot_id)
SELECT title, year, semester, count(*) AS count, (sum(t_len) * 1.0 / 50) AS credit_hours
FROM (slot_length JOIN section ON (slot_length.time_slot_id = section.time_slot_id))
       JOIN course ON (section.course_id = course.course_id)
GROUP BY title, year, semester;


--                      Question IV
/*
Find the pairs of student and instructor which the student registered the section
that taught by the instructor and the student’s advisor is the instructor.
For each pair as such, following information should be listed:
    1. Name of the student
    2. Name of the Instructor
*/
WITH target_ID AS (SELECT takes.ID AS studentID, teaches.ID AS instructorID
                   FROM takes, teaches
                   WHERE takes.course_id = teaches.course_id
                     AND takes.sec_id = teaches.sec_id
                     AND takes.semester = teaches.semester
                     AND takes.year = teaches.year)
SELECT DISTINCT student.name AS student_name, instructor.name AS instruct_name
FROM target_ID, advisor, student, instructor
WHERE target_ID.instructorID = instructor.ID
  AND target_ID.instructorID = advisor.i_ID
  AND target_ID.studentID = advisor.s_ID
  AND target_ID.studentID = student.ID