#Day 4 Assignment: Analyze Sales Data from a CSV
#You're working for a small shop that sells electronics. They give you a CSV file with daily sales records.
#1. Create a CSV file d4_sales.csv. It should contain at least 6 rows with this structure:
#product	units_sold	price_per_unit
#2. Read from d4_sales.csv and compute:
#🔸 Total revenue = units × price
#🔸 Total revenue of the shop (sum of all)
#🔸 List the product(s) with revenue > 50,000
#3. Add a new column status
#If revenue ≥ 50,000 → "High"
#Else → "Normal"
#Save this into a new file: d4_sales_updated.csv
#Bonus:Try exporting this to a SQLite database table (if you're feeling confident!)
import sqlite3
import csv
import os

#set path of files in a same folder

base_path=os.path.dirname(__file__)
csv_file=os.path.join(base_path, 'd4_sales.csv')
update_csv_file=os.path.join(base_path,'d4_sales_updated')

#taking input from users for 6 items using for loop
shop_products=[] # list to save data

for row in range(6):
    product=input(f"Enter name of product {row+1} :")
    units_sold=int(input(f"How many units sold for product{row+1}: "))
    price_per_unit=int(input(f"Price per unit for product{row+1}: "))
    shop_products.append([product,units_sold,price_per_unit])
          
#creating a csv file to save gathered data in it.
with open(csv_file,'w',newline='') as file:
    writer=csv.writer(file)
    writer.writerow(['product','units_sold','price_per_unit']) #should be kept in [], ow it treats them as multiple arguments.Quotes as they are column names
    writer.writerows(shop_products)#list to save data, as its a list, it has many items , so writerows should be used.

#Read from d4_sales.csv and compute:
#🔸 Total revenue = units × price
#🔸 Total revenue of the shop (sum of all)
#🔸 List the product(s) with revenue > 50,000

prod_revenue_list_high=[]# to save list of products with revenue>50,000
prod_revenue_list=[]# to save list of products
with open(csv_file,'r',newline='') as file:
    reader=csv.reader(file)
    next(reader)#next to skip headers of the csv file
    total_revenue=0
    prod_revenue=0
    
    for each in reader:
        product = each[0]
        units_sold = int(each[1])
        price_per_unit = int(each[2])
    
        prod_revenue=units_sold*price_per_unit
        total_revenue+=prod_revenue
        if prod_revenue>=50000:
            status='High'
            prod_revenue_list_high.append([product,units_sold,price_per_unit,status])
            prod_revenue_list.append([product,units_sold,price_per_unit,status])#3. Add a new column status
        else:
            status='Normal'
            prod_revenue_list.append([product,units_sold,price_per_unit,status])
        
    print(f"total revenue of the shop: {total_revenue}")
    print(f"List the product(s) with revenue > 50,000 are: {prod_revenue_list_high}")


print("✅ Data exported to SQLite database (d4_sales.db) successfully.")

#Save this into a new file: d4_sales_updated.csv

with open(update_csv_file,'w') as file:
    writer=csv.writer(file)
    writer.writerow(['product','units_sold','price_per_unit','status'])
    writer.writerows(prod_revenue_list)

print(f"Updated csv file: {prod_revenue_list}")

#Bonus:Try exporting this to a SQLite database table (if you're feeling confident!)

import sqlite3

# Set path for database file
db_file = os.path.join(base_path, 'd4_electronicshop.db')
conn = sqlite3.connect(db_file)

# Create table
create_table = """
CREATE TABLE IF NOT EXISTS d4_sales (
    product TEXT,
    units_sold INTEGER,
    price_per_unit INTEGER,
    status TEXT
);
"""
conn.execute(create_table)
conn.commit()

insert_query = "INSERT INTO d4_sales (product, units_sold, price_per_unit, status) VALUES (?, ?, ?, ?)"
conn.executemany(insert_query, prod_revenue_list) #this is the csv file..
conn.commit()
conn.close()

  



