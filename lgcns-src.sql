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
		RIGHT(EMP_NO, 7),
		LEFT(EMP_NO, 6) + RIGHT(EMP_NO, 7), 
		CAST( LEFT(EMP_NO, 6) AS INT) + CAST( RIGHT(EMP_NO, 7) AS INT)
FROM employee;

-- 숫자 함수
SELECT ABS(-100),
		CEILING(4.7),
		CEILING(4.1),
		FLOOR(4.7),
		FLOOR(4.1),
		ROUND(4.5),
		ROUND(4.4),
		TRUNCATE(123.1234567, 2),
		TRUNCATE(123.1234567, -2);
		
-- 날짜 함수
SELECT NOW(),
		SYSDATE(),
		CURDATE(),
		CURTIME();
		
-- 날짜 연산
-- ADDDATE(DATE, INTERVAL, EXPR TYPE), DATA_ADD();
-- SUBDATE()
-- TYPE: YEAR, MONTH, DAY
SELECT NOW() + 1;

SELECT CURDATE(),
		ADDDATE(CURDATE(), INTERVAL 1 MONTH),
		SUBDATE(CURDATE(), INTERVAL 1 MONTH),
		SYSDATE(),
		ADDTIME(SYSDATE(), '1:1:1'),
		SUBTIME(SYSDATE(), '2:0:0');

-- 오늘 날짜를 기준으로 근속년수가 25년 이상인 사원의 정보 검색
-- DATEDIFF()
SELECT DATEDIFF(CURDATE(), '2000-01-01') / 365;

SELECT *
FROM employee
WHERE HIRE_DATE <= DATE_SUB(CURDATE(), INTERVAL 25 YEAR);

SELECT 
    EMP_NAME,
    HIRE_DATE,
    FLOOR(DATEDIFF(CURDATE(), HIRE_DATE) / 365) AS `근속년수`
FROM employee
WHERE DATEDIFF(CURDATE(), HIRE_DATE) >= (25 * 365);

-- YEAR(), MONTH(), DAY(), HOUR(), MINUTE(), SECOND()
SELECT CAST(YEAR(HIRE_DATE) AS CHAR),
		CAST(MONTH(HIRE_DATE) AS CHAR),
		CAST(DAY(HIRE_DATE) AS CHAR)
FROM employee;

-- 기타 변형 함수
-- 제어 흐름 함수(IF, IFNULL, NULLIF, CASE ~ WHEN ~ END)

SELECT IF(100 > 200 , '참', '거짓');

SELECT 	CASE 1
				WHEN 1 THEN '1'
				WHEN 10 THEN '10'
				ELSE '내가 원하는 값이 아님'
			END AS `구분`;


-- 부서번호가 50번인 사원의 이름, 주민번호, 성별을 검색
SELECT EMP_NAME,
		EMP_NO,
		CASE SUBSTRING(EMP_NO, 8, 1)
			WHEN '1' OR '3' THEN 'MALE'
			WHEN '2' OR '4' THEN 'FEMALE'
		END AS `GENDER`
FROM employee
WHERE DEPT_ID = '50';

SELECT EMP_NAME,
		EMP_NO,
		CASE 
			WHEN SUBSTRING(EMP_NO, 8, 1) IN ('1','3') THEN 'MALE'
			WHEN SUBSTRING(EMP_NO, 8, 1) IN ('2','4') THEN 'FEMALE'
		END AS `GENDER`
FROM employee
WHERE DEPT_ID = '50';

-- 사원 테이블에서 남자 사원의 이름, 주민번호, 성별을 검색

SELECT EMP_NAME,
		EMP_NO,
		CASE 
			WHEN SUBSTRING(EMP_NO, 8, 1) IN ('1','3') THEN 'MALE'
			WHEN SUBSTRING(EMP_NO, 8, 1) IN ('2','4') THEN 'FEMALE'
		END AS `GENDER`
FROM employee
WHERE SUBSTRING(EMP_NO, 8, 1) IN ('1','3');

SELECT 
    EMP_NAME,
    EMP_NO,
    'MALE' AS GENDER
FROM employee
WHERE SUBSTRING(EMP_NO, 8, 1) IN ('1','3');

SELECT *
FROM department;

SELECT *
FROM job;

-- 사원테이블에서 직급이 J4인 사원의 사번, 이름, 사수 번호
-- 사수번호가 없는 사원의 MGR_ID 컬럼에 '관리자' 넣어주고 싶다면
/*
NULL
- 값이 없음
EMPTY STRING('')
- 길이가 0 문자열
*/

