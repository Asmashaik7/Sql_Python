# 📚 Day 5 Assignment – Library Book Management System

## 🧠 Objective

Create a mini project using **Python** and **SQLite** to manage book records in a library system.

Using:
Python lists, functions, and control flow
SQLite table creation, insertion, and querying
A mini-project simulating a real-world problem
---

## ✅ Features

- Take input for 3 books from the user:
  - Book ID
  - Title
  - Author
  - Price
  - Quantity in stock
- Store data in a SQLite database (`library.db`)
- Run queries to:
  - View all books
  - View books by a specific author
  - View books priced above ₹300
  - Count total number of books
- **Bonus**: Purchase a book by title and update stock

---

## 🛠️ Technologies Used

- Python
- SQLite (`sqlite3` module)
- Markdown (`.md` file for documentation)

---

## 🗃️ Database Schema

**Table: books**

| Field     | Type     |
|-----------|----------|
| id        | INTEGER PRIMARY KEY |
| title     | TEXT     |
| author    | TEXT     |
| price     | REAL     |
| quantity  | INTEGER  |

---

## 🧪 Sample Output

