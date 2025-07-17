#Project: Student Course Enrollment System

import sqlite3
import os
import datetime

#set path
base_path=os.path.dirname(__file__)
database_path=os.path.join(base_path,'d7_student_db')

conn=sqlite3.connect(database_path)
#re_running this file is making many updates repeated , i want to delete table contents for fresh data, so deleting tables..
conn.execute("DELETE FROM d7_students")
conn.execute("DELETE FROM d7_courses")
conn.execute("DELETE FROM d7_enrollments")
conn.commit()

#creating table-student
qry_create_table_stud="""CREATE TABLE IF NOT EXISTS d7_students (
    student_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL
);"""

conn.execute(qry_create_table_stud)
conn.commit()

#creating table-courses

qry_create_table_courses="""CREATE TABLE IF NOT EXISTS d7_courses (
    course_id INTEGER PRIMARY KEY,
    course_name TEXT NOT NULL,
    instructor TEXT NOT NULL
);"""
conn.execute(qry_create_table_courses)
conn.commit()

#creating table-enrollment
#A foreign key is like a bridge that connects two tables. value in one column must match a value in another table’s column
#This ensures data consistency and relationships between tables.
#FOREIGN KEY	Creates a link between tables
#REFERENCES	Says “match this column in that table”

qry_create_table_enroll="""CREATE TABLE IF NOT EXISTS d7_enrollments (
    enrollment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER,
    course_id INTEGER,
    enrollment_date TEXT,
    FOREIGN KEY(student_id) REFERENCES d7_students(student_id),
    FOREIGN KEY(course_id) REFERENCES d7_courses(course_id)
    Unique(student_id,course_id)
);"""
conn.execute(qry_create_table_enroll)
conn.commit()

students = [
    (1, "asma", "asma@gmail.com"),
    (2, "rahul", "rahul@gmail.com"),
    (3, "zoya", "zoya@gmail.com")
]
courses = [
    (101, "Python", "Mr. A"),
    (102, "SQL", "Ms. B"),
    (103, "Power BI", "Mr. C")
]

#inserting in executemany directly
#task1: Add students	Add 3 students with student_id, name, email.
#task2: Add courses	Add 3 courses with course_id, course_name, instructor.

qry_insert_stud="""insert or ignore into d7_students values(?,?,?);"""
conn.executemany(qry_insert_stud,students)
conn.executemany("insert or ignore into d7_courses values (?,?,?);",courses)
conn.commit()

#task3: Enroll students	Enroll each student in at least 1 course (with today’s date).
from datetime import datetime
today=datetime.now().strftime("%Y-%m-%d")
enroll=[
    (1,101,today),
    (2,102,today),
    (3,103,today),
    (1,102,today),
    (2,103,today)#asma and rahul enrolled in 2 courses
]
conn.executemany("insert or ignore into d7_enrollments(student_id, course_id, enrollment_date) values(?,?,?);",enroll)
conn.commit()

qry_fetch_all_stud="select * from d7_students;"
result=conn.execute(qry_fetch_all_stud)
conn.commit()
for each in result:
    print(each)



#task4: view enrollments	Show student name, course name, instructor, and date using JOIN.
def view_all_enrollments():
    print("View enrollments: ")
    qry_view_enrolL="""select s.name as student,c.course_name as course, c.instructor as instructor, e.enrollment_date as date from d7_enrollments e
    join d7_students s on s.student_id=e.student_id
    join d7_courses c on c.course_id=e.course_id"""
    result=conn.execute(qry_view_enrolL)
    for each in result:
        print(each)

#task5: Search by student name	Case-insensitive search, display enrolled courses.

def search_by_student_name():
    search_Stud=input("Enter student name, to search for course enrollments: ").lower().strip()
    qry_search_student="""select s.name as name,c.course_name as course 
    from d7_enrollments e
    join d7_students s on s.student_id=e.student_id
    join d7_courses c on c.course_id=e.course_id where lower(s.name)=?;
    """ 
    result=conn.execute(qry_search_student,(search_Stud,))

    for each in result:
        print (f"{each[0]}->{each[1]}")

#task6: Update student email	Update email based on student_id.
def update_email():
    stud_id=int(input("Enter student id to which you want to update email id: "))
    try:
        if stud_id:
            new_email_id=input("Enter new email_is: ")
            qry_update_email="""update d7_students set email=? where student_id=?"""
            conn.execute(qry_update_email,(new_email_id,stud_id))
            conn.commit()
            print("Email id updated.")

            print("Student table after updated email id is: ")
            result=conn.execute(qry_fetch_all_stud)
            cursor=result.fetchall()
            for each in cursor:
                print(each)
       
        else:
            print("No student found with that id")
    except Exception as e:
        print("Error occured: ",e)


#task7. Delete student	Remove student and their enrollments.
def delete_student():
    del_stud=int(input("Enter student id to delete: "))
    try:
        if del_stud:
            qry_delete_stud="""delete from d7_students where student_id=?"""
            conn.execute(qry_delete_stud,(del_stud,))
            print("student id:",del_stud, "deleted from student table..!")
            qry_deletefrom_enroll="""delete from d7_enrollments where student_id=?"""
            conn.execute(qry_deletefrom_enroll,(del_stud,))
            print("student id:",del_stud, "deleted from enrollment table..!")
            conn.commit()

            print("Student table after deleting student: ",del_stud)
            result=conn.execute(qry_fetch_all_stud)
            for each in result:
                print(each)
            
            print("Enrollment table after deleting student: ",del_stud)
            result=conn.execute("Select * from  d7_enrollments")
            for each in result:
                print(each)
        else:
            print("Student id not in list")
    except Exception as e:
        print("Error occured:",e)

#task8. BONUS	Show course-wise student count (using GROUP BY).
def view_course_wise_enrollment_count():
    qry_course_wise_count="""select c.course_name, count(e.student_id) as total_students from d7_enrollments e
    join d7_courses c on e.course_id=c.course_id
    group by c.course_name; """

    result = conn.execute(qry_course_wise_count)
    print("\nCourse-wise Student Count:")
    print("Course Name\tTotal Students")
    for each in result:
        print(f"{each[0]:<16} -> {each[1]}")


# Menu Loop
while True:
    print("\nWelcome to Student Course Enrollment System")
    print("1. Show All Enrollments")
    print("2. Search by Student Name")
    print("3. Update Email")
    print("4. Delete Student")
    print("5. Show Course Enrollment Count")
    print("0. Exit")

    choice = input("Enter your choice: ")

    if choice == "1":
        view_all_enrollments()
    elif choice == "2":
        search_by_student_name()
    elif choice == "3":
        update_email()
    elif choice == "4":
        delete_student()
    elif choice == "5":
        view_course_wise_enrollment_count()
    elif choice == "0":
        print("Exiting system...")
        break
    else:
        print("Invalid choice. Try again.")
    




