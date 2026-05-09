CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
    REFERENCES products(product_id));
    CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);
INSERT INTO customers VALUES
(1, 'Ajay', 'Bangalore', '2024-01-10'),
(2, 'Rahul', 'Hyderabad', '2024-02-15'),
(3, 'Sneha', 'Chennai', '2024-03-12'),
(4, 'Kiran', 'Mumbai', '2024-04-18'),
(5, 'Anjali', 'Delhi', '2024-05-21');
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Headphones', 'Electronics', 2000),
(103, 'Shoes', 'Fashion', 3000),
(104, 'Mobile Phone', 'Electronics', 25000),
(105, 'Watch', 'Accessories', 5000);
INSERT INTO orders VALUES
(1001, 1, '2025-01-10', 57000),
(1002, 2, '2025-01-12', 3000),
(1003, 3, '2025-01-14', 2000),
(1004, 1, '2025-02-01', 25000),
(1005, 5, '2025-02-05', 5000);
INSERT INTO order_items VALUES
(1, 1001, 101, 1, 55000),
(2, 1001, 102, 1, 2000),
(3, 1002, 103, 1, 3000),
(4, 1003, 102, 1, 2000),
(5, 1004, 104, 1, 25000),
(6, 1005, 105, 1, 5000);
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT SUM(total_amount) AS total_revenue
FROM orders;
SELECT * 
FROM customers
WHERE city = 'Bangalore';
SELECT *
FROM products
ORDER BY price DESC;
SELECT customer_id,
       SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;
SELECT customer_id,
       SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 5000;
SELECT c.customer_name,
       o.order_id,
       o.total_amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;
SELECT c.customer_name,
       SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;
SELECT p.product_name,
       SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC;
SELECT p.category,
       SUM(oi.subtotal) AS revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category;
SELECT MONTH(order_date) AS month,
       SUM(total_amount) AS monthly_sales
FROM orders
GROUP BY MONTH(order_date)
ORDER BY month;
SELECT AVG(total_amount) AS average_order_value
FROM orders;
SELECT MAX(total_amount) AS highest_order
FROM orders;
SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > 5000
);
SELECT order_id,
       customer_id,
       total_amount,
       RANK() OVER (ORDER BY total_amount DESC) AS sales_rank
FROM orders;
SELECT order_id,
       total_amount,
       DENSE_RANK() OVER (ORDER BY total_amount DESC) AS dense_rank_value
FROM orders;
SELECT COUNT(*) AS total_orders
FROM orders;
SELECT customer_id,
       COUNT(order_id) AS number_of_orders
FROM orders
GROUP BY customer_id
ORDER BY number_of_orders DESC;
SELECT c.customer_name,
       p.product_name,
       oi.quantity,
       oi.subtotal
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id;