SELECT EMP_NO,
		EMP_NAME,
		MGR_ID
FROM employee
WHERE JOB_ID = 'J4';

SELECT 
    EMP_NO,
    EMP_NAME,
    IFNULL(NULLIF(MGR_ID, ''), '관리자') AS MGR_ID
FROM employee
WHERE JOB_ID = 'J4';

SELECT 
    EMP_NO,
    EMP_NAME,
    IFNULL(NULLIF(MGR_ID, ''), '관리자') AS MGR_ID
FROM employee
WHERE JOB_ID = 'J4';

SELECT 
    EMP_NO,
    EMP_NAME,
    IF(MGR_ID = '', '관리자', MGR_ID) AS MGR_ID
FROM employee
WHERE JOB_ID = 'J4';

SELECT 
    EMP_NO,
    EMP_NAME,
    CASE
		WHEN MGR_ID = '' THEN '관리자'
		ELSE MGR_ID
	END AS MGR_ID
FROM employee
WHERE JOB_ID = 'J4';

-- 사원의 급여 등급을 나누고자 한다
-- 3000000 이하면 초급, 4000000 이하면 중급, 초과면 고급

SELECT EMP_NO,
		EMP_NAME,
		SALARY,
		CASE
			WHEN SALARY <= 3000000 THEN '초급'
			WHEN SALARY <= 4000000 THEN '중급'
			ELSE '고급'
		END AS `급여등급`
FROM employee
ORDER BY `급여등급` ASC;

-- 복수행(그룹, 집계) 함수 : 여러 행의 결과를 입력으로 하나의 결과를 반환하는 함수
SELECT COUNT(*), 
		COUNT(BONUS_PCT),
		COUNT(IFNULL(BONUS_PCT, 0)),
		MIN(SALARY),
		MAX(SALARY),
		SUM(SALARY),
		AVG(SALARY)
FROM employee;

-- WEEKDAY(): 날짜의 요일을 정수로 변환(0 - 월)
-- DAYOFWEEK(): 요일을 숫자로 변환 (1 : 일요일)

SELECT WEEKDAY(CURDATE()),
			DAYOFWEEK(CURDATE());

-- GROUP BY : 하위 데이터의 그룹
-- 특정 컬럼에 대해 동일한 값을 가지는 행들을 하나의 행으로 처리
-- 통계 작업

SELECT *
FROM buytbl;

-- 사용자별 구매 총액

SELECT USERID,
		SUM(PRICE * AMOUNT)
FROM buytbl
GROUP BY USERID
ORDER BY 2 DESC;

-- 사용자별 평균 구매 개수
SELECT USERID,
		AVG(AMOUNT)
FROM buytbl
GROUP BY USERID
ORDER BY 2 DESC;

SELECT *
FROM employee;

-- 부서별 평균 급여
SELECT 
    DEPT_ID AS `부서`,
    AVG(SALARY) AS `평균급여`
FROM employee
GROUP BY DEPT_ID
ORDER BY `평균급여` DESC;

-- 성별에 따른 평균 급여
SELECT 
    CASE 
        WHEN SUBSTRING(EMP_NO, 8, 1) IN ('1','3') THEN '남성'
        WHEN SUBSTRING(EMP_NO, 8, 1) IN ('2','4') THEN '여성'
    END AS `성별`,
    ROUND(AVG(SALARY)) AS `급여 평균`
FROM employee
GROUP BY CASE 
    WHEN SUBSTRING(EMP_NO, 8, 1) IN ('1','3') THEN '남성'
    WHEN SUBSTRING(EMP_NO, 8, 1) IN ('2','4') THEN '여성'
END
ORDER BY `급여 평균` DESC;

-- 부서별 급여 총액이 9000000 이상인 부서
SELECT DEPT_ID AS `부서`,
		SUM(SALARY) AS `급여 총합`
FROM employee
GROUP BY DEPT_ID
HAVING SUM(SALARY) >= 9000000
ORDER BY 1;

SELECT * FROM buytbl;

-- buytbl에서 사용자별 총 구매액이 100 이상인 사용자들만 필터링
SELECT USERID,
		SUM(PRICE * AMOUNT) AS `총 구매액`
FROM buytbl
GROUP BY USERID
HAVING SUM(PRICE * AMOUNT) >= 100;

