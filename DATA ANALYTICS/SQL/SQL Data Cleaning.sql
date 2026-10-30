USE company_db;

# Setting Up: the employee_cleaning Table

CREATE TABLE employee_cleaning (
employee_id INT PRIMARY KEY,
first_name VARCHAR(50),
department VARCHAR(50),
salary DECIMAL(10,2)
);

INSERT INTO employee_cleaning VALUES
(101, ' Anil', 'Sales', 55000),
(102, 'Divya ', 'Marketing', 48000),
(103, ' Rahul ', 'Sales', 62000),
(104, 'Meera', 'IT', 45000),
(105, ' Anil ', 'Sales', 55000),
(106, 'Priya', 'IT', 47000);

SELECT * FROM employee_cleaning;


#  DISTINCT - Unique Values from a Column

SELECT DISTINCT department
FROM employee_cleaning;


#  Cleaning Whitespace: TRIM, LTRIM, and RTRIM

SELECT first_name AS original_name,
TRIM(first_name) AS trim_result,
LTRIM(first_name) AS ltrim_result,
RTRIM(first_name) AS rtrim_result
FROM employee_cleaning;


#  REPLACE() - Substituting Text

SELECT department,
REPLACE(department,'IT','Information Technology')
AS department_full
FROM employee_cleaning;

 # Removing Spaces Anywhere in a String
 
 SELECT first_name,
 REPLACE(first_name,' ','') AS no_space_at_all
 FROM employee_cleaning;
 
 
 # Setting Up: the sales_cleaning Table
 
 CREATE TABLE sales_cleaning (
 sale_id INT PRIMARY KEY,
 employee_id  INT,
 sale_date DATE,
 amount DECIMAL (10,2)
 );
 
 INSERT INTO sales_cleaning VALUES
(1001, 101, '2024-01-05', 75000),
(1002, 102, '2024-01-08', 500),
(1003, 103, '2024-01-10', 32000),
(1004, 101, '2024-01-05', 75000),
(1005, 104, '2024-01-12', 12000),
(1006, 101, '2024-01-05', 75000),
(1007, 105, '2024-02-03', 1500);

SELECT * FROM sales_cleaning;


# Finding Duplicate Rows with GROUP BY and HAVING

SELECT employee_id,sale_date,amount, COUNT(*) AS occurence
FROM sales_cleaning
GROUP BY employee_id,sale_date,amount
HAVING COUNT(*) > 1 ;


#  Removing Duplicate Rows with a Window Function

WITH ranked_sales AS (
SELECT sale_id,
ROW_NUMBER() OVER(
PARTITION BY employee_id,sale_date,amount
ORDER BY sale_id
) AS rn
FROM sales_cleaning
)
DELETE FROM sales_cleaning
WHERE sale_id IN (
SELECT sale_id FROM ranked_sales WHERE rn > 1 );

SELECT * FROM sales_cleaning;











