#Project Title: Company Project Tracker
import sqlite3
import os
#set path
base_path=os.path.dirname(__file__)
db_path=os.path.join(base_path,"d8_project_tracker1.db")
if os.path.exists(db_path):
    os.remove(db_path)

conn=sqlite3.connect(db_path)

#re_running this file is making many updates repeated , i want to delete table contents for fresh data, so deleting tables..
# conn.execute("DELETE FROM d8_employees")
# conn.execute("DELETE FROM d8_projects")
# conn.execute("DELETE FROM d8_employee_projects")
# conn.commit()

#Step 1: Table Creation
qry_create_emp="""create table if not exists d8_employees(
emp_id integer PRIMARY KEY,
name text NOT NULL,
department text
);"""
conn.execute(qry_create_emp)
conn.commit()

qry_create_projects="""create table if not exists d8_projects(
project_id integer PRIMARY KEY,
project_name text NOT NULL,
budget integer 
);"""
conn.execute(qry_create_projects)
conn.commit()

qry_create_employee_projects="""create table if not exists d8_employee_projects(
emp_id integer,
project_id integer,
hours_allocated integer,
FOREIGN KEY(emp_id) REFERENCES d8_employees(emp_id),
FOREIGN KEY(project_id) REFERENCES d8_projects(project_id)
UNIQUE(emp_id, project_id)
);"""
conn.execute(qry_create_employee_projects)
conn.commit()

#Step 2:Insert Data
qry_insert_d8_employees="""insert or ignore into d8_employees(emp_id,name,department) values(?,?,?);"""
multiple_entries_emp=[
(1,'Asma','technical'),
(2,'shaik','sales'),
(3,'pandu','technical'),
(4,'sony','technical'),
(5,'pooja','sales')
]
conn.executemany(qry_insert_d8_employees,multiple_entries_emp)
conn.commit()

qry_insert_d8_projects="""insert or ignore into d8_projects(project_id,project_name,budget) values(?,?,?);"""
multiple_entries_projects=[
(1101,'proj1',100000),
(1102,'proj2',150000),
(1103,'proj3',200000)
]
conn.executemany(qry_insert_d8_projects,multiple_entries_projects)
conn.commit()

qry_insert_d8_emp_proj="""insert or ignore into d8_employee_projects(emp_id,project_id,hours_allocated) values(?,?,?);"""
multiple_entries_emp_proj=[
(1,1101,780),
(2,1102,900),
(3,1103,500),
(4,1101,780),
(5,1102,900),
(3,1103,500),
(2,1101,780),
(2,1102,900),
(4,1102,900),
(5,1103,500)
]
conn.executemany(qry_insert_d8_emp_proj,multiple_entries_emp_proj)
conn.commit()

#choice:1
def show_employees():
    qry_show_employees="""select * from d8_employees;"""
    result=conn.execute(qry_show_employees)
    cursor=result.fetchall()
    print("All Employees:")
    for each in cursor:
        print(each)

#choice:2
def show_projects():
    qry_show_projects="""select * from d8_projects;"""
    result=conn.execute(qry_show_projects)
    print("All projects:")
    for each in result:
        print(each)

#choice:3-All empolyee-project assignments
def show_emp_proj():
    qry_show_emp_proj="""select * from d8_employee_projects;"""
    result=conn.execute(qry_show_emp_proj)
    print("All empolyee-project assignments:")
    for each in result:
        print(each)

#choice:4-Search projects by employee name
def search_project():
    print("Current employees in DB:")
    show_employees()
    emp_name=input("Enter emp name,to search projects by emp name:").lower()
    qry_search_proj="""select e.name,p.project_name from d8_employees e
    join d8_employee_projects ep on ep.emp_id=e.emp_id
    join  d8_projects p on p.project_id=ep.project_id
    where lower(e.name)=?;"""

    cursor=conn.execute(qry_search_proj,(emp_name,)) #as its select statement we use execute,. executemany for insert or update
    print("Running query for:", emp_name)
    result=cursor.fetchall()
    if result:
        for each in result:
            print(f"{each[0]}->{each[1]}")
    else:
        print(f"{emp_name} not found in the table")

