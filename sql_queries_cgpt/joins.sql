-- --  What Are JOINS?
-- -- A JOIN is used to combine rows from two or more tables based on a related column between them.
-- -- Think of it like this:
-- -- You have two tables — one with students and one with their courses.
-- -- A JOIN helps you connect which student is enrolled in which course using a common column (like student_id).
-- Let’s take two sample tables 👇

-- 🧮 Table 1: Students
-- student_id	name
-- 1	Aisha
-- 2	Rahul
-- 3	Meena
-- 4	Ali

-- 📘 Table 2: Courses
-- course_id	student_id	course_name
-- 101	          1	        Python
-- 102	          2	        SQL
-- 103	          3	        Power BI
-- 104	          5	         Excel

-- 🌿 2️⃣ Types of JOINS (with easy explanation)
-- 🟢 INNER JOIN – only matching rows in both tables

-- Shows records that exist in both tables (based on student_id).

-- 📘 Example:

-- SELECT Students.name, Courses.course_name
-- FROM Students
-- INNER JOIN Courses
-- ON Students.student_id = Courses.student_id;


-- ✅ Result:

-- name	course_name
-- Aisha	Python
-- Rahul	SQL
-- Meena	Power BI

-- 🧠 Ali is missing because he doesn’t have a course; Excel (student_id 5) is missing because that student doesn’t exist in Students.

-- 🟣 LEFT JOIN (or LEFT OUTER JOIN) – all from left + matches from right

-- Shows all students, and if they don’t have a course, shows NULL.

-- 📘 Example:

-- SELECT Students.name, Courses.course_name
-- FROM Students
-- LEFT JOIN Courses
-- ON Students.student_id = Courses.student_id;


-- ✅ Result:

-- name	course_name
-- Aisha	Python
-- Rahul	SQL
-- Meena	Power BI
-- Ali	NULL

-- 🧠 Ali appears even though he has no course.

-- 🟡 RIGHT JOIN (or RIGHT OUTER JOIN) – all from right + matches from left

-- Shows all courses, even if the student is missing.

-- 📘 Example:

-- SELECT Students.name, Courses.course_name
-- FROM Students
-- RIGHT JOIN Courses
-- ON Students.student_id = Courses.student_id;


-- ✅ Result:

-- name	course_name
-- Aisha	Python
-- Rahul	SQL
-- Meena	Power BI
-- NULL	Excel

-- 🧠 Excel shows NULL because that student (id 5) doesn’t exist in Students.

-- 🔵 FULL JOIN (or FULL OUTER JOIN) – all rows from both tables

-- Combines LEFT and RIGHT joins — shows everything, fills NULLs where there’s no match.

-- 📘 Example:

-- SELECT Students.name, Courses.course_name
-- FROM Students
-- FULL OUTER JOIN Courses
-- ON Students.student_id = Courses.student_id;


-- ✅ Result:

-- name	course_name
-- Aisha	Python
-- Rahul	SQL
-- Meena	Power BI
-- Ali	NULL
-- NULL	Excel

-- 🧠 You see all students and all courses, even unmatched ones.

-- 🔴 CROSS JOIN – every row combined with every row (Cartesian product)

-- Joins each student with every course.
-- ⚠️ Be careful — this can create a large number of rows.

-- 📘 Example:

-- SELECT Students.name, Courses.course_name
-- FROM Students
-- CROSS JOIN Courses;


-- ✅ Result: (4 × 4 = 16 rows)

-- name	course_name
-- Aisha	Python
-- Aisha	SQL
-- Aisha	Power BI
-- Aisha	Excel
-- Rahul	Python
-- ...	...

-- 🧠 Used rarely, only when you want all combinations.

-- 💪 3️⃣ Practice Section (5 examples each)
-- 🟢 INNER JOIN – Practice

-- Show student names and course names.

-- Display only students who have at least one course.

-- Find total students enrolled in each course.

-- List all courses that belong to existing students.

-- Display students and their courses whose names start with ‘A’.

-- 🟣 LEFT JOIN – Practice

-- Show all students and their courses (if any).

-- Find students who haven’t enrolled in any course (WHERE course_name IS NULL).

-- Display all students with “No Course” if they haven’t enrolled.

-- Count how many students don’t have a course.

-- Show all students and replace NULL course_name with ‘Not Enrolled’.

-- 🟡 RIGHT JOIN – Practice

-- Show all courses and their corresponding student names.

-- Find courses without any enrolled student.

-- Show total number of students who exist for each course.

-- List course_name along with student_name (even if student is missing).

-- Show all course_name and fill missing student as “Unknown”.

-- 🔵 FULL JOIN – Practice

-- Show all students and courses, even unmatched.

-- Find which students or courses don’t have a match.

-- Show all pairs, marking missing data as ‘Not Found’.

-- Count total matched vs unmatched records.

-- Display a combined list of all students and courses.

-- 🔴 CROSS JOIN – Practice

-- Show all possible student–course combinations.

-- Count total combinations possible.

-- List first 5 combinations only.

-- Create a timetable (student × course).

-- Generate pairs where student name starts with ‘A’.
