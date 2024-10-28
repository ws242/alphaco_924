-- SQL 순서
-- FROM => WHERE => GROUP BY => SELECT => DISTINCT => ORDER BY

-- GROUP BY vs DISTINCT 비교 
-- 테이블명 : orders
USE classicmodels;
SELECT 
	status
FROM 
	orders
GROUP BY
	status
;

SELECT 
	DISTINCT status
FROM 
	orders
;
-- 둘 차이가 없다! 그룹바이도 중복값을 제거해 줌 

-- GROUP BY : COUNT()
-- group by는 그룹간 비교를 위해 사용
SELECT 
	status
    , COUNT(*)
FROM 
	orders
GROUP BY
	status
;

-- 테이블명 : orderdetails
SELECT * FROM orderdetails;

SELECT
	orderNumber
    , quantityOrdered * priceEach AS 매출액
FROM
	orderdetails
;

-- 주문번호 당 총 매출액, 평균 매출액 구하기
SELECT
	orderNumber
    , SUM(quantityOrdered * priceEach) AS 총매출액
    , AVG(quantityOrdered * priceEach) AS 평균매출액
    , stddev_samp(quantityOrdered * priceEach) AS 표준편차
    , var_samp(quantityOrdered * priceEach) AS 분산
FROM
	orderdetails
GROUP BY 
	orderNumber
;

-- productCode, orderLineNumber 당 집계함수
-- 주문번호당, 총매출액, 평균매출액을 구하세요
SELECT
	productCode
    , orderLineNumber
    , SUM(quantityOrdered * priceEach) AS 총매출액
    , AVG(quantityOrdered * priceEach) AS 평균매출액
    , stddev_samp(quantityOrdered * priceEach) AS 표준편차
    , var_samp(quantityOrdered * priceEach) AS 분산
FROM
	orderdetails
GROUP BY 
	productCode
    , orderLineNumber
ORDER BY
	productCode
    , orderLineNumber
;

-- HAVING
-- 순서 : FROM ==> WHERE ==> GROUP BY ==> HAVING ==> SELECT ==>...
-- 위 코드에서 HAVING 절 추가 
-- orderLineNumber에서 1만 별도로 조회
-- HAVING절은 단독으로 쓸 수 없음 - GROUP BY와 함께 
SELECT
	productCode
    , orderLineNumber
    , SUM(quantityOrdered * priceEach) AS 총매출액
    , AVG(quantityOrdered * priceEach) AS 평균매출액
    , stddev_samp(quantityOrdered * priceEach) AS 표준편차
    , var_samp(quantityOrdered * priceEach) AS 분산
FROM
	orderdetails
GROUP BY 
	productCode
    , orderLineNumber
HAVING 
	-- orderLineNUmber = 1
    -- 총매출액 >= 10000
    -- 집계함수에는 컬럼 숫자 적용이 안됨 (그룹바이는 됨)
    orderLineNumber = 1 
    AND 총매출액 >= 1000   -- 다른 DBMS에서는 에러 날 가능성 존재 
ORDER BY
	productCode
    , orderLineNumber
;

-- 테이블명 : orderdetails
-- 출력값 
-- ordernumber 주문개수 매출액 
-- 10100        151   10223.83   -> 예상 출력값
-- 조건 : 주문개수 >= 700 
SELECT 
  ordernumber, 
  SUM(quantityOrdered) AS 주문갯수, 
  SUM(priceeach * quantityOrdered) AS 매출액 
FROM 
  orderdetails 
GROUP BY 
  ordernumber 
HAVING 
  주문갯수 > 700;
  
-- JOIN
-- 테이블 생성
-- DROP TABLE members; -- 테이블 삭제하는 명령어
CREATE TABLE members(
	member_id  INT AUTO_INCREMENT
    , name VARCHAR(100)
    , PRIMARY KEY (member_id)
)
;

INSERT INTO members(name)
VALUES('A'), ('B'), ('C'), ('D'), ('E')
;

SELECT * FROM members;

CREATE TABLE committees (
    committee_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (committee_id) -- 기본키는 중복을 허용하지 않음 
);

INSERT INTO committees(name)
VALUES('A'),('B'),('C'),('F');

-- INNER JOIN 
SELECT * FROM members;
SELECT * FROM committees;

-- 문법 1
/*
SELECT *
FROM table_1
INNER JOIN table_2 USING (column_name) -- 컬럼명이 같으면 유용
*/

