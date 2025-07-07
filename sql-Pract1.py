import sqlite3

# Step 1: Connect to a new or existing database
conn = sqlite3.connect('students.db')

# Step 2: Create a cursor object
cursor = conn.cursor()

# Step 3: Create a table
cursor.execute("""
CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    marks INTEGER
)
""")

# Step 4: Insert data
cursor.execute("INSERT INTO students (name, marks) VALUES (?, ?)", ("Asma", 85))
cursor.execute("INSERT INTO students (name, marks) VALUES (?, ?)", ("Shaik", 90))

# Step 5: Save (commit) changes
conn.commit()

# Step 6: Fetch and display data
cursor.execute("SELECT * FROM students")
rows = cursor.fetchall()
for row in rows:
    print(row)

# Step 7: Close the connection
conn.close()