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