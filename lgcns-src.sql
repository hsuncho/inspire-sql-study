SHOW DATABASES;
USE inspire;
SHOW TABLES;

/*
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


