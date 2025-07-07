import sqlite3
import csv

conn=sqlite3.connect('cars.db')
conn.execute("DROP TABLE IF EXISTS owners;")
conn.execute("DROP TABLE IF EXISTS cars;")
conn.commit()
# create a table, car

qry_create_table="""CREATE table if not exists cars (
    carid integer primary key,
    carname text,
    carmodel text,
    caryear int
); """

# use the conn object that we have created to execute all the queries
# we call     .execute(QUERY) method from conn object to run queries

conn.execute(qry_create_table)


# insert some values into cars database
qry_insrt_cars_db='''INSERT or ignore INTO cars (carid, carname, carmodel, caryear)
VALUES ('1958', 'Maruthi800', '1990', '1995'); '''

conn.execute(qry_insrt_cars_db)
conn.commit()


qry_insertmany = """ INSERT or ignore INTO cars VALUES (?,?,?,?)"""
multiple_rows = [
    ('2000', 'Maruthi Esteem', '1990', '1997'),
    ('2020', 'BMW', '1980', '1997'),
    ('2025', 'Piaggio', '1999', '2000'),
    ('1970', 'Maruthi', '1990', '1997'),
    ('2001', 'Esteem', '1990', '1997'),
    ('2021', 'Kia', '1990', '1997'),
    ('1999', 'Premier', '1990', '1997'),
    ('1980', 'Padmini', '1990', '1997'),
    ('1960', 'Contessa', '1990', '1997'),
    ('1998', 'merc', '1990', '1997'),
    ('2010', 'Maruthi Esteem', '1990', '1997')
]


# to insert multiple rows, we use execute many method

conn.executemany(qry_insertmany,multiple_rows)
conn.commit()

# when we run the select queries then a response obj is returned which will have the data
# we use that obj for further ops

qry_select_all = "select * from cars;"
# conn.execute(qry_select_all)
data=conn.execute(qry_select_all)
data

# use a for loop to read the data from cars
for each_row in data:
    print(each_row)

#creating owner table
qry_create_owners="""CREATE table if not exists owners (
    owner_name text,
    owner_id int,
    owner_car_id text, foreign key(owner_car_id) references cars(carid)
); """

conn.execute(qry_create_owners)
conn.commit()


#insert data into owners table
qry_insert_owners=""" INSERT or ignore INTO owners VALUES (?,?,?)"""
qry_insertmany_owners=[
    ('Maruthi Rao', '2020', 'TS1997'),
    ('BMW Asma', '2001', 'TG1997'),
    ('Piaggio shaik', '1999', 'AP2000'),
    ('Maruthi manha', '1990', 'TS1997'),
    ('Esteem Ayman', '2012', 'TG1997'),
    ('Kia Karan', '1970', 'PB1997'),
    ('Premier zoya', '1980', 'KL1997'),
    ('Padmini latha', '1960', 'KA1997'),
    ('Contessa Kannedy', '2010', 'AP1997'),
    ('merc Benz Baba', '2025', 'DL1997'),
    ('Tata Taqi', '2000', 'TS1997')
]
    
conn.executemany(qry_insert_owners, qry_insertmany_owners)
qry_select_all_owners="""select * from owners"""

conn.commit()


def fun_car(query,data=None,db='cars.db'):#The SQL query to run,--data is type, list or single data,--db is our db
    conn=sqlite3.connect(db)
    cursor=conn.cursor()# Creates a cursor object to execute SQL commands.
    try:
        if data:
            cursor.executemany(query,data) if isinstance(data,list) else cursor.execute(query,data)
            # isinstance checks the type of data.if single row it runs execute or if data is many rows, it goes executemany()
        else:
            cursor.execute(query) #runs , selects or creates when NO data is there
    
        if query.strip().lower().startswith("select"):
            result=cursor.fetchall()
            conn.close()
            return result #returns result, the list of rows back to the function.
        else:
             #cursor.execute(query) #If it's not a SELECT (like INSERT, DELETE, UPDATE):Commits the changes to the DB (e.g., save new records).
             conn.commit()
             conn.close()
    except sqlite3.Error as e:
        conn.close()
        return f"an error occured: {e}"


def fun_owners(query,data=None,db='cars.db'):#The SQL query to run,--data is type, list or single data,--db is our db
    conn=sqlite3.connect(db)
    cursor=conn.cursor()# Creates a cursor object to execute SQL commands.
    try:
        if data:
            cursor.executemany(query,data) if isinstance(data,list) else cursor.execute(query,data)
            # isinstance checks the type of data.if single row it runs execute or if data is many rows, it goes executemany()
        else:
            cursor.execute(query) #runs , selects or creates when NO data is there
    
        if query.strip().lower().startswith("select"):
            result=cursor.fetchall()
            conn.close()
            return result #returns result, the list of rows back to the function.
        else:
             #cursor.execute(query) #If it's not a SELECT (like INSERT, DELETE, UPDATE):Commits the changes to the DB (e.g., save new records).
             conn.commit()
             conn.close()
    except sqlite3.Error as e:
        conn.close()
        return f"an error occured: {e}"


result=fun_car(qry_select_all)
for row in result:
    print(row)

print("\n")

result1=fun_owners(qry_select_all_owners)
for r in result1:
    print(r)

## Export to CSV
with open('car.csv', 'w') as file:
    writer=csv.writer(file)
    writer.writerow(['carid', 'carmake', 'carmodel', 'caryear'])  # Column names
    writer.writerows(result)
    print("Data exported to car.csv successfully ...")


with open('owners.csv','w') as file1:
    writer=csv.writer(file1)
    writer.writerows(['owner_name','owner_id','owner_car_id'])
    writer.writerows(result1)
    print("Data exported to owners.csv successfully ...")

