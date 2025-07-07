#Day3-assignment
#Takes input of 5 students with their name and marks.
#Stores data into a CSV file grades.csv
#Then reads the file and:
#1. Prints names of students who scored more than 80
#2. Calculates average marks of the class
#3. Saves those with less than 35 as "FAIL" in a new column


import sqlite3
import csv
import os

print("current working directory: ",os.getcwd())
      
conn=sqlite3.connect("student_marks1.db")#connects or creates..It will automatically create student_marks.db in the current working directory if it doesn’t exist.

#create a table stud_marks1
qry_create="""create table if not exists stud_marks1(name text unique,marks integer,status text);"""
conn.execute(qry_create)
conn.commit()

#inserting one
qry_insert="""insert or ignore into stud_marks1 (name,marks,status) values ('Jaffer','100','Distinction');"""
conn.execute(qry_insert)
conn.commit()

#inserting many
insert_many="""insert or ignore into stud_marks1 (name,marks,status) values (?,?,?);"""
multiple_inserts=[
('Shaik','80','First'),
('Ayman','70','First'),
('Zoya','50','second'),
('pk','30','Fail'),
('ok','45','third'),
('sk','70','first'),
('taqi','50','third')
]
conn.executemany(insert_many,multiple_inserts)
conn.commit()

#selectall
qry_select_all="""select * from stud_marks1;"""
data=conn.execute(qry_select_all)
conn.commit()

#loop to extract values from the table, display rows
print("All rows from direct loop:")
for each_row in data:
    print(each_row)

print("\n")


def stud_mark(query,data=None,db="student_marks1.db"):
    conn=sqlite3.connect(db)
    cursor=conn.cursor()
    try:
        if data:
            if isinstance(data,list):
                cursor.executemany(query,data)
            else:
                cursor.execute(query,data)
        else:
            cursor.execute(query)

        if query.lower().strip().startswith("select"):
            result=cursor.fetchall()
            return result
        
        else:
            conn.commit()
    except sqlite3.error as e:
        return "error occured",e

result1=stud_mark(qry_select_all)
print("student table:",result1)



# Export to CSV
with open('grades1.csv', 'w') as file:
    writer=csv.writer(file)
    writer.writerow(['name', 'marks', 'status'])  # Column names
    writer.writerows(result1)
    print("Data exported to grades1.csv successfully ...")