-- 원래는 name 사용 불가 (일반적으로 name에는 중복값이 존재)
-- 여기서는 모두 유일값이 있으므로 임시로 사용 가능 
SELECT *
FROM members m 
INNER JOIN committees c USING(name)
;

-- 문법2
-- 문법1과 결과가 어떻게 다른지 확인 
SELECT *
FROM members m 
INNER JOIN committees c ON c.name = m.name;
-- INNER JOIN committees c ON c.committee_id = m.member_id;

-- LEFT JOIN - 문법1
SELECT *
FROM members m 
LEFT JOIN committees c USING(name)
;

-- LEFT JOIN - 문법2
SELECT *
FROM members m 
LEFT JOIN committees c ON c.name = m.name
;

-- RIGHT JOIN - 문법1
SELECT *
FROM members m 
RIGHT JOIN committees c USING(name)
;

-- RIGHT JOIN - 문법2
SELECT *
FROM members m 
RIGHT JOIN committees c ON c.name = m.name
;

-- NULL 값 조회 
SELECT *
FROM members m 
RIGHT JOIN committees c USING(name)
WHERE m.member_id IS NULL
;

-- SELECT 문법
SELECT 
	m.name AS member_name
	, c.name AS committee_name 
FROM members m 
RIGHT JOIN committees c ON c.name = m.name
;

-- 일별 매출액 조회
-- 테이블명 : orders, orderdetails
-- 두 테이블 조합 후, 일자별로 매출액을 산출하세요
-- 출력값
-- orderdate     priceeach*quantityordered
-- 2003-01-06    4080.00
-- INNER JOIN
SELECT 
	orderDate
    , priceEach*quantityOrdered AS 매출액
FROM orders
INNER JOIN orderdetails USING(orderNumber)
;

-- RIGHT JOIN
SELECT
	orderDate
    , priceEach * quantityOrdered AS 매출액
FROM orders
RIGHT JOIN orderdetails USING(orderNumber)
;

-- 월별 매출액 
-- 함수명 : SUBSTR() 활용해서 월별 매출액 구하세요
-- 단, orderDate 출력은 2003-04 형태로
-- 그룹바이는 집계함수 필수임.
SELECT 
	SUBSTRING(orderDate, 1, 7) month
    , SUM(priceEach * quantityOrdered) AS 매출액
FROM orders
LEFT JOIN orderdetails USING(orderNumber)
GROUP BY SUBSTR(orderdate, 1, 7)  -- 대신 1도 가능 / 1은 컬럼 - SUBSTRING(orderDate, 1, 7) month을 의미
;

SELECT 
	SUBSTRING(orderDate, 1,7) month
    , SUM(priceEach * quantityOrdered) AS 매출액
FROM orders A
LEFT JOIN orderdetails B
ON A.ordernumber = B.ordernumber
GROUP BY SUBSTR(orderdate, 1, 7)
;

-- 연도별 매출액 조회
SELECT
	SUBSTRING(orderDate, 1, 4) year
    , SUM(priceEach * quantityOrdered) AS 매출액
FROM orders A
LEFT JOIN orderdetails B
ON A.ordernumber = B.ordernumber
GROUP BY SUBSTR(orderdate, 1, 4)
;

SELECT
	YEAR(orderdate) year -- 연도만 추출
    , SUM(priceEach * quantityOrdered) AS 매출액
FROM orders A
LEFT JOIN orderdetails B
ON A.ordernumber = B.ordernumber
GROUP BY YEAR(orderdate)
;

SELECT
	month(orderdate) month
    , SUM(priceEach * quantityOrdered)
FROM orders A
LEFT JOIN orderdetails B
ON A.ordernumber = B.ordernumber
GROUP BY MONTH(orderdate)
;

SELECT
	YEAR(orderdate) year
	, DAYNAME(orderdate) Days
    , SUM(priceEach * quantityOrdered)
FROM orders A
LEFT JOIN orderdetails B
ON A.ordernumber = B.ordernumber
GROUP BY 
	YEAR(orderdate)
	, DAYNAME(orderdate)
;

-- 이전에는 시간, 일별, 월별, 연도별 매출액
-- 이번시간에는 구매건수
SELECT * FROM orders ORDER BY customernumber;
SELECT customernumber, ordernumber, orderdate
FROM orders ORDER BY customernumber;

