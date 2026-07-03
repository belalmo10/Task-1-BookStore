CREATE DATABASE BookStore
USE BookStore

CREATE TABLE Categories (
    category_id  INT  PRIMARY KEY IDENTITY(1,1),
    name  NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Authors (
    author_id  INT PRIMARY KEY IDENTITY(1,1),
    first_name  NVARCHAR(100) NOT NULL,
    last_name  NVARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    book_id  INT PRIMARY KEY IDENTITY(1,1),
    title   NVARCHAR(255) NOT NULL,
    author_id  INT  NOT NULL REFERENCES Authors(author_id),
    category_id INT  NOT NULL REFERENCES Categories(category_id),
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    stock  INT   NOT NULL DEFAULT 0 CHECK (stock >= 0)
);

CREATE TABLE Customers (
    customer_id   INT  PRIMARY KEY IDENTITY(1,1),
    first_name NVARCHAR(100) NOT NULL,
    last_name  NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    city  NVARCHAR(100)
);

CREATE TABLE Orders (
    order_id  INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT  NOT NULL REFERENCES Customers(customer_id),
    order_date DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE)
);

CREATE TABLE OrderItems (
    item_id  INT PRIMARY KEY IDENTITY(1,1),
    order_id  INT   NOT NULL REFERENCES Orders(order_id),
    book_id  INT  NOT NULL REFERENCES Books(book_id),
    quantity  INT  NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2)   NOT NULL CHECK (unit_price > 0)
    -- unit_price is snapshot of price at time of purchase
);


INSERT INTO Categories (name) VALUES
('Fiction'), ('Non-Fiction'), ('Science'), ('History'),
('Technology'), ('Philosophy'), ('Biography'), ('Mystery'),
('Romance'), ('Self-Help');

INSERT INTO Authors (first_name, last_name) VALUES
('George',   'Orwell'),
('Yuval',    'Harari'),
('Stephen',  'Hawking'),
('Agatha',   'Christie'),
('Robert',   'Martin'),
('Friedrich','Nietzsche'),
('Walter',   'Isaacson'),
('Jane',     'Austen'),
('Dan',      'Brown'),
('James',    'Clear');

INSERT INTO Books (title, author_id, category_id, price, stock) VALUES
('1984',                            1, 1,  12.99, 50),
('Animal Farm',                     1, 1,   8.99, 30),
('Sapiens',                         2, 2,  18.99, 40),
('Homo Deus',                       2, 2,  16.99, 25),
('A Brief History of Time',         3, 3,  14.99, 35),
('The Grand Design',                3, 3,  13.99, 20),
('Murder on the Orient Express',    4, 8,  10.99, 45),
('And Then There Were None',        4, 8,   9.99, 55),
('Clean Code',                      5, 5,  35.99, 15),
('Clean Architecture',              5, 5,  39.99, 10),
('Thus Spoke Zarathustra',          6, 6,  11.99, 18),
('Beyond Good and Evil',            6, 6,  10.49, 22),
('Steve Jobs',                      7, 7,  22.99, 30),
('Einstein: His Life and Universe', 7, 7,  19.99, 12),
('Pride and Prejudice',             8, 9,   7.99, 60),
('Sense and Sensibility',           8, 9,   7.49, 40),
('The Da Vinci Code',               9, 1,  14.49, 50),
('Angels and Demons',               9, 1,  12.49, 35),
('Atomic Habits',                  10,10,  17.99, 70),
('The Power of Habit',             10,10,  15.99,  5);

