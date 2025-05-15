CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    price REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS customers ( 
	customer_id INTEGER PRIMARY KEY, 
	first_name TEXT NOT NULL, 
	last_name TEXT NOT NULL, 
	email TEXT NOT NULL UNIQUE 
);

CREATE TABLE IF NOT EXISTS orders ( 
	order_id INTEGER PRIMARY KEY, 
	customer_id INTEGER NOT NULL, 
	product_id INTEGER NOT NULL, 
	quantity INTEGER NOT NULL, 
	order_date DATE NOT NULL, 
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id), 
	FOREIGN KEY (product_id) REFERENCES products(product_id) 
);

-- 1
-- INSERT INTO products (name, category, price) VALUES
-- 	("Samsung", "Phones", 20000),
-- 	("Iphone", "Phones", 50000),
-- 	("Xiaomi", "Phones", 9000),
-- 	("Dell", "Laptops", 120000),
-- 	("HP", "Laptops", 50000),
-- 	("Lenovo", "Laptops", 30000),
-- 	("Ipad", "Tablets", 60000),
-- 	("Galaxy Tab", "Tablets", 40000)

-- 2
-- INSERT INTO customers (first_name, last_name, email) VALUES
-- 	("John", "Claim", "iamjohn@google.com"),
-- 	("Ivan", "Shevchenko", "yavanya@ukr.net"),
-- 	("Marek", "Kosz", "jestemmarek@example.com")

-- 3
-- INSERT INTO orders (customer_id, product_id, quantity, order_date) VALUES
-- 	(1, 2, 2, "07.05.2025"),
-- 	(1, 7, 3, "07.05.2025"),
-- 	(1, 4, 1, "07.05.2025"),
-- 	(2, 1, 3, "01.05.2025"),
-- 	(2, 5, 1, "01.05.2025"),
-- 	(3, 3, 10, "08.03.2025"),
-- 	(3, 6, 2, "08.03.2025"),
-- 	(3, 8, 2, "08.03.2025")


-- 4
SELECT SUM(orders.quantity * products.price)
FROM orders JOIN products ON orders.product_id = products.product_id;

-- 5
SELECT customers.first_name, customers.last_name, COUNT(orders.order_id) AS order_count
FROM customers JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id;

-- 6
SELECT AVG(orders.quantity * products.price)
FROM orders JOIN products ON orders.product_id = products.product_id;

-- 7
SELECT products.category, COUNT(orders.order_id)
FROM orders JOIN products ON orders.product_id = products.product_id
GROUP BY products.category;

-- 8
SELECT category, COUNT(category)
FROM products GROUP BY category;

-- 9
-- UPDATE products SET price = price * 1.1 WHERE category = "Phones"