-- GROUP BY 확장 기능 : 계층적인 집계 결과 WITH ROLLUP
-- 구매한 목록 중 그룹이름별 구매비용을 검색

SELECT *
FROM buytbl;

SELECT GROUPNAME, NUM,
		SUM(PRICE * AMOUNT) AS `구매비용`
FROM buytbl
GROUP BY GROUPNAME, NUM WITH ROLLUP;

SELECT GROUPNAME, NUM,
		SUM(PRICE * AMOUNT) AS `구매비용`
FROM buytbl
GROUP BY ROLLUP(GROUPNAME, NUM);

-- JOIN : n개 이상의 테이블을 서로 묶어서 하나의 결과 집합을 만들어내는 것
-- 관계형 데이터베이스의 가장 큰 특징
-- 테이블 관계 (1:N, 1:1)

/*
ANSI 표준 구문

SELECT
FROM TABLE01 ALIAS
[INNER] JOIN TABLE02 ALIAS ON(조건식)
[INNER} JOIN TABLE02 ALIAS USING(컬럼명)
*/

SELECT E.EMP_NAME,
		D.DEPT_NAME,
		E.DEPT_ID
FROM department D
JOIN employee E
USING(DEPT_ID);

SELECT E.EMP_NAME,
		D.DEPT_NAME,
		L.LOC_DESCRIBE
FROM department D
JOIN employee E USING(DEPT_ID)
JOIN location L ON(L.LOCATION_ID = D.LOC_ID)
WHERE DEPT_NAME LIKE '해외%';

-- 사용자가 JYP인 유저의 이름과 구매상품
SELECT USERID, 
		PRODNAME
FROM usertbl
JOIN buytbl USING(USERID)
WHERE USERID = 'JYP';

-- 사용자 아이디, 이름, 구매상품, 연락처(MOBILE1+MOBILE2)
SELECT u.USERID,
       u.NAME,
       b.PRODNAME,
       CONCAT(u.MOBILE1, u.MOBILE2)
FROM usertbl u
JOIN buytbl b USING(USERID);

-- 위 요구사항에서 구매이력이 있는 회원만 조회
SELECT u.USERID,
       u.NAME,
       CONCAT(u.MOBILE1, u.MOBILE2)
FROM usertbl u
WHERE EXISTS(SELECT *
				FROM buytbl b
				WHERE u.userID = b.userID);

-- 업무적인 연관성이 없는 테이블도 조인이 가능하다(ON 구문으로)
-- 이름, 급여, 급여등급을 검색한다면?

SELECT
		e.EMP_NAME AS 이름,
       e.SALARY AS 급여,
       s.slevel AS 급여등급
FROM employee e
JOIN sal_grade s
  ON e.SALARY BETWEEN s.lowest AND s.highest;

-- OUTER JOIN (LEFT | RIGHT)
-- 조인의 조건에 만족하지 않는 모든 행을 조회

SELECT *
FROM department D
RIGHT JOIN employee E ON(D.DEPT_ID = E.DEPT_ID);

-- 부서배치를 받지 않은 사원의 이름, 부서명을 조회
SELECT e.EMP_NAME,
		d.DEPT_NAME
FROM employee e
LEFT JOIN department d ON(e.DEPT_ID = d.DEPT_ID)
WHERE e.DEPT_ID IS NULL ;

SELECT EMP_NAME,
		DEPT_NAME
FROM department D
RIGHT JOIN employee E ON(e.DEPT_ID = D.DEPT_ID)
WHERE D.DEPT_ID IS NULL;

-- 사원의 이름과 사수의 이름 검색
SELECT e.EMP_NAME `사원명`,
			m.EMP_NAME `사수명`,
			s.EMP_NAME `최고사수`
FROM employee e
LEFT JOIN employee m
	ON e.MGR_ID = m.EMP_ID
LEFT JOIN employee s
	ON m.MGR_ID = s.EMP_ID;

-- 직급이 대리이고 지역이 아시아로 시작하는 사원정보

SELECT e.EMP_NAME,
       j.JOB_TITLE,
       d.DEPT_NAME,
       l.LOC_DESCRIBE,
       c.COUNTRY_NAME,
       s.SLEVEL
FROM employee e
LEFT JOIN department d
    ON e.DEPT_ID = d.DEPT_ID
LEFT JOIN location l
    ON d.LOC_ID = l.LOCATION_ID
LEFT JOIN country c
    ON l.COUNTRY_ID = c.COUNTRY_ID