INSERT INTO Customers (first_name, last_name, email, city) VALUES
('Alice',   'Smith',   'alice@example.com',   'Cairo'),
('Bob',     'Johnson', 'bob@example.com',     'Cairo'),
('Carol',   'Williams','carol@example.com',   'Alexandria'),
('David',   'Brown',   'david@example.com',   'Cairo'),
('Eve',     'Jones',   'eve@example.com',     'Giza'),
('Frank',   'Garcia',  'frank@example.com',   'Alexandria'),
('Grace',   'Martinez','grace@example.com',   'Cairo'),
('Hank',    'Davis',   'hank@example.com',    'Luxor'),
('Ivy',     'Wilson',  'ivy@example.com',     'Cairo'),
('Jack',    'Moore',   'jack@example.com',    'Alexandria'),
('Karen',   'Taylor',  'karen@example.com',   'Giza'),
('Leo',     'Anderson','leo@example.com',     'Aswan');

INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2024-01-10'), 
(1, '2024-02-15'), 
(2, '2024-01-20'), 
(3, '2024-02-05'), 
(4, '2024-03-01'),
(5, '2024-03-15'), 
(6, '2024-04-10'), 
(7, '2024-04-22'), 
(8, '2024-05-05'), -- order 9
(9, '2024-05-18'), -- order 10
(10,'2024-06-01'), -- order 11
(1, '2024-06-20'), -- order 12
(2, '2024-07-08'), -- order 13
(3, '2024-07-25'), -- order 14
(4, '2024-08-10'), -- order 15
(5, '2024-08-30'), -- order 16
(6, '2024-09-14'), -- order 17
(7, '2024-10-01'), -- order 18
(8, '2024-10-20'), -- order 19
(9, '2024-11-05'); -- order 20

-- Order Items (snapshot price at time of sale)
INSERT INTO OrderItems (order_id, book_id, quantity, unit_price) VALUES
-- Order 1
(1,  1, 2, 12.99),
(1,  3, 1, 18.99),
-- Order 2
(2,  9, 1, 35.99),
(2, 19, 2, 17.99),
-- Order 3
(3,  7, 3, 10.99),
(3, 15, 1,  7.99),
-- Order 4
(4, 10, 1, 39.99),
(4, 11, 1, 11.99),
-- Order 5
(5,  4, 2, 16.99),
(5, 17, 1, 14.49),
-- Order 6
(6,  5, 1, 14.99),
(6,  8, 2,  9.99),
-- Order 7
(7, 13, 1, 22.99),
(7, 18, 1, 12.49),
-- Order 8
(8, 19, 3, 17.99),
(8,  2, 2,  8.99),
-- Order 9
(9,  6, 1, 13.99),
(9, 12, 1, 10.49),
-- Order 10
(10, 20, 2, 15.99),
(10, 16, 1,  7.49),
-- Order 11
(11,  1, 1, 12.99),
(11,  9, 1, 35.99),
-- Order 12
(12, 19, 1, 17.99),
(12,  3, 1, 18.99),
-- Order 13
(13,  7, 2, 10.99),
(13, 17, 1, 14.49),
-- Order 14
(14, 10, 1, 39.99),
(14, 14, 1, 19.99),
-- Order 15
(15,  5, 1, 14.99),
(15, 19, 2, 17.99),
-- Order 16
(16,  8, 1,  9.99),
(16, 13, 1, 22.99),
-- Order 17
(17,  1, 3, 12.99),
(17, 11, 1, 11.99),
-- Order 18
(18,  9, 1, 35.99),
(18, 15, 2,  7.99),
-- Order 19
(19,  4, 1, 16.99),
(19, 20, 1, 15.99),
-- Order 20
(20,  7, 2, 10.99),
(20,  3, 1, 18.99);


SELECT
    b.title,
    a.first_name + ' ' + a.last_name AS author,
    c.name                           AS category,
    b.price
FROM Books b
JOIN Authors    a ON a.author_id    = b.author_id
JOIN Categories c ON c.category_id  = b.category_id
ORDER BY b.price DESC;


SELECT
    UPPER(b.title)                                          AS book_title,
    LOWER(a.first_name) + ' ' + LOWER(a.last_name)         AS author_name
FROM Books   b
JOIN Authors a ON a.author_id = b.author_id;


SELECT
    b.title,
    c.name                               AS category,
    a.first_name + ' ' + a.last_name     AS author
