--Problem Statement: Design a database schema for a bookstore management system. Define tables for books, authors, customers, and orders, including appropriate relationships and constraints. Write SQL queries to --retrieve a list of top-selling books and calculate total sales revenue for a given period.

-- Create the Books Table
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    author_id INT,
    genre VARCHAR(100),
    price DECIMAL(10,2),
    publication_date DATE,
    quantity_available INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Create the Authors Table
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255),
    biography TEXT
);

-- Create the Customers Table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20)
);

-- Create the Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create the Order_Details Table
CREATE TABLE Order_Details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert data into Authors Table
INSERT INTO Authors (author_name, biography) VALUES
('J.K. Rowling', 'British author best known for the Harry Potter series.'),
('Stephen King', 'American author known for his horror and supernatural fiction.'),
('George Orwell', 'English novelist and essayist, known for his dystopian novel "1984".');

-- Insert data into Books Table
INSERT INTO Books (title, author_id, genre, price, publication_date, quantity_available) VALUES
('Harry Potter and the Philosopher''s Stone', 1, 'Fantasy', 10.99, '1997-06-26', 100),
('Harry Potter and the Chamber of Secrets', 1, 'Fantasy', 12.99, '1998-07-02', 90),
('Harry Potter and the Prisoner of Azkaban', 1, 'Fantasy', 14.99, '1999-07-08', 80),
('The Shining', 2, 'Horror', 9.99, '1977-01-28', 120),
('It', 2, 'Horror', 11.99, '1986-09-15', 110),
('1984', 3, 'Dystopian', 8.99, '1949-06-08', 150);

-- Insert data into Customers Table
INSERT INTO Customers (customer_name, email, phone_number) VALUES
('Alice Johnson', 'alice@example.com', '+1234567890'),
('Bob Smith', 'bob@example.com', '+1987654321'),
('Charlie Brown', 'charlie@example.com', '+1654321890');

-- Insert data into Orders Table
INSERT INTO Orders (customer_id, order_date, total_price) VALUES
(1, '2024-01-15', 43.96),
(2, '2024-01-18', 24.97),
(3, '2024-02-10', 35.97);

-- Insert data into Order_Details Table
INSERT INTO Order_Details (order_id, book_id, quantity, unit_price) VALUES
(1, 1, 2, 10.99),
(1, 4, 1, 9.99),
(1, 6, 1, 8.99),
(2, 5, 2, 11.99),
(3, 3, 3, 14.99);

-- Retrieve a list of top-selling books

SELECT b.title, a.author_name, SUM(od.quantity) AS total_sold
FROM Books b
JOIN Order_Details od ON b.book_id = od.book_id
JOIN Authors a ON b.author_id = a.author_id
GROUP BY b.title, a.author_name
ORDER BY total_sold DESC
LIMIT 10; -- Adjust the limit as per your requirement

-- Calculate total sales revenue for a given period

SELECT SUM(od.quantity * od.unit_price) AS total_revenue
FROM Orders o
JOIN Order_Details od ON o.order_id = od.order_id
WHERE o.order_date BETWEEN 'start_date' AND 'end_date'; -- Replace start_date and end_date with actual dates

