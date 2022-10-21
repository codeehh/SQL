USE sample;

SELECT * FROM sample21;
DESC sample21;
SELECT no, name FROM sample21;
SELECT * FROM sample21 WHERE no = 2;
SELECT * FROM sample21 WHERE no <> 2;
SELECT * FROM sample21 WHERE name = '박준용';
SELECT * FROM sample21 WHERE birthday IS NULL;
SELECT * FROM sample21 WHERE birthday IS NOT NULL;

SELECT * FROM sample24;
SELECT * FROM sample24 WHERE a <> 0 AND b <> 0;
SELECT * FROM sample24 WHERE a <> 0 OR b <> 0;
SELECT * FROM sample24 WHERE (a = 1 OR a = 2) AND (b = 1 OR b = 2); -- AND가 OR보다 우선순위가 높다
SELECT * FROM sample24 WHERE NOT(a <> 0 OR b <> 0);

SELECT * FROM sample25;
SELECT * FROM sample25 WHERE text LIKE 'SQL%'; -- % : 임의의 문자열, _ : 임의의 문자 하나
SELECT * FROM sample25 WHERE text LIKE '%SQL%';
SELECT * FROM sample25 WHERE text LIKE '%\%%'; -- 이스케이프

SELECT * FROM sample31;
SELECT * FROM sample31 ORDER BY age;
SELECT * FROM sample31 ORDER BY address;
SELECT * FROM sample31 ORDER BY age DESC; -- 내림차순
SELECT * FROM sample31 ORDER BY age ASC; -- 오름차순(default)

SELECT * FROM sample311;
DESC sample311;
SELECT * FROM sample311 ORDER BY a; -- 문자열로 숫자를 저장했을때 정렬 주의

SELECT * FROM sample32;
SELECT * FROM sample32 ORDER BY a, b;
SELECT * FROM sample32 ORDER BY b, a;
SELECT * FROM sample32 ORDER BY a ASC, b DESC; -- 데이터베이스 제품에 따라 기본값이 달라질 수 있고 가독성을 위해서라도 명시해주자
-- NULL 값의 정렬 순서도 데이터베이스 제품에 따라 다르다(가장 먼저 OR 가장 나중에)

SELECT * from sample33;
SELECT * from sample33 LIMIT 3;
SELECT * FROM sample33 ORDER BY no DESC LIMIT 3;
SELECT * FROM sample33 LIMIT 3 OFFSET 0;
SELECT * FROM sample33 LIMIT 3 OFFSET 3;
SELECT * FROM sample33 LIMIT 3 OFFSET 6;

SELECT * FROM sample34;
SELECT *, price * quantity FROM sample34;
SELECT *, price * quantity AS amount FROM sample34; -- AS 생략 가능
SELECT *, price * quantity AS amount FROM sample34 WHERE price * quantity >= 2000;
-- NULL로 연산하면 결과는 NULL이 된다

SELECT *, price * quantity AS amount FROM sample34 ORDER BY price * quantity DESC;
SELECT *, price * quantity AS amount FROM sample34 ORDER BY amount DESC;
-- 서버에서 내부처리 순서 : WHERE 구 -> SELECT 구 -> ORDER BY 구
-- 따라서 WHERE에서는 amount를 사용할 수 없고 ORDER BY에서는 사용할 수 있다

SELECT * FROM sample341;
SELECT amount, round(amount) FROM sample341;
SELECT amount, round(amount, 1) FROM sample341;
SELECT amount, round(amount, -2) FROM sample341;

SELECT * FROM sample35;
SELECT concat(quantity, unit) FROM sample35;
SELECT substring('20140125001', 1, 4);
SELECT substring('20140125001', 5, 2);
SELECT trim('   ABC   ');
SELECT char_length('ABCDE');

SELECT current_timestamp();
SELECT current_date() + INTERVAL 1 DAY;
SELECT datediff('2014-02-28', '2014-01-01');

SELECT * FROM sample37;
SELECT a, CASE WHEN a IS NULL THEN 0 ELSE a END "a(null=0)" FROM sample37;
SELECT a, coalesce(a, 0) from sample37;
SELECT a AS "코드",
CASE
	WHEN a = 1 THEN '남자'
    WHEN a = 2 THEN '여자'
    ELSE '미지정'
END AS "성별" FROM sample37;
SELECT a AS "코드",
CASE a
	WHEN 1 THEN '남자'
    WHEN 2 THEN '여자'
    ELSE '미지정'
END AS "성별" FROM sample37;
SELECT a AS "코드",
CASE
	WHEN a = 1 THEN '남자'
    WHEN a = 2 THEN '여자'
    WHEN a IS NULL THEN '데이터 없음'
    ELSE '미지정'
END AS "성별" FROM sample37;

