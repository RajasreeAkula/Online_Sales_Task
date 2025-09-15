CREATE DATABASE IF NOT EXISTS online_sales;
USE online_sales;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  order_id VARCHAR(255),
  order_date DATETIME,
  product_id VARCHAR(255),
  product_name VARCHAR(255),
  units_sold INT,
  unit_price DECIMAL(12,2),
  total_revenue DECIMAL(12,2),
  region VARCHAR(255),
  payment_method VARCHAR(255)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Online Sales Data.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, order_date, product_id, product_name, units_sold, unit_price, total_revenue, region, payment_method);


SELECT COUNT(*) FROM orders;
SELECT * FROM orders LIMIT 5;

SELECT 
    order_id,
    order_date,
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    total_revenue
FROM orders
LIMIT 10;

SELECT 
    YEAR(`order_date`) AS `year`,
    MONTH(`order_date`) AS `month`,
    SUM(`total_revenue`) AS `total_revenue`,
    COUNT(DISTINCT `order_id`) AS `order_count`
FROM `orders`
GROUP BY YEAR(`order_date`), MONTH(`order_date`)
ORDER BY `year`, `month`;


SELECT 
    YEAR(`order_date`) AS `year`,
    MONTH(`order_date`) AS `month`,
    SUM(`total_revenue`) AS `total_revenue`,
    COUNT(DISTINCT `order_id`) AS `order_count`
FROM `orders`
WHERE YEAR(`order_date`) = 2024
GROUP BY YEAR(`order_date`), MONTH(`order_date`)
ORDER BY `month`;

SELECT 
    DATE_FORMAT(`order_date`, '%Y-%m') AS `year_month`,
    SUM(`total_revenue`) AS `total_revenue`,
    COUNT(DISTINCT `order_id`) AS `order_count`
FROM `orders`
GROUP BY `year_month`
ORDER BY `total_revenue` DESC
LIMIT 5;

SELECT 
    DATE_FORMAT(`order_date`, '%M-%Y') AS `month_year`,
    SUM(`total_revenue`) AS `total_revenue`,
    COUNT(DISTINCT `order_id`) AS `order_count`
FROM `orders`
GROUP BY `month_year`
ORDER BY STR_TO_DATE(`month_year`, '%M-%Y');















