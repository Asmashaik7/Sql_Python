# Project: Student Marks Management System
#creating a list an storing student details
import sqlite3
import csv
import os
base_path=os.path.dirname(__file__)
db_path=os.path.join(base_path,"d6_studmarks_mgt.db")
csv_path=os.path.join(base_path,"d6_csv_file")

conn=sqlite3.connect(db_path)

#1.Take input for 3 students using a loop
#d6_marks=[] #List of dictionaries
#for each in range(3):
    # s_id=int(input(f"Enter student{each+1} id:"))
    # name=str(input(f"Enter student{each+1} name:").lower())
    # math=int(input(f"Enter math marks of student{each+1}:"))
    # english=int(input(f"Enter English marks of student{each+1}:"))
    # science=int(input(f"Enter science marks of student{each+1}:"))

#append details into dict
# d6_marks.append({'id':s_id,'student_name':name,'math_marks':math,'english_marks':english,'science_marks':science})
# print("Student details:")
# for each in d6_marks:
#     print(each)
d6_marks = [
    {'id': 1, 'student_name': 'asma', 'math_marks': 95, 'english_marks': 87, 'science_marks': 90},
    {'id': 2, 'student_name': 'rahul', 'math_marks': 78, 'english_marks': 91, 'science_marks': 85},
    {'id': 3, 'student_name': 'zoya', 'math_marks': 82, 'english_marks': 75, 'science_marks': 92}
]
#2. Create the table d6_students_table
conn.execute("DROP TABLE IF EXISTS d6_students_table;")
qry_create_table="""create table if not exists d6_students_table(
student_id INTEGER PRIMARY Key,
name TEXT,
math_marks INTEGER,
english_marks INTEGER,
science_marks INTEGER);"""
conn.execute(qry_create_table)
conn.commit()

# Insert data into table
# Convert list of dicts to list of tuples
qry_insert="""insert or ignore into d6_students_table(student_id,name,math_marks,english_marks,science_marks) values(?,?,?,?,?);"""
d6_marks2=[]
for s in d6_marks:
    d6_marks2.append([s['id'], s['student_name'], s['math_marks'], s['english_marks'], s['science_marks']])

conn.executemany(qry_insert,d6_marks2)
conn.commit()

#3. View all student records
qry_select_all="""select * from d6_students_table;"""
result=conn.execute(qry_select_all)
conn.commit()
print("Table :")
for each in result:
    print(each)

#4. View students who scored above 90 in any subject
qry_above="""select * from d6_students_table where (math_marks>90 or english_marks>90 or science_marks>90);"""
result=conn.execute(qry_above)
conn.commit()
for each in result:
    print(each)

#5.Update a student's marks by their ID
#Ask user for student ID → update all 3 subjects.

marks_id=int(input("Enter student id to update 3 subject marks: "))
new_math=int(input(f"Enter new math marks of student: "))
new_english=int(input(f"Enter new English marks of student: "))
new_science=int(input(f"Enter new science marks of student: "))

qry_update = """UPDATE d6_students_table SET math_marks = ?, english_marks = ?, science_marks = ? WHERE student_id = ?;"""
conn.execute(qry_update, (new_math, new_english, new_science, marks_id))
conn.commit()

print("Updated marks successfully are:")

conn.execute(qry_select_all)

#6. Show class average for each subject
qry_sub_avg="""select avg(math_marks),avg(english_marks),avg(science_marks) from d6_students_table;"""
result=conn.execute(qry_sub_avg)
averages=result.fetchone()
conn.commit()
print("Average marks subjectwise:")
print(f'Avg math: {averages[0]:.2f}')
print(f'Avg english: {averages[1]:.2f}')
print(f'Avg Math: {averages[2]:.2f}')

#7. Show topper in each subject- We’ll run three separate queries — one for each subject.
#Math topper
qry_math_topper="""select name, math_marks from d6_students_table where math_marks=(select max(math_marks) from d6_students_table);"""
result=conn.execute(qry_math_topper)
conn.commit()
for each in result:
    print(f'Math topper: {each[0]}-{each[1]}')

#English topper
qry_english_topper="""select name, english_marks from d6_students_table where english_marks=(select max(english_marks) from d6_students_table);"""
result=conn.execute(qry_english_topper)
conn.commit()
for each in result:
    print(f'English topper: {each[0]}-{each[1]}')

#Science topper
qry_science_topper="""select name, science_marks from d6_students_table where science_marks=(select max(science_marks) from d6_students_table);"""
result=conn.execute(qry_science_topper)
conn.commit()
for each in result:
    print(f'Science topper: {each[0]}-{each[1]}')


# Bonus (Optional):Show total marks and sort by highest

qry_total = """
SELECT student_id, name,
       math_marks + english_marks + science_marks AS total_marks 
FROM d6_students_table
ORDER BY total_marks DESC;
"""
#AS total_marks creates a temporary column
result = conn.execute(qry_total)
print("\n📊 Students sorted by total marks:")
for each in result:
    print(f"{each[0]} - {each[1].title()} → Total: {each[2]}")

#Search student by name (case-insensitive)

search_name = input("\n🔍 Enter student name to search: ").strip().lower()
qry_search = """SELECT * FROM d6_students_table WHERE LOWER(name) = ?;"""
result = conn.execute(qry_search, (search_name,))
rows = result.fetchall()

if rows:
    for row in rows:
        print(f" Found: {row}")
else:
    print(" No student found with that name.")

conn.close()