-- 가정 : 한 명의 고객이 여러 번 구매할 수 있음
-- 중복값 제거 -> 혹시나 주문번호가 동일한 경우, 개수가 2개가 될 것을 방지하기 위해
SELECT customernumber, ordernumber, orderdate
FROM orders;

-- 개수가 동일하니까, 다행스럽게 중복된 주문번호는 없음 
SELECT
	COUNT(ordernumber) 주문개수
	, COUNT(DISTINCT ordernumber) 중복확인
FROM 
	orders
;

-- 일자별 주문 건수
SELECT 
	orderdate
    , COUNT(DISTINCT customernumber) 구매자수
    , COUNT(DISTINCT ordernumber) 주문건수
FROM
	orders
GROUP BY 1
ORDER BY 1
;

-- 월별 주문건수
SELECT 
	SUBSTR(orderdate, 1, 7) 월별
    , COUNT(DISTINCT customernumber) 구매자수
    , COUNT(DISTINCT ordernumber) 주문건수
FROM
	orders
GROUP BY 1
ORDER BY 1
;

-- 인당 매출액 구하기
-- JOIN
SELECT * 
FROM orders
LEFT JOIN orderdetails USING (ordernumber)
;

-- 출력값
-- 연도별 인당 매출액
-- YEAR 구매자수 매출액
SELECT 
	YEAR(orderdate) 연도별
    , COUNT(DISTINCT customernumber) 구매자수
    , SUM(priceEach * quantityOrdered) 매출액
    , SUM(priceEach * quantityOrdered) / COUNT(DISTINCT customernumber) 인당매출액
FROM orders
LEFT JOIN orderdetails USING(ordernumber)
GROUP BY 1
ORDER BY 1
;

SELECT 
	YEAR(orderdate) 연도별
    , COUNT(DISTINCT ordernumber) AS 구매건수
    , SUM(priceEach * quantityOrdered) AS 매출액
    , SUM(priceEach * quantityOrdered) / COUNT(DISTINCT ordernumber) AS 건당매출액
FROM orders
LEFT JOIN orderdetails USING(ordernumber)
GROUP BY 1
ORDER BY 1
;

-- 국가별, 도시별 매출액 
-- JOIN 2번 진행
SELECT 
	A.ordernumber
    , A.customernumber
    , B.priceeach
    , B.quantityordered
    , C.country
    , C.state
    , C.city
FROM
	orders A
LEFT JOIN orderdetails B
	ON A.ordernumber = B.ordernumber
LEFT JOIN customers C 
	ON A.customerNumber = C.customerNumber
;

-- 국가별 도시별 매출액 계산 
SELECT 
    C.country
    , C.city
    , SUM(B.priceeach * B.quantityordered) 매출액
FROM
	orders A
LEFT JOIN orderdetails B
	ON A.ordernumber = B.ordernumber
LEFT JOIN customers C 
	ON A.customerNumber = C.customerNumber
GROUP BY 1, 2
ORDER BY 1, 2
;

-- CASE WHEN : IF-ELSE 조건문
SELECT * FROM orderdetails;
SELECT
	ordernumber
    , quantityOrdered
    , CASE WHEN quantityOrdered > 30 THEN "주문건수 30개 초과"
	       WHEN quantityOrdered = 30 THEN "주문건수 30개"
           ELSE "30개 미만"
           ELSE "30개 미만"
	END AS 조건문
FROM 
	orderdetails
;

-- 문제 
-- customers table에서 country 컬럼 사용해서 북미와 비북미로 구분
-- 북미지역 : USA, CANADA / 그 외 : 나머지 
-- HINT : IN 연산자를 적절하게 사용 
SELECT 
	CASE WHEN country IN ("USA", "CANADA") THEN "북미지역"
    ELSE "비북미지역"
    END AS 지역구분
FROM customers
;

-- 북미지역 매출액과 비북미지역 매출액을 구하시오
SELECT
	CASE WHEN country IN ("USA", "CANADA") THEN "북미지역"
	ELSE "비북미지역" 
    END AS 지역구분
    , SUM(quantityOrdered * priceEach) AS 매출액
FROM
	orders A
LEFT JOIN orderdetails B
	ON A.ordernumber = B.ordernumber
LEFT JOIN customers C 
	ON A.customerNumber = C.customerNumber
GROUP BY 1
ORDER BY 1
;
