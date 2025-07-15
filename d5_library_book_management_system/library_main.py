#Take input for 3 books from the user:for loop in books list
import sqlite3
import os
import csv

#set path

base_path = os.path.dirname(__file__)
csv_file = os.path.join(base_path, 'd5_books.csv')
database_path=os.path.join(base_path, 'd5_library.db')

conn=sqlite3.connect(database_path)
#conn.row_factory = sqlite3.Row# to use row names, instead of indexes like row[1]

books=[]#List of directories
for each in range(3):
  book_id=int(input(f"Enter the book_id{each+1}: "))
  title=input(f"Enter title of the book{each+1}: ")
  author=input(f"Enter author of the book{each+1}: ")
  price=float(input(f"Enter price of the book{each+1}: "))
  stock_quantity=int(input(f"Enter the quantity of stock{each+1}: "))

  books.append({'id':book_id,'title':title,'author_name':author,'price':price,'stock_quantity':stock_quantity})
print("\nBooks list created:")
for each in books:
   print(each)


#create table
qry_create_table="""create table if not exists d5_books_table (book_id integer primary key,title text,author_name text,price real,stock_quantity integer)"""
conn.execute(qry_create_table)
conn.commit()

#books = list of dictionaries
#execute and executemany() needs a list of tuples (not dicts)
#So we convert each dictionary → tuple

#We create a new list book_values that contains tuples — each tuple has the values in the correct order for SQL insert.
qry_insert_table="""insert or ignore into d5_books_table (book_id,title,author_name,price,stock_quantity)
values(?,?,?,?,?);"""
book_values = []
for each in books:#appending each tuple into book_values
    book_values.append((each['id'], each['title'], each['author_name'], each['price'], each['stock_quantity']))

conn.executemany(qry_insert_table, book_values)

#view all books in library
qry_select_all='''select * from d5_books_table'''
result=conn.execute(qry_select_all)
print("\nview all books in library: ")
for each in result:
   print(each)


#view books by a specific author-fixed
qry_author='''select * from d5_books_table  where author_name='asma';'''
result=conn.execute(qry_author)
print("\nview books by a specific author-fixed: ")
for each in result:
   print(each)

#view books by a specific author-given by user
author_name = input("Enter author name: ").lower()
qry_author2='''select * from d5_books_table where lower(author_name)=?'''
result=conn.execute(qry_author2,(author_name,))
print("\nview books by a specific author-given by user are: ")
for each in result:
   print(each)

#View books priced above ₹300
qry_bookprice_above='''select * from d5_books_table  where price>300;'''
result=conn.execute(qry_bookprice_above)
print("\nView books priced above ₹300: ")
for each in result:
   print(each)


#count total number of books

qry_books_count='''select count(*) from d5_books_table;'''
result=conn.execute(qry_books_count)#using your connection conn
#The result is not just a number — it’s a cursor object (a result set, even if it has just one row)
count=result.fetchone()[0]#it returns something like: (3,) (a tuple with one element)
#[0] → gets the first item in that tuple, which is the actual count → 3

print(f"\n Number of books: {count}")


#**Bonus**: Purchase a book by title and update stock
purchase_book=input("Enter title of the book you want to purchase: ")
qry_purchase="""select stock_quantity from d5_books_table where title=?;"""
cursor=conn.execute(qry_purchase, (purchase_book,))
result=cursor.fetchone()#fetchone and fetchall gives tuples

if result:
   if result[0]>0:
      print("stock available:your book will be shortly delivered")
      qry_update="""update d5_books_table set stock_quantity=stock_quantity-1 where title=?"""
      conn.execute(qry_update, (purchase_book,)) #(purchase_book,)is a tuple, so comma.not a variable
      conn.commit()
   else:
      print("Out of stock")
else:
   print("book not found")

conn.close()

#Always use ? to safely inject variables into SQLite queries.
#(purchase_book,) is a tuple — don’t forget the comma!
#That comma makes all the difference. Python thinks:
#Without comma = just a string
#With comma = tuple of values (even if only one)
