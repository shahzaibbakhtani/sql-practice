drop table Customers;
create database walmart;
use walmart;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);
INSERT INTO Customers VALUES
(1, 'Ali', 'Karachi'),
(2, 'Sara', 'Lahore'),
(3, 'Ahmed', 'Islamabad'),
(4, 'Ayesha', 'Karachi'),
(5, 'Bilal', 'Multan');
select * from Customers;
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    amount INT
    );

INSERT INTO Orders VALUES
(101, 1, 'Laptop', 120000),
(102, 2, 'Phone', 50000),
(103, 1, 'Tablet', 30000),
(104, 3, 'Headphones', 5000),
(105, 6, 'Camera', 70000); 
select * from Orders;

select * from Customers
inner join  Orders 
on Customers.customer_id = Orders.customer_id;

select * from Customers
left join  Orders 
on Customers.customer_id = Orders.customer_id;

select * from Customers
right join  Orders 
on Customers.customer_id = Orders.customer_id;

select * from Customers
left join  Orders 
on Customers.customer_id = Orders.customer_id
where Orders.customer_id is null;

select * from Customers
right join  Orders 
on Customers.customer_id = Orders.customer_id
where Customers.customer_id is null;

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);

INSERT INTO Employees VALUES
(1, 'Ali', NULL),
(2, 'Sara', 1),
(3, 'Ahmed', 1),
(4, 'Ayesha', 2);

select a.name , b.name
from Employees as a 
join Employees as b 
on a.emp_id = b.manager_id;
