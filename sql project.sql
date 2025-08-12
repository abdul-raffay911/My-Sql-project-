CREATE TABLE Books(
			Book_ID int,
			title varchar(150),
			author varchar (150),
			genre varchar(100),
			published_year int,
			price numeric (10,2),
			stock int
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- 1) Retrieve all books in the "Fiction" genre:

select * from books 
where genre='Fiction';

-- 2) Find books published after the year 1950:

select * from books
where published_year>1950;

-- 3) List all customers from the Canada:

select * from Customers
where country='Canada' 

-- 4) Show orders placed in November 2023:

select * from orders 
where order_date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:

select sum(stock) from books; 

-- 6) Find the details of the most expensive book:

select * from books order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:

select * from orders 
where quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:

select * from orders
where total_amount>20;

-- 9) List all genres available in the Books table:

select distinct(genre) from books;

-- 10) Find the book with the lowest stock:

select * from books order by stock asc limit 1;

-- 11) Calculate the total revenue generated from all orders:

select sum (total_amount) from orders as revenue 

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:

select b.genre, sum(o.quantity) as total_books_sold
from
orders o join books b
on
o.book_id=b.book_id
group by b.genre

-- 2) Find the average price of books in the "Fantasy" genre:

select avg(price) as average_price 
from books
where genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders:
--my query 

select c.name,count(o.order_id) as total_orders
from orders o join customers c
on o.customer_id=c.customer_id
group by c.name
having count(order_id) >= 2;

--satish dhawale query 

select customer_id, count(order_id) as order_count
from orders
group by customer_id
having count(order_id)>=2;

-- 4) Find the most frequently ordered book:

select b.title,count(o.order_id) as order_count
from orders o join books b
on 
b.book_id=o.book_id
group by  b.title 
order by order_count desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

select * from books 
where genre='Fantasy'
order by price desc limit 3

-- 6) Retrieve the total quantity of books sold by each author:

select b.author,sum(o.quantity) as total_qantity
from 
books b join orders o
on 
b.book_id=o.book_id
group by author;

-- 7) List the cities where customers who spent over $30 are located:

select c.name,c.city,o.total_amount 
from 
orders o join customers c
on c.customer_id = o.book_id
group by name,city, total_amount
having o.total_amount > 30;


-- 8) Find the customer who spent the most on orders:

select c.customer_id,c.name,sum(o.total_amount) as total_amount 
from 
customers c join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.name
order by total_amount desc;

--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id,b.title,b.stock
ORDER BY b.book_id;












