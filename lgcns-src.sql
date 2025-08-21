-- Day01

SHOW DATABASES;
USE inspire;
SHOW TABLES;

/*
SQL(Structure Query Language)

Select Query
DDL : create, drop, alter
DML : insert, update, delete
DCL : commit, rollback

select : 데이터를 검색할 때 사용하는 문법

select  column_name | * | 표현식 또는 함수를 포함하는 식 | [as] 별칭 | distinct column_name
from    table_name
[WHERE]     -- 행의 제한
[GROUP BY]  -- 데이터를 그룹으로 묶을 때
[HAVING]    -- 그룹에 대한 조건
[ORDER BY]  -- 정렬(내림차순 DESC, 오름차순 ASC)
*/

SELECT * FROM employee;

SELECT EMP_ID, EMP_NAME
FROM employee;

SELECT * FROM department;

SELECT * FROM employee
WHERE DEPT_ID = '90';

SELECT EMP_NAME,
		SALARY,
		(SALARY + (SALARY * IFNULL(BONUS_PCT, 0)))* 12 AS `연 봉`
FROM employee;

-- NULL 처리를 위한 함수 : IFNULL(EXP1, EXP2), NULLIF(EXP1, EXP2)
SELECT IFNULL(NULL, '넌 누구냐?'), NULLIF(100, 'NOT NULL');

-- distinct : 컬럼에 포함된 중복 값을 한 번씩만 출력하고자 할 때
SELECT DISTINCT DEPT_ID
FROM employee;

-- where
-- 연산자(비교(like, not like), 산술, 논리(and, or, not))


-- 부서번호가 90번이거나 급여가 4000,000 이상인 사원의 정보를 검색

SELECT * FROM employee
WHERE DEPT_ID = '90' OR SALARY >= 4000000;

-- CONCAT() : 연결 연산자
SELECT CONCAT('Today is ', 'Wednesday.');

SELECT CONCAT(EMP_NAME, '님의 급여는 ', SALARY,'원 입니다.') AS `급여정보(원)`
FROM employee;

-- 급여정보가 3500000 이상이고 5500000 이하인 사원의 정보를 검색
-- BETWEEN ~ AND
SELECT * FROM employee
WHERE SALARY >= 3500000 AND SALARY <= 5500000;

SELECT * FROM employee
WHERE SALARY BETWEEN 3500000 AND 5500000;

-- LIKE, NOT LIKE: 패턴 검색(%, _) 시 사용하는 연산자
-- % : 하나 이상의 문자와 매칭
-- _ : 하나의 문자를 매칭

-- 김씨 성을 가진 사원만 검색
SELECT * FROM employee
WHERE EMP_NAME LIKE '김%';

-- IS NULL, IS NOT NULL : 널 값은 = 비교할 수 없다.
-- 부서 배치를 받지 않는 사원 정보를 검색
SELECT * FROM employee
WHERE DEPT_ID IS NOT NULL;

-- 부서번호가 60번이거나 90번인 사원의 정보를 검색
SELECT * FROM employee
WHERE DEPT_ID IN (60, 90);

SELECT * FROM employee;

-- Day02 함수 : select, where
/*
- 프로그램에서 반복적으로 사용되는 부분을 분리해서 서브 프로그램

- 유형
단일행 함수 : 문자열, 날짜, 숫자, 기타변형 함수
복수형(그룹) 함수 : min, max, sum, count, avg


*/

SELECT *
FROM employee;

SELECT 	EMP_NAME, 
			CONCAT(EMP_NAME, '님'),
			LENGTH(EMP_NAME),
			CHAR_LENGTH(EMP_NAME)
FROM employee;

SELECT CHAR(65);

-- LOWER(), UPPER()

SELECT LOWER('HELLO'), UPPER('lgcns');

-- LPAD, RPAD : 자리수를 고정하여 빈 공간을 원하는 문자로 채우는 함수
SELECT EMAIL AS `원본 테이터`
		, LENGTH(EMAIL) `원본길이`
		, LPAD(EMAIL, 30)
		, RPAD(EMAIL, 30, '*')
		, LENGTH(LPAD(EMAIL, 30))
FROM employee;

-- ELT() : 인덱스를 이용해서 특정 위치의 문자를 찾는 함수
-- INSTR() : 문자열을 이용해서 부분 문자열을 찾는 함수

SELECT ELT(2, '1', '2', '3'), INSTR('hsuncho', 's');

SELECT EMAIL
FROM employee;

-- .앞의 문자 'c'의 인덱스 번지를 검색
SELECT INSTR(EMAIL, '.') -1 AS idx
FROM employee;

-- LEFT(), RIGHT()
SELECT LEFT('ABCDE', 3), RIGHT('ABCDE', 3);