LEFT JOIN job j
    ON e.JOB_ID = j.job_id
JOIN sal_grade s
    ON e.SALARY BETWEEN s.LOWEST AND s.HIGHEST
WHERE j.JOB_TITLE = '대리'
  AND l.LOC_DESCRIBE LIKE '아시아%';
  
-- DAY04 SUBQUERY & DDL(데이터 정의어)
-- SUBQUERY : 하나의 쿼리가 다른 쿼리를 포함하는 구조
-- 유형 : 단일행(단일열, 다중열), 다중행(단일열, 다중열)
-- where, having 절 (subquery), select 절(scalar subquery), from 절(inline view)

SELECT STUDENT_NAME 
FROM tb_student
WHERE ABSENCE_YN = 'Y' 
AND DEPARTMENT_NO = (
	SELECT DEPARTMENT_NO 
	FROM tb_department 
	WHERE DEPARTMENT_NAME = '국어국문학과'
)
AND STUDENT_SSN LIKE '%-2%';

-- 나승원 사원과 같은 부서원을 검색
SELECT *
FROM employee
WHERE DEPT_ID = (SELECT DEPT_ID
						FROM employee
						WHERE EMP_NAME = '나승원');

-- 부서별 급여 총합
-- 부서별 급여 총합이 가장 높은 부서만 확인
SELECT D.DEPT_NAME,
		SUM(SALARY) AS `TOTAL`
FROM employee E
JOIN department D ON(E.DEPT_ID = D.DEPT_ID)
GROUP BY D.DEPT_ID
HAVING SUM(SALARY) = ( SELECT MAX(TOTAL)
								FROM ( SELECT DEPT_ID,
											SUM(SALARY) AS `TOTAL`
											FROM employee E
											GROUP BY DEPT_ID
										) T
							);

SELECT D.DEPT_NAME, V.TOTAL
FROM (
    SELECT DEPT_ID, SUM(SALARY) AS TOTAL
    FROM employee
    GROUP BY DEPT_ID
) V
JOIN department D ON V.DEPT_ID = D.DEPT_ID
WHERE V.TOTAL = (
    SELECT MAX(TOTAL)
    FROM (
        SELECT SUM(SALARY) AS TOTAL
        FROM employee
        GROUP BY DEPT_ID
    ) X
);

-- LIMIT 절 == TOP - N QUERY
-- 사용하기 전 반드시 정렬
EXPLAIN
SELECT D.DEPT_NAME, SUM(E.SALARY) AS TOTAL
FROM employee E
JOIN department D ON E.DEPT_ID = D.DEPT_ID
GROUP BY D.DEPT_NAME
ORDER BY TOTAL DESC
LIMIT 1;

-- M+1번지부터 N개를 가져온다
SELECT D.DEPT_NAME, SUM(E.SALARY) AS TOTAL
FROM employee E
JOIN department D ON E.DEPT_ID = D.DEPT_ID
GROUP BY D.DEPT_NAME
ORDER BY TOTAL DESC
LIMIT 2 OFFSET 1;

-- 최소 급여 확인
SELECT DEPT_ID, MIN(SALARY)
FROM employee
GROUP BY DEPT_ID;

-- 다중열 서브쿼리가 필요한 이유
-- 부서별 최소 급여를 받는 사원정보를 검색
SELECT *
FROM employee
WHERE (DEPT_ID, SALARY) IN (	SELECT DEPT_ID, MIN(SALARY)
										FROM employee
										GROUP BY DEPT_ID);


-- 과장직급의 급여
SELECT SALARY
FROM employee E
JOIN job J 
ON (E.JOB_ID = J.JOB_ID)
WHERE JOB_TITLE = '과장';

-- 대리 직급의 급여
SELECT SALARY
FROM employee E
JOIN job J 
ON (E.JOB_ID = J.JOB_ID)
WHERE JOB_TITLE = '대리';

-- 다중행 서브쿼리일 경우 사용할 수 있는 연산자(IN, ANY, ALL)
/*
> ANY, < ANY
> ALL, < ALL

*/

-- 단일행 서브쿼리는 일반연산자 사용 가능

-- 과장 직급보다 많은 급여를 받는 대리직급 사원의 정보를 검색
SELECT EMP_NAME,
		SALARY
