#Day 2 Project: SQLite + Python + CSV
#Objective:
#Use SQLite (student.db) to create a table of student marks
#Insert records
#Export them to a CSV file (grades.csv)
#Build a reusable function for database operations


import sqlite3
import csv

# Step 1: Connect to database (creates student.db if it doesn't exist)
conn = sqlite3.connect("student.db")

# Step 2: Create table
qry_create = """CREATE TABLE IF NOT EXISTS stud_marks (
    name TEXT,
    marks INTEGER,
    status TEXT
);"""
conn.execute(qry_create)
conn.commit()

# Step 3: Insert one row
conn.execute("INSERT OR IGNORE INTO stud_marks VALUES ('Jaffer', 100, 'Distinction')")
conn.commit()

# Step 4: Insert multiple records
multiple_inserts = [
    ('Shaik', 80, 'First'),
    ('Ayman', 70, 'First'),
    ('Zoya', 50, 'Second'),
    ('pk', 30, 'Fail'),
    ('ok', 45, 'Third'),
    ('sk', 70, 'First'),
    ('taqi', 50, 'Third')
]
conn.executemany("INSERT OR IGNORE INTO stud_marks VALUES (?, ?, ?)", multiple_inserts)
conn.commit()

# Step 5: Fetch all data
qry_select_all = "SELECT * FROM stud_marks;"
data = conn.execute(qry_select_all)
for each_row in data:
    print(each_row)

# Step 6: Reusable function
def stud_mark(query, data=None):
    conn = sqlite3.connect("student.db")
    cursor = conn.cursor()
    try:
        if data:
            if isinstance(data, list):
                cursor.executemany(query, data)
            else:
                cursor.execute(query)
            conn.commit()
        elif query.lower().strip().startswith("select"):
            result = cursor.execute(query).fetchall()
            return result
    except sqlite3.Error as e:
        return "Error occurred", e

file_path = os.path.join(os.path.dirname(__file__), 'd2_grades.csv')

# Step 7: Export result to CSV
result = stud_mark("SELECT * FROM stud_marks")
with open('d2_grades.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['name', 'marks', 'status'])
    writer.writerows(result)

print("✅ Data exported to grades.csv successfully.")
