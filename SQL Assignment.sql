## Question 1 : Explain the fundamental differences between DDL, DML, and DQL commands in SQL. 
## Provide one example for each type of command. 

## Answer : In SQL, commands are grouped based on their purpose. DDL (Data Definition Language) defines the structure 
## of the database, DML (Data Manipulation Language) modifies the data within tables, and DQL (Data Query Language) retrieves 
## data for viewing or analysis.
## 1) DDL (Data Definition Language) - Used to define or modify the structure of database objects such as tables, schemas, or 
## indexes. For example:  
	CREATE TABLE Students (ID INT, Name VARCHAR(50));
## 2) DML (Data Manipulation Language) - Used to insert, update, or delete data stored in database tables. For example: 
	INSERT INTO Students VALUES (1, ‘Rahul’);
## DQL (Data Query Language) - Used to retrieve data from the database based on specific conditions. For example: 
	SELECT * FROM Students WHERE ID = 1;

## Question 2 : What is the purpose of SQL constraints? Name and describe three common types of constraints, providing a 
## simple scenario where each would be useful. 

## Answer : SQL constraints are rules applied to table columns to maintain data accuracy and consistency in a database. 
## They prevent invalid or duplicate data and help ensure relationships between tables are correct. 

## PRIMARY KEY - Uniquely identifies each record in a table. For example, StudentID in a Students table can be used as a primary key.

## FOREIGN KEY - Maintains referential integrity by linking one table to another. For instance, StudentID in a Marks table can refer 
## to the Students table.

## CHECK - Ensures that data in a column meets a specific condition. For example, a check constraint can make sure an 
## employee’s Salary > 0.

## Question 3 : Explain the difference between LIMIT and OFFSET clauses in SQL. How would you use them together to retrieve 
## the third page of results, assuming each page has 10 records?

## Answer : In SQL, the LIMIT clause is used to specify the maximum number of records to return from a query, while the OFFSET 
## clause is used to skip a specific number of rows before starting to return the results. 
##		When used together, they help in dividing results into pages. To retrieve the third page of results with 10 records 
## per page, we skip the first 20 records (2 pages × 10 records each) and then fetch the next 10. Example: 
	SELECT * FROM Students  
	LIMIT 10 OFFSET 20;
##		This query returns records 21 to 30, representing the third page of results.

## Question 4 : What is a Common Table Expression (CTE) in SQL, and what are its main benefits? Provide a simple SQL example 
## demonstrating its usage.

## Answer : A Common Table Expression (CTE) is a temporary, named result set that is defined within the execution scope of 
## a single SQL query. It is created using the WITH keyword and can be referenced like a regular table in a subsequent 
## SELECT, INSERT, UPDATE, or DELETE statement. Main benefits of using a CTE:
## 1) Makes complex queries easier to read and manage.
## 2) Allows reusing the same temporary result multiple times within a query.
## 3) Supports recursive queries, which are useful for working with hierarchical data (like employee-manager relationships).

## Example : This query first creates a CTE named HighSalary containing employees earning more than ₹50,000, and then retrieves 
## all records from it.
WITH HighSalary AS (
    SELECT Name, Salary 
    FROM Employees 
    WHERE Salary > 50000
)
SELECT * FROM HighSalary;

## Question 5 : Describe the concept of SQL Normalization and its primary goals. Briefly explain the first three normal 
## forms (1NF, 2NF, 3NF). 

## Answer : SQL Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity. 
## It involves dividing large tables into smaller, related ones and defining relationships between them.
## Primary goals of normalization:
## 1) Eliminate duplicate data.
## 2) Ensure data dependencies make sense.
## 3) Simplify data maintenance and improve consistency.

##		The first three normal forms are:

## First Normal Form (1NF): Ensures that all columns contain only atomic (indivisible) values and each record is unique. 
## Example: A student table should not have multiple phone numbers in one column.

## Second Normal Form (2NF): Achieved when the table is in 1NF and all non-key attributes depend fully on the primary 
## key (no partial dependency).
## Example: In a table with a composite key, each non-key column must depend on the whole key, not just part of it.

## Third Normal Form (3NF): Achieved when the table is in 2NF and all columns depend only on the primary key, not on other 
## non-key attributes (no transitive dependency).
## Example: In an employee table, DepartmentName should not depend on DepartmentID if DepartmentID already identifies it in another table.


CREATE DATABASE Assignment;
USE Assignment;

## QUESTION 6 SOLUTION :
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL UNIQUE,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Home Goods'),
(4, 'Apparel');