SELECT * FROM sample41;
DESC sample41;
INSERT INTO sample41 VALUES(1, 'ABC', '2014-01-25');
INSERT INTO sample41(a, no) VALUES('XYZ', 2);
INSERT INTO sample41(no, a, b) VALUES(NULL, NULL, NULL); -- no column이 NOT NULL이라 에러
INSERT INTO sample41(no, a, b) VALUES(3, NULL, NULL);

SELECT * FROM sample411;
DESC sample411;
INSERT INTO sample411(no, d) VALUES(1, 1);
INSERT INTO sample411(no, d) VALUES(2, DEFAULT);
INSERT INTO sample411(no) VALUES(3);

SELECT * FROM sample41;
set SQL_SAFE_UPDATES = 0; -- safe mode 해제
DELETE FROM sample41 WHERE no = 3;
UPDATE sample41 SET b = '2014-09-07' WHERE no = 2;
UPDATE sample41 SET no = no + 1;
UPDATE sample41 SET a = 'xxx', b = '2014-01-01' WHERE no = 2;
UPDATE sample41 SET a = NULL;
set SQL_SAFE_UPDATES = 1; -- safe mode 설정

SELECT * FROM sample51;
SELECT count(*) FROM sample51;
SELECT * FROM sample51 WHERE name = 'A';
SELECT count(*) FROM sample51 WHERE name = 'A';
SELECT count(no), count(name) FROM sample51;
SELECT ALL name FROM sample51;
SELECT DISTINCT name FROM sample51;
SELECT count(ALL name), count(DISTINCT name) FROM sample51;

SELECT * FROM sample51;
SELECT sum(quantity) FROM sample51;
SELECT avg(quantity), sum(quantity)/count(quantity) FROM sample51; -- NULL 미포함
SELECT avg(CASE WHEN quantity IS NULL THEN 0 ELSE quantity END) AS avgnull0 FROM sample51; -- NULL을 0으로 계산

SELECT * FROM sample51;
SELECT name FROM sample51 GROUP BY name;
SELECT name, count(name), sum(quantity) FROM sample51 GROUP BY name;
SELECT name, count(name), sum(quantity) FROM sample51 GROUP BY name HAVING count(name) = 1;
SELECT name, count(name), sum(quantity) FROM sample51 GROUP BY name ORDER BY sum(quantity) DESC;
-- 서버에서 내부처리 순서 : WHERE 구 -> GROUP BY 구 -> HAVING 구 -> SELECT 구 -> ORDER BY 구

SELECT * FROM sample54;
SELECT min(a) FROM sample54;
set SQL_SAFE_UPDATES = 0; -- safe mode 해제
DELETE FROM sample54 WHERE a = (SELECT min(a) FROM sample54); -- mysql에서는 실행 안됨
SET @a = (SELECT min(a) FROM sample54);
DELETE FROM sample54 WHERE a = @a;
set SQL_SAFE_UPDATES = 1; -- safe mode 설정

-- 서브쿼리의 패턴
SELECT min(a) FROM sample54; -- 1. 하나의 값(스칼라)
SELECT no FROM sample54; -- 2. 복수의 행, 하나의 열
SELECT min(a), max(no) FROM sample54; -- 3. 하나의 행, 복수의 열
SELECT no, a FROM sample54; -- 4. 복수의 행, 복수의 열
-- 하나의 값(스칼라)가 서브쿼리로 사용하기 쉽다

SELECT
	(SELECT count(*) FROM sample51) AS sq1,
    (SELECT count(*) FROM sample54) AS sq2;
set SQL_SAFE_UPDATES = 0; -- safe mode 해제
UPDATE sample54 SET a = (SELECT max(a) FROM sample54); -- mysql에서는 실행 안됨
SET @a = (SELECT max(a) FROM sample54);
UPDATE sample54 SET a = @a;
set SQL_SAFE_UPDATES = 1; -- safe mode 설정

SELECT * FROM sample541;
INSERT INTO sample541 VALUES (
	(SELECT count(*) FROM sample51),
    (SELECT count(*) FROM sample54)
);
INSERT INTO sample541 SELECT 1, 2;

SELECT * FROM sample542;
SELECT * FROM sample543;
INSERT INTO sample542 SELECT * FROM sample543; -- 열 구성이 똑같은 테이블 사이에 행을 복사하는 것
-- sample542, sample543이 없다

SELECT * FROM sample551;
SELECT * FROM sample552;
set SQL_SAFE_UPDATES = 0; -- safe mode 해제
UPDATE sample551 SET a = '있음' WHERE EXISTS (SELECT * FROM sample552 WHERE sample552.no2 = sample551.no);
UPDATE sample551 SET a = '없음' WHERE NOT EXISTS (SELECT * FROM sample552 WHERE sample552.no2 = sample551.no);
set SQL_SAFE_UPDATES = 1; -- safe mode 설정

SELECT * FROM sample551 WHERE no IN (3, 5);
SELECT * FROM sample551 WHERE no IN (SELECT no2 FROM sample552);