#choice:5-Search projects by employee name
def add_new_employee():
    emp_id=int(input("enter emp id: "))
    name=input("Enter new student name: ")
    department=input("Enter new emp department: ")
    qry_add_emp="""insert or ignore into d8_employees (emp_id,name,department) values(?,?,?);"""
    conn.execute(qry_add_emp,(emp_id,name,department))
    show_employees()
    print(f"Employee '{name}' added successfully.")
    conn.commit()

#choice:6-Assign employee to a project
def assign_emp_toproject():
    emp_id=int(input("Enter empid:"))
    project_id=int(input("Enter project id:"))
    hours_allocated=int(input("Enter hours allocated:"))
    print("Before insertion:")
    show_emp_proj()
    try:
        qry_add_to_project="""insert or ignore into d8_employee_projects(emp_id,project_id,hours_allocated)values(?,?,?);"""
        conn.execute(qry_add_to_project,(emp_id,project_id,hours_allocated))
        conn.commit()
        print("After insertion:")
        show_emp_proj()
        print(f"Employee {emp_id} assigned to project {project_id} with {hours_allocated} hours.")
    except sqlite3.IntegrityError as e:
        print("Error:", e)

#Bonus Tasks (Optional):
#Bonus Task1.Department-wise Project Hours Summary
# choice:7-Show total hours_allocated for each department using JOIN + GROUP BY.
def deptwise_project_hours():
    qry_deptwise_projecthours="""select e.department as Department_Name, sum(ep.hours_allocated) as Max_Hours_Allocated from d8_employee_projects ep
    join d8_employees e on e.emp_id=ep.emp_id
    group by e.department;"""
    cursor=conn.execute(qry_deptwise_projecthours)
    result=cursor.fetchall()
    print("deptwise project hours: ")
    for each in result:
        print(f"{each[0]}-->{each[1]}")



#Bonus Task2.Top Project by Budget
#choice:8-Show project with highest budget.

def top_proj_by_budget():
    qry_top_proj_by_budget="""select project_name as Project_Name, max(budget) as Highest_Budget from d8_projects
    order by budget DESC limit 1"""#This part sorts all rows in the table from highest budget to lowest.limit one is top one.
    result=conn.execute(qry_top_proj_by_budget)
    for each in result:
        print(f"{each[0]}->{each[1]}")


#Bonus Task3. Employee with Most Hours Assigned
#choice:9-Show employee name and total hours.

def top_emp_most_hours_allocated():
    qry="""select e.name as Employee_Name, sum(ep.hours_allocated) as Total_Hours from d8_employee_projects ep
    join d8_employees e on e.emp_id=ep.emp_id
    group by e.name
    order by Total_Hours desc limit 1;"""
    cursor=conn.execute(qry)
    for each in cursor:
        print(f"{each[0]}->{each[1]}")


#Step 3: Python Menu System
while True:
    print("Menu:")
    print("1. Show all employees")
    print("2. Show all projects")
    print("3. Show all employee-project assignments")
    print("4. Search projects by employee name")
    print("5. Add new employee")
    print("6. Assign employee to a project")
    print("7. Deptwise project hours summary")
    print("8. Top Project by Budget")
    print("9. Employee with Most Hours Assigned")
    print("10. Exit")
    
    choice=input("Enter your choice:")
    if choice=="1":
        show_employees()
    elif choice=='2':
        show_projects()
    elif choice=='3':
        show_emp_proj()
    elif choice=='4':
        search_project()
    elif choice=='5':
         add_new_employee()
    elif choice=='6':
         assign_emp_toproject()
    elif choice=='7':
        deptwise_project_hours()
    elif choice=='8':
        top_proj_by_budget()
    elif choice=='9':
        top_emp_most_hours_allocated()
    elif choice=='10':
        print("Exiting..")
        break
    else:
        print("Not a valid choice.")