INSERT INTO Products (ProductID, ProductName, CategoryID, Price, StockQuantity) VALUES
(101, 'Laptop Pro', 1, 1200.00, 50),
(102, 'SQL Handbook', 2, 45.50, 200),
(103, 'Smart Speaker', 1, 99.99, 150),
(104, 'Coffee Maker', 3, 75.00, 80),
(105, 'Novel: The Great SQL', 2, 25.00, 120),
(106, 'Wireless Earbuds', 1, 150.00, 100),
(107, 'Blender X', 3, 120.00, 60),
(108, 'T-Shirt Casual', 4, 20.00, 300);

INSERT INTO Customers (CustomerID, CustomerName, Email, JoinDate) VALUES
(1, 'Alice Wonderland', 'alice@example.com', '2023-01-10'),
(2, 'Bob the Builder', 'bob@example.com', '2022-11-25'),
(3, 'Charlie Chaplin', 'charlie@example.com', '2023-03-01'),
(4, 'Diana Prince', 'diana@example.com', '2021-04-26');

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1001, 1, '2023-04-26', 1245.50),
(1002, 2, '2023-10-12', 99.99),
(1003, 1, '2023-07-01', 145.00),
(1004, 3, '2023-01-14', 150.00),
(1005, 2, '2023-09-24', 120.00),
(1006, 1, '2023-06-19', 20.00);

SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;

## QUESTION 7 : Generate a report showing CustomerName, Email, and the TotalNumberofOrders for each customer. 
## Include customers who have not placed any orders, in which case their TotalNumberofOrders should be 0. 
## Order the results by CustomerName.

## ANSWER :
SELECT 
    c.CustomerName,
    c.Email,
    COUNT(o.OrderID) AS TotalNumberOfOrders
FROM 
    Customers c
LEFT JOIN 
    Orders o 
ON 
    c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerName, c.Email
ORDER BY 
    c.CustomerName;


## Question 8 : Retrieve Product Information with Category: Write a SQL query to display the ProductName, Price, 
## StockQuantity, and CategoryName for all products. Order the results by CategoryName and then ProductName 
## alphabetically.

## ANSWER :
SELECT 
    Products.ProductName,
    Products.Price,
    Products.StockQuantity,
    Categories.CategoryName
FROM 
    Products
JOIN 
    Categories
ON 
    Products.CategoryID = Categories.CategoryID
ORDER BY 
    Categories.CategoryName, 
    Products.ProductName;

## Question 9 : Write a SQL query that uses a Common Table Expression (CTE) and a Window Function (specifically 
## ROW_NUMBER() or RANK()) to display the CategoryName, ProductName, and Price for the top 2 most expensive products 
## in each CategoryName.

## ANSWER :

WITH RankedProducts AS (
    SELECT 
        Categories.CategoryName,
        Products.ProductName,
        Products.Price,
        ROW_NUMBER() OVER (
            PARTITION BY Categories.CategoryName 
            ORDER BY Products.Price DESC
        ) AS RowNum
    FROM 
        Products
    JOIN 
        Categories
    ON 
        Products.CategoryID = Categories.CategoryID
)
SELECT 
    CategoryName,
    ProductName,
    Price
FROM 
    RankedProducts
WHERE 
    RowNum <= 2
ORDER BY 
    CategoryName, 
    Price DESC;

##  QUESTION 10 SOLUTION :

use sakila;
select * from actor;


use sakila;

## Identify the top 5 customers based on the total amount they’ve spent. Include customer
## name, email, and total amount spent.

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS Customer_Name,
    c.email as Email,
    SUM(p.amount) AS TotalAmountSpent
FROM 
    customer c
JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id
ORDER BY 
    TotalAmountSpent DESC
LIMIT 5;

## 2. Which 3 movie categories have the highest rental counts? Display the category name
## and number of times movies from that category were rented.

SELECT 
    c.name AS Category_Name,
    COUNT(r.rental_id) AS Total_no_of_Rentals
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    c.name
ORDER BY 
    Total_No_of_Rentals DESC
LIMIT 3;

## 3. Calculate how many films are available at each store and how many of those have
## never been rented.

SELECT 
    s.store_id,
    COUNT(DISTINCT i.inventory_id) AS TotalFilms,
    COUNT(DISTINCT i.inventory_id) - COUNT(DISTINCT r.inventory_id) AS NeverRented
FROM 
    store s
JOIN 
    inventory i ON s.store_id = i.store_id
LEFT JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    s.store_id;

## 4. Show the total revenue per month for the year 2023 to analyze business seasonality.

SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS Month,
    SUM(amount) AS TotalRevenue
FROM 
    payment
WHERE 
    YEAR(payment_date) = 2023
GROUP BY 
    Month
ORDER BY 
    Month;

## 5. Identify customers who have rented more than 10 times in the last 6 months.

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS CustomerName,
    c.email,
    COUNT(r.rental_id) AS RentalCount
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
WHERE 
    r.rental_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY 
    c.customer_id
HAVING 
    RentalCount > 10
ORDER BY 
    RentalCount DESC;