-- SUBSTRING()
-- 부분문자열을 반환하는 함수
SELECT SUBSTRING('ABCDE', 1, 2);

SELECT SUBSTRING(EMAIL, INSTR(EMAIL, '.') - 1, 1)
FROM employee;

-- TRIM(), LTRIM(), RTRIM() : 제거(패턴을 제거하는 것은 아니다), 기본공백
SELECT LTRIM('   LGCNS')
		, RTRIM('LGCNS   ')
		, TRIM('   LGCNS   ');

SELECT TRIM(BOTH '123' FROM '123TECH123')
		,TRIM(LEADING '123' FROM '123TECH123')
		,TRIM(TRAILING '123' FROM '123TECH123');

-- 문자열 반복 : REPEAT();
SELECT REPEAT('LGCNS', 3);

-- 문자열 치환 : REPLACE();
SELECT REPLACE('오늘은 코스모스 졸업식 즐겨보자', '즐겨보자', '놀아보자' );

-- SUBSTRING(문자열, 시작 위치, 길이) OR (문자열 FROM 시작위치 FOR 길이)
-- SUBSTRING_INDEX(문자열, 구분자, 횟수)

SELECT SUBSTRING('THIS IS INSPIRE CAMP', 9, 7)
		, SUBSTRING('THIS IS INSPIRE CAMP' FROM 9 FOR 7);

SELECT SUBSTRING_INDEX('www.LGCNS.com', '.', -1);

/*
employee
1. 사원 이메일 중 아이디만 추출
2. 입사년도만 추출
3. 주민번호 앞 6자리만 추출
4. 입사일 출력 포맷을 XXXX년 XX월 XX일
*/

SELECT * FROM employee;

-- 1
SELECT EMAIL, SUBSTRING_INDEX(EMAIL,'@',1)
FROM employee;

SELECT EMAIL, SUBSTRING(EMAIL, 1, INSTR(EMAIL, '@')-1)
FROM employee;

-- 2
SELECT HIRE_DATE,
		SUBSTRING(HIRE_DATE, 1, 4),
		SUBSTRING_INDEX(HIRE_DATE,'-', 1)
FROM employee;
		
-- 3
SELECT EMP_NO,
		SUBSTRING(EMP_NO, 1, 6),
		SUBSTRING_INDEX(EMP_NO, '-', 1)
FROM employee;

-- 4
SELECT HIRE_DATE,
       CONCAT(
           SUBSTRING(HIRE_DATE, 1, 4), '년 ',
           SUBSTRING(HIRE_DATE, 6, 2), '월 ',
           SUBSTRING(HIRE_DATE, 9, 2), '일'
       )
FROM employee;

SELECT HIRE_DATE,
		CONCAT(
			SUBSTRING_INDEX(HIRE_DATE, '-', 1), '년 ',
			SUBSTRING_INDEX(
				SUBSTRING_INDEX(HIRE_DATE, '-', 2)
			, '-', -1), '월 ',
			SUBSTRING_INDEX(HIRE_DATE, '-', -1), '일'
		)
FROM employee;

SELECT HIRE_DATE, 
		DATE_FORMAT(HIRE_DATE, '%Y년 %m월 %d일')
FROM employee;

-- -------------------------------------

SELECT *
FROM usertbl;

SELECT *
FROM buytbl;

-- 평균 구매 개수를 확인하고 싶다면?
SELECT AVG(AMOUNT)
FROM buytbl;

SELECT CAST(AVG(AMOUNT) AS INT) AS `평균구매개수`
FROM buytbl;

-- ERROR
-- SELECT INT(AVG(AMOUNT)) AS `평균구매개수`
-- FROM buytbl;

SELECT '100' + '100';
SELECT CAST('100' AS INT) + CAST('100' AS INT);

SELECT CAST(AVG(AMOUNT) AS SIGNED INTEGER) AS `평균구매개수`
FROM buytbl;

-- 구매 번호, 총 금액 (PRICE * AMOUNT = ), 구매액 검색
SELECT NUM `구매번호`,
		CONCAT(
				CAST(PRICE AS VARCHAR(10)),
				' * ',
				CAST(AMOUNT AS VARCHAR(10))
		) AS `총금액`
		, PRICE * AMOUNT `구매액`
FROM buytbl;

SELECT NUM `구매번호`,
		CONCAT(
				PRICE,
				' * ',
				AMOUNT
		) AS `총금액`
		, PRICE * AMOUNT `구매액`
FROM buytbl;

SELECT LEFT(EMP_NO, 6),
		RIGHT(EMP_NO, 7)
		LEFT(EMP_NO, 6) + RIGHT(EMP_NO, 7)
FROM employee;



