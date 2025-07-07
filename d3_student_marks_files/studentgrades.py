#Day3-assignment
#Takes input of 5 students with their name and marks.
#Stores data into a CSV file grades.csv
#Then reads the file and:
#1. Prints names of students who scored more than 80
#2. Calculates average marks of the class
#3. Saves those with less than 35 as "FAIL" in a new column

import csv

#collect input of 5 students , use for loop and append in student list
student1=[] 

for each in range(5):
    name=input(f"Enter name of student{each+1}: ") # as list starts from 0, but names list should start with 1 na.
    marks=int(input("Enter marks: "))
    student1.append([name, marks])#this is value, so no quotes, variables.

# Step 2: Save to CSV3
with open('marks.csv','w',newline='') as file:
    writer=csv.writer(file)
    writer.writerow(['name','marks']) #this is a header, so quotes
    writer.writerows(student1)

print("\n✅ Data saved to marks.csv")

# Step 3: Read the CSV file and process data 1,2,3 points
#1. Prints names of students who scored more than 80
#logic is create a new list and save students whose marks are more than 80

update_stud=[]
total=0

with open('marks.csv','r') as file:
    reader=csv.reader(file)
    next(reader) # skip header-Because when you read a CSV file using csv.reader(), it includes everything, including the header.
#So if you don’t skip it, your loop will treat 'Name' and 'Marks' as data — and cause errors.
    for each in reader:
        total+=marks
        name,marks=each[0],int(each[1])#Extracts name from column 0 (row[0])- Extracts marks from column 1 (row[1]) and converts it from string to integer using int()
        
    if marks>80:
        print("name of student who scored more than 80 are:", name)
#3. Saves those with less than 35 as "FAIL" in a new column
#Add status column (Fail if marks < 35)
    if marks < 35:
        status = "FAIL"
    else: 
        status="PASS"
    update_stud.append([name, marks, status])

#2. Calculates average marks of the class
   
avg=total/5
print("avg marks of the class:",avg)

# Step 2: Save the updated csv to CSV3
# 3. Save updated CSV with status column
with open('marks.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['name', 'marks', 'status'])
    writer.writerows(update_stud)

print("✅ Updated CSV with FAIL status saved to marks.csv")

        