FROM employee E
JOIN job J 
ON (E.JOB_ID = J.JOB_ID)
WHERE JOB_TITLE = '대리'
AND SALARY > ANY (SELECT SALARY
						FROM employee E
						JOIN job J 
						ON (E.JOB_ID = J.JOB_ID)
						WHERE JOB_TITLE = '과장');

-- DDL(DATA DEFINITION LANGUAGE) : CREATE, DROP, ALTER
-- TABLE (CONSTRAINT) : NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK
-- VIEW : 읽기 전용(권한, 복잡한 질의어를 단순)
/*
CREATE TABLE TABLE_NAME(
	COLUMN_NAME DATATYPE [DEFAULT EXPR] [COLUMN CONSTRAINT],
	[TABLE CONSTRAINT]
*/

-- DML (DATA MANIPULATION LANGUAGE) : INSERT, UPDATE, DELETE

DROP TABLE IF EXISTS TABLE_NAME;

CREATE TABLE DUMMY_TBL (
	USER_ID VARCHAR(50) PRIMARY KEY, -- COLUMN LEVEL CONSTRAINT
	USER_NAME VARCHAR(50) NOT NULL,
	BIRTH_YEAR DATE DEFAULT SYSDATE(),
	ADDRESS VARCHAR(50),
	MOBILE01 CHAR(3),
	MOBILE02 CHAR(9),
	HEIGHT INT,
	PRIMARY KEY(컬럼명) -- TABLE LEVEL CONSTRAINT
	
);

DROP TABLE IF EXISTS JOB_TBL;
CREATE TABLE JOB_TBL (
	JOB_ID CHAR(3),
	JOB_TITLE VARCHAR(100),
	PRIMARY KEY(JOB_ID)
);

SELECT *
FROM job_tbl;

INSERT INTO JOB_TBL(JOB_ID, JOB_TITLE) VALUES
('J1', '대표이사'),
('J2', '부장'),
('J3', '차장');

INSERT INTO JOB_TBL(JOB_ID, JOB_TITLE) VALUES ('J4', '대리');
INSERT INTO JOB_TBL(JOB_ID, JOB_TITLE) VALUES ('J5', '사원');

DROP TABLE IF EXISTS DEPT_TBL;
CREATE TABLE DEPT_TBL (
	DEPT_ID CHAR(2) PRIMARY KEY,
	DEPT_NAME VARCHAR(100) NOT NULL
);

SELECT *
FROM dept_tbl;

INSERT INTO dept_tbl(DEPT_ID, DEPT_NAME) VALUES
('10', '교육팀'),
('20', '영업팀'),
('30', '힐링팀'),
('40', '레크팀');

-- ERROR
-- INSERT INTO dept_tbl(DEPT_ID, DEPT_NAME) VALUES ('50', NULL);

-- 외래키 옵션 : 참조무결성 관련 옵션
-- ON DELETE CASCADE, ON DELETE SET NULL, ON UPDATE CASCADE

DROP TABLE IF EXISTS EMP_TBL;
CREATE TABLE EMP_TBL(
	EMP_ID VARCHAR(20) PRIMARY KEY,
	EMP_NAME VARCHAR(50) NOT NULL,
	SALARY INT CHECK(SALARY > 0),
	GENDER CHAR(1) CHECK(GENDER IN ('F', 'M')),
	JOB_ID CHAR(3) NOT NULL,
	DEPT_ID CHAR(2) NOT NULL,
	FOREIGN KEY (JOB_ID) REFERENCES job_tbl,
	FOREIGN KEY (DEPT_ID) REFERENCES dept_tbl
);

SELECT * 
FROM emp_tbl;

SELECT *
FROM job_tbl
WHERE TRIM(JOB_ID) = 'J1';

-- ERROR NOT NULL
-- INSERT INTO emp_tbl
-- VALUES('100', '김철수', 0, 'F', NULL, NULL);

-- ERROR CHECK
-- INSERT INTO emp_tbl
-- VALUES('100', '김철수', 0, 'F', 'J1', '10');

-- ci : 대소문자 구별 x
-- cs : 대소문자 구별 O
INSERT INTO emp_tbl
VALUES('100', '김철수', 100, 'f', 'J1', '10');

-- ERROR CHECK
-- INSERT INTO emp_tbl
-- VALUES('100', '김철수', 100, '?', 'J1', '10');

-- ERROR
-- INSERT INTO emp_tbl
-- VALUES('200', '김철수', 100, 'F', 'J6', '50');

INSERT INTO emp_tbl
VALUES('200', '김철수', 100, 'F', 'J5', '40');



