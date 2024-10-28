SHOW DATABASES;

USE book_ratings;

-- 테이블 생성
CREATE TABLE books(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    genre VARCHAR(100),
    release_year YEAR(4)
)
;

DESCRIBE books;

USE classicmodels;

CREATE TABLE sales
SELECT
    productLine,
    YEAR(orderDate) orderYear,
    SUM(quantityOrdered * priceEach) orderValue
FROM
    orderDetails
        INNER JOIN
    orders USING (orderNumber)
        INNER JOIN
    products USING (productCode)
GROUP BY
    productLine ,
    YEAR(orderDate);
    
SELECT * FROM sales;

-- GROUP BY 
-- ROLL UP 메서드 
SELECT 
	productline
    , SUM(ordervalue) AS 값
FROM sales
GROUP BY 1
;

SELECT NULL, SUM(ordervalue) AS 총합 FROM sales;

-- UNION ALL 
SELECT 
	productline
    , SUM(ordervalue) AS 총합
FROM sales
GROUP BY 1
UNION ALL 
SELECT 
	NULL
    , SUM(ordervalue) AS 총합
FROM sales
;

-- ROLLUP : Grouping 함수 
SELECT
	productline
    , SUM(ordervalue) AS 총합
FROM
	sales
GROUP BY 
	productline WITH ROLLUP
;

-- order
SELECT 
	orderyear
    , productline
    , SUM(ordervalue) AS 총합
FROM sales
GROUP BY
	orderyear
    , productline
WITH ROLLUP
;

-- 출력 : 매니저, 보고대상자
SELECT * FROM employees;

-- SELF JOIN 
SELECT 
	CONCAT(m.lastname, ',', m.firstname) AS 직원
    , CONCAT(e.lastname, ',', e.firstname) AS 보고대상자 
FROM 
	employees e
INNER JOIN employees m
	ON e.employeenumber = m.reportsTo
ORDER BY 1;
