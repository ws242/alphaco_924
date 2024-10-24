/*
여러 줄 주석
*/

-- 한 줄 주석

-- 간단 체크 
SELECT * FROM classicmodels.employees;

-- 데이터베이스 선언
USE classicmodels;
SELECT * FROM employees;

USE dataset2; -- 데이터베이스명
SELECT * FROM dataset2; -- 테이블명

-- dataset 폴더 ==> dataset2
-- 데이터베이스명 : instacart, 모든 폴더 가져오기 
-- 데이터베이스명 : titanic, full.csv == > 파일명 titanic으로 변경 후 불러오기

-- SQL 기본문법
/*
SELECT 컬럼
FROM 테이블명
WHERE 조건절
GROUP BY 범주 컬럼
HAVING 그룹바이 이후 조건절 (GROUP BY 없이는 사용 불가)
ORDER BY 값 정렬
*/ 

DESC employees; -- 기본적인 정보 제공

-- lastName만 출력하자 
SELECT lastName FROM employees;

-- 추천 형식
SELECT
	lastName        -- 주석
    , firstName     -- 주석
    , jobTitle      -- 주석   / 코드 가독성을 위해 쉼표를 앞에 쓰는게 좋음 
FROM 
	employees
;

-- SELECT만 사용 without Table
-- 파이썬 코드 예시 : print(1+1)
-- Alias 
SELECT 1+1 AS 결과;

-- 문자열 처리 메서드 중의 하나 
SELECT RTRIM('barbar     ');   -- 공백을 없애주는

-- 현재 날짜 구하기
SELECT NOW();
SELECT CURDATE();

-- 글자 이어 붙이는 함수
SELECT CONCAT('evan', ' ', 'jung') AS name;

-- ORDER BY : 컬럼 정렬 함수 
-- 인식 순서 : FROM ==> SELECT ==> ORDER BY
DESC customers;

SELECT
	salesRepEmployeeNumber
    , contactLastName
    , contactFirstName
FROM
	customers
ORDER BY
	salesRepEmployeeNumber ASC -- 오름차순(기본값) / DESC 내림차순
    , contactLastName ASC
;

-- WHERE 
-- FROME ==> WHERE ==> SELECT ==> ORDER BY
SELECT
	lastName
    , firstName
    , jobtitle AS 직급
FROM
	employees
WHERE
	jobtitle = 'Sales Rep'
;
    
-- AND  => 시험 나옴 
SELECT
	lastName
    , firstName
    , jobtitle AS 직급
    , officeCode
FROM
	employees
WHERE
	jobtitle = 'Sales Rep' AND
    officeCode = 1
;

-- OR  => 시험 나옴 
SELECT
	lastName
    , firstName
    , jobtitle AS 직급
    , officeCode
FROM
	employees
WHERE
	jobtitle = 'Sales Rep' OR
    officeCode = 1
;

-- AND 와 OR의 차이점 : AND - 교집합, OR - 합집합

-- BETWEEN 연산자
SELECT 
	firstName
    , lastName
    , officeCode
FROM
	employees
WHERE
	officeCode BETWEEN 1 AND 3
;

-- LIKE 연산자 : 문자 컬럼을 조회 할 때 자주 사용함
-- 패턴 조회, %, _ : wildcard
-- % : any string, 위치에 상관 없음, 1개 또는 그 이상 매칭
-- _ : single character, 1개만 매칭

-- firstName에서 a로 시작하는 이름만 조회
SELECT 
	employeeNumber
    , lastName
    , firstName
FROM 
	employees
WHERE
	firstName Like 'a%' -- '%a', '%a%'
;

-- _ : underscore 예시 / 글자수 만큼 _ 써야 함 
SELECT 
	employeeNumber
    , lastName
    , firstName
FROM 
	employees
WHERE
	firstName LIKE 'a__y';
;

-- NOT LIKE : LIKE가 아닌 것 
SELECT 
	employeeNumber
    , lastName
    , firstName 
From 
	employees
WHERE
	firstName NOT LIKE 'a__y'
;

-- LIKE ESCAPE ==> 나중에

-- IN 연산자
-- 컬럼명 IN (값1, 값2, 값3)
SELECT
	firstName
    , lastName
    , officeCode
FROM 
	employees
WHERE
	officeCode IN (1,2,3)
;

-- AND 또는 OR 연산자를 사용해서 결과가 동일하게 나오도록 만들어보세요
SELECT
	firstName
    , lastName
    , officeCode
FROM 
	employees
WHERE
	officeCode = 1 OR officeCode = 2 or officeCode = 3
;

-- IS NULL 연산자 : 결측치를 조회하는 연산자
SELECT
	employeeNumber
	, lastName
    , firstName
    , reportsTo
FROM employees
WHERE 
	reportsTo IS NULL -- reportsTo 컬럼에서 NULL 있는 값만 조회
;

-- DB 주요 명령어
USE classicmodels;
SELECT database();

SHOW TABLES;

-- WHERE 조건문
SELECT
	lastName
    , firstname
    , jobtitle
From
	employees
WHERE jobtitle != 'Sales Rep' -- !=, <> : Not Equal
;

-- DISTINCT ( 순서 중요! ) : 중복값 제거 
-- FROM ==> WHERE ==> SELECT ==> DISTINCT ==> ORDER BY
SELECT 
	DISTINCT lastname
FROM
	employees
ORDER BY
	lastname
;

-- DISTINCT & NULL 값 사용
-- NULL 값도 중복값으로 인지해서 처리함 
SELECT 
	DISTINCT state
FROM
	customers
ORDER BY
	state
;

-- state, city 조회
-- 테이블명 : customers
DESC customers;
SELECT DISTINCT
	state
    , city
FROM
	customers
WHERE
	state IS NOT NULL  -- 널값이 아닌 것만 조회하겠다. 
ORDER BY
	state
    , city
;

-- 집계 함수 
-- 테이블명 : products
DESC products;
SELECT * FROM products;

-- AVG : 평균
-- buyPrice의 평균값을 구하세요
SELECT
	AVG(buyPrice) as 구매평균가격
FROM 
	products
;

-- GROUP BY
SELECT 
	productLine  -- 범주 칼럼이 반드시 입력되어야 함
    , AVG(buyPrice) AS 구매평균가격
FROM
	products
GROUP BY productLine
ORDER BY 구매평균가격 DESC   -- 오라클에서는 작동 안됨 ( 문법차이 ) 
						  -- 엄밀히 말하면 ORDER BY AVG(buyPrice) 라고 써야 함 
;

SELECT 
	productLine -- 범주 컬럼이 반드시 입력되어야 함
    -- 코드를 길게 작성해서 범주를 뽑음
    -- 예를 들면, 월별로 집계하고 싶음
    , AVG(buyPrice) AS 구매평균가격
FROM 
	products
GROUP BY 1
ORDER BY 1
;