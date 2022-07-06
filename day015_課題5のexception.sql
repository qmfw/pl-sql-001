CREATE TABLE rate_mst (
	month NUMBER, rate NUMBER
);

INSERT INTO rate_mst VALUES (1,	101.5);
INSERT INTO rate_mst VALUES (2,	102.8);
INSERT INTO rate_mst VALUES (3,	98.4);
INSERT INTO rate_mst VALUES (4,	100.3);
INSERT INTO rate_mst VALUES (5,	104.5);
INSERT INTO rate_mst VALUES (6,	104.7);
INSERT INTO rate_mst VALUES (7,	110.1);
INSERT INTO rate_mst VALUES (8,	108.4);
INSERT INTO rate_mst VALUES (9,	105.9);
INSERT INTO rate_mst VALUES (10,	107.2);
INSERT INTO rate_mst VALUES (11,	106.6);
INSERT INTO rate_mst VALUES (12,	106.7);

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE prc_xxb
IS
    CURSOR s_cur IS 
        SELECT * FROM rate_mst;
    l_p NUMBER;
    sums NUMBER;
    pm_check NUMBER := 0;
    NO_RECORD EXCEPTION;
BEGIN
	l_p := TO_NUMBER(TO_CHAR(SYSDATE, 'mm'));
	sums := 0;
    FOR s_rec IN s_cur LOOP
    IF s_rec.month >= l_p THEN
		sums := ROUND(sums + s_rec.rate * 100);
		pm_check := pm_check + 1;
    END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(l_p||'月から'||'12月まで100ドルつづ預けた結果: '||sums||'円'); 
    DBMS_OUTPUT.PUT_LINE('預けたドル: '||(12-l_p+1)*100||'ドル'); 
EXCEPTION
    WHEN NO_RECORD THEN
        DBMS_OUTPUT.PUT_LINE('対象販売員がいません。');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('others: ' || SQLERRM);
        ROLLBACK;        
END;
/
exec prc_xxb;











SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE prc_xxb(l_p number)
IS
    CURSOR s_cur IS 
        SELECT * FROM rate_mst;
    --l_p NUMBER;
    sums NUMBER;
    VALUE_EXCEEDED EXCEPTION;
BEGIN
	--l_p := TO_NUMBER(TO_CHAR(SYSDATE, 'mm'));
	IF l_p NOT BETWEEN 1 AND 12 THEN
		RAISE VALUE_EXCEEDED;
	END IF;
	sums := 0;
    FOR s_rec IN s_cur LOOP
    IF s_rec.month >= l_p THEN
		sums := ROUND(sums + s_rec.rate * 100);
    END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(l_p||'月から'||'12月まで100ドルつづ預けた結果: '||sums||'円'); 
    DBMS_OUTPUT.PUT_LINE('預けたドル: '||(12-l_p+1)*100||'ドル'); 
EXCEPTION
    WHEN VALUE_EXCEEDED THEN
        DBMS_OUTPUT.PUT_LINE('対象がいません');
END;
/
exec prc_xxb(1);
exec prc_xxb(0);



























SET SERVEROUTPUT ON;
DECLARE
    CURSOR s_cur IS 
        SELECT * FROM rate_mst;
    l_p NUMBER;
    sums NUMBER;
BEGIN
	l_p := TO_NUMBER(TO_CHAR(SYSDATE, 'mm'));
	sums := 0;
    FOR s_rec IN s_cur LOOP
    IF s_rec.month >= l_p THEN
		sums := ROUND(sums + s_rec.rate * 100);
    END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(l_p||'月から'||'12月まで100ドルつづ預けた結果: '||sums||'円'); 
    DBMS_OUTPUT.PUT_LINE('預けたドル: '||(12-l_p+1)*100||'ドル'); 
END;


SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'mm')) ye FROM DUAL;
SELECT TRUNC(SYSDATE, 'month') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'month') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'mm') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'day') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'd') FROM DUAL; --이번주는 몇번째(1~7)
SELECT TO_CHAR(SYSDATE, 'dd') FROM DUAL; --오늘 몇일
SELECT TO_CHAR(SYSDATE, 'ddd') FROM DUAL; --오늘은 1년중 몇일(1~365)
