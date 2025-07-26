SELECT emp_-- Create departments table
CREATE TABLE departments (
    dept_id INTEGER PRIMARY KEY,
    dept_name TEXT
);

-- Create employees table
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY,
    emp_name TEXT,
    dept_id INTEGER,
    salary INTEGER,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Insert data into departments
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

-- Insert data into employees
INSERT INTO employees (emp_id, emp_name, dept_id, salary) VALUES
(101, 'Asha', 1, 60000),
(102, 'Ravi', 2, 80000),
(103, 'Zoya', 2, 50000),
(104, 'John', NULL, 70000);