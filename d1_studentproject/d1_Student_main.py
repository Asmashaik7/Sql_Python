#Day1-some simple python tasks done in jupyter file and this creating a table in db.
#insert, update and delete
import sqlite3
import csv
import os

conn=sqlite3.connect("d1_student1.db")
query_create_table="""create table IF NOT EXISTS d1_student1( id integer primary key, name text,age integer, grade text);"""
conn.execute(query_create_table)

# insert some values into database
insert_table="""insert or ignore into d1_student1(id,name,age,grade)values('1','Asma','20','first');"""
conn.execute(insert_table)

insert_table="""insert or ignore into d1_student1 values(?,?,?,?);"""
multiple_entries=[
('7','Shaik','30','distinction'),
('2','Manha','21','second'),
('3','Ayman','22','third'),
('4','Danish','23','first'),
('5','Zoya','24','second'),
('6','Jaffer','26','third')
]
conn.executemany(insert_table, multiple_entries)
conn.commit()



query_selectall="""select * from d1_student1;"""
data=conn.execute(query_selectall)
data
for row in data:
    print(row)
conn.commit()

#conn.executemany("INSERT OR IGNORE INTO student VALUES (?, ?, ?, ?);", multiple_entries) - we can use this to overcome integrity errors..

def stud_fun(query,data=None,db='d1_student1.db'): #The SQL query to run,--data is type, list or single data,--db is our db
    with sqlite3.connect(db) as conn: #connects to the SQLite database file.
        cursor=conn.cursor() # Creates a cursor object to execute SQL commands.
    try:
        if data:
            if isinstance(data,list):
                cursor.executemany(query,data)
            else:
                cursor.execute(query,data) # isinstance checks the type of data.if single row it runs execute or if data is many rows, it goes executemany()
        else:
            cursor.execute(query)
            
# Tries to run the SQL query passed into the function.
        if query.strip().lower().startswith("select"):
            result=cursor.fetchall() #This line fetches all result rows
            return result #sends the list of rows back to the caller.
        else:
            conn.commit()#If it's not a SELECT (like INSERT, DELETE, UPDATE):Commits the changes to the DB (e.g., save new records).
            return "query run successfully"
    except sqlite3.Error as e:
        return f"An error occurred: {e}"

#selecting 
result = stud_fun("SELECT * FROM d1_student1;")
for row in result:
    print(row)


#updating-Task 1: Update Ayman's grade to 'distinction'
qry_update="update d1_student1 set grade='distinction' where name='Ayman'"
result1=stud_fun(qry_update,)
print(result1)

#Task 2: Delete student 'Zoya'
print("Before deletion:")
print(stud_fun("SELECT * FROM d1_student1"))
qry_delete="delete from d1_student1 where lower(name)='zoya'"
result3=stud_fun(qry_delete,)
print(result3) #this returns query runs successful
print("After deletion:")
print(stud_fun("SELECT * FROM d1_student1")) #this will show all students after deletion

#Task 3: Select Students with Grade = 'first'

qry_grade="select * from d1_student1 where grade='first'"
result4=stud_fun(qry_grade,)
print(result4)

#4. BONUS (if time allows):
#Write a function search_by_grade(grade_input) that returns a list of students matching the grade you pass.
def search_by_grade(grade_input):
   g=grade_input.lower()
   query1="select * from d1_student1 where lower(grade)=?"
   #cursor.execute("SELECT * FROM student1 WHERE grade = ?", ('third',))- you can also write like this.
   result=stud_fun(query1,(g,)) #always use a tuple when your query has ? placeholders.so (g,). its not a variable, its might be a list or tuple of people who have same grade.
   return result

result5=search_by_grade('third')
for row in result5:
    print(row)

file_path = os.path.join(os.path.dirname(__file__), 'd1_student_data.csv')
# Export to CSV
with open('d1_student_data.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['ID', 'Name', 'Age', 'Grade'])  # Column names
    writer.writerows(result)

print("Data exported to d1_student_data.csv successfully ✅")