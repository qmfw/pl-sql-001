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
    	sums := sums + s_rec.rate * 100;
    END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('OTHERS >> '||sums); 
END;








1 dollar = 133   円
1 dollar = 101.5 円

SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'mm')) ye FROM DUAL;
SELECT TRUNC(SYSDATE, 'month') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'month') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'mm') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'day') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'd') FROM DUAL; --이번주는 몇번째(1~7)
SELECT TO_CHAR(SYSDATE, 'dd') FROM DUAL; --오늘 몇일
SELECT TO_CHAR(SYSDATE, 'ddd') FROM DUAL; --오늘은 1년중 몇일(1~365)