FROM Books      b
JOIN Categories c ON c.category_id = b.category_id
JOIN Authors    a ON a.author_id    = b.author_id;


SELECT
    cu.first_name + ' ' + cu.last_name  AS customer,
    COUNT(o.order_id)                   AS total_orders
FROM Customers cu
LEFT JOIN Orders o ON o.customer_id = cu.customer_id
GROUP BY cu.customer_id, cu.first_name, cu.last_name
ORDER BY total_orders DESC;



SELECT TOP 5
    b.title,
    SUM(oi.quantity)    AS total_sold
FROM OrderItems oi
JOIN Books      b  ON b.book_id = oi.book_id
GROUP BY b.book_id, b.title
ORDER BY total_sold DESC;


SELECT TOP 1
    city,
    COUNT(*) AS customer_count
FROM Customers
WHERE city IS NOT NULL
GROUP BY city
ORDER BY customer_count DESC;



SELECT
    c.name  AS category,
    COUNT(b.book_id) AS book_count
FROM Categories c
JOIN Books b ON b.category_id = c.category_id
GROUP BY c.category_id, c.name
HAVING COUNT(b.book_id) > 5;


-- ============================================================
-- TASK 10 — Books that cost more than the average price
-- ============================================================

SELECT
    b.title,
    b.price,
    (SELECT AVG(price) FROM Books) AS avg_price
FROM Books b
WHERE b.price > (SELECT AVG(price) FROM Books)
ORDER BY b.price DESC;


-- ============================================================
-- TASK 11 — Customers who have never made a purchase
-- ============================================================

SELECT
    cu.first_name + ' ' + cu.last_name  AS customer,
    cu.email
FROM Customers cu
LEFT JOIN Orders o ON o.customer_id = cu.customer_id
WHERE o.order_id IS NULL;


-- ============================================================
-- TASK 12 — Total revenue for each month
-- ============================================================

SELECT
    YEAR(o.order_date)  AS [year],
    MONTH(o.order_date)  AS [month],
    DATENAME(MONTH, o.order_date) AS month_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Orders o
JOIN OrderItems oi ON oi.order_id = o.order_id
GROUP BY
    YEAR(o.order_date),
    MONTH(o.order_date),
    DATENAME(MONTH, o.order_date)
ORDER BY [year], [month];


-- ============================================================
-- TASK 13 — View: book title, category, author, price
-- ============================================================

CREATE OR ALTER VIEW vw_BookDetails AS
SELECT
    b.title,
    c.name  AS category,
    a.first_name + ' ' + a.last_name AS author,
    b.price
FROM Books b
JOIN Categories c ON c.category_id = b.category_id
JOIN Authors    a ON a.author_id    = b.author_id;
GO

 SELECT * FROM vw_BookDetails ORDER BY price DESC;


CREATE OR ALTER PROCEDURE sp_CustomerPurchases
    @customer_id INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Guard: customer must exist
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE customer_id = @customer_id)
    BEGIN
        RAISERROR('Customer not found.', 16, 1);
        RETURN;
    END

    -- Order-level detail with per-order total
    SELECT
        o.order_id,
        o.order_date,
        b.title AS book_title,
        oi.quantity,
        oi.unit_price,
        oi.quantity * oi.unit_price AS line_total
    FROM Orders o
    JOIN OrderItems oi ON oi.order_id  = o.order_id
    JOIN Books      b  ON b.book_id    = oi.book_id
    WHERE o.customer_id = @customer_id
    ORDER BY o.order_date, o.order_id;

    -- Summary totals
    SELECT
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.quantity) AS total_items,
        SUM(oi.quantity * oi.unit_price) AS grand_total
    FROM Orders     o
    JOIN OrderItems oi ON oi.order_id = o.order_id
    WHERE o.customer_id = @customer_id;
END;
GO

 EXEC sp_CustomerPurchases @customer_id = 1;
