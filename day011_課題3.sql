CREATE TABLE sales_tbl (
	product_cd NUMBER(2),
	quantity NUMBER(2)
);

INSERT INTO sales_tbl VALUES (1,2);
INSERT INTO sales_tbl VALUES (2,3);
INSERT INTO sales_tbl VALUES (3,1);
INSERT INTO sales_tbl VALUES (4,7);
INSERT INTO sales_tbl VALUES (5,4);
INSERT INTO sales_tbl VALUES (8,4);
INSERT INTO sales_tbl VALUES (9,2);

CREATE TABLE product_mst (
	product_cd NUMBER(2),
	product_nm VARCHAR2(30),
	price NUMBER(5),
	tax_class VARCHAR2(2)
);

INSERT INTO product_mst VALUES (1,	'牛乳',	100,	1);
INSERT INTO product_mst VALUES (2,	'バター',	150,	1);
INSERT INTO product_mst VALUES (3,	'ワイン',	300,	2);
INSERT INTO product_mst VALUES (4,	'ジュース',	400,	1);
INSERT INTO product_mst VALUES (5,	'ビール',	250,	2);
INSERT INTO product_mst VALUES (6,	'チョコレート',	50,	1);
INSERT INTO product_mst VALUES (7,	'焼酎',	800,	2);
INSERT INTO product_mst VALUES (8,	'ビスケット',	120,	1);
INSERT INTO product_mst VALUES (9,	'日本酒',	750,	2);
INSERT INTO product_mst VALUES (10,	'アイスクリーム',	70,	1);

CREATE TABLE sales_detail_tbl (
    product_nm VARCHAR2(30), quantity NUMBER(2),
    sales_price NUMBER, tax NUMBER(2)
);

SELECT * FROM sales_tbl;
SELECT * FROM product_mst;
SELECT * FROM sales_detail_tbl;
DROP TABLE sales_tbl;
DROP TABLE product_mst;
DROP TABLE sales_detail_tbl;

-- 関数を作成
CREATE OR REPLACE FUNCTION
f_total_price(pn_quantity IN NUMBER, pn_price IN NUMBER, pn_tax_class IN NUMBER) RETURN NUMBER
IS
    ln_sales_price NUMBER;
BEGIN 
	IF pn_tax_class = 1 THEN
		ln_sales_price := pn_quantity*pn_price*1.08;
	ELSIF pn_tax_class = 2 THEN
		ln_sales_price := pn_quantity*pn_price*1.1;
	END IF;
    RETURN ln_sales_price;
EXCEPTION
  WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('OTHERS >> '||SQLERRM);  
END;
/

-- プロシージャの作成
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE prc_xxx
IS
    CURSOR s_cur IS 
        SELECT b.product_nm, a.quantity, b.price, b.tax_class 
        FROM sales_tbl a LEFT JOIN product_mst b ON a.product_cd = b.product_cd;
    l_p NUMBER;
BEGIN
    FOR s_rec IN s_cur LOOP
    l_p := f_total_price(s_rec.quantity, s_rec.price, s_rec.tax_class);
    IF s_rec.tax_class = 1 THEN
    	INSERT INTO sales_detail_tbl VALUES (s_rec.product_nm, s_rec.quantity, l_p, 8);
    ELSIF s_rec.tax_class = 2 THEN
    	INSERT INTO sales_detail_tbl VALUES (s_rec.product_nm, s_rec.quantity, l_p, 10);
    END IF;
    END LOOP;
END;

SELECT f_total_price(3, 100, 1) from DUAL;
select to_char(sysdate,'yyyy/mm/dd') from dual;
SELECT * FROM sales_detail_tbl;
TRUNCATE TABLE sales_detail_tbl;

























SET SERVEROUTPUT ON;
DECLARE
    CURSOR s_cur IS 
        SELECT b.product_nm, a.quantity, b.price, b.tax_class 
        FROM sales_tbl a LEFT JOIN product_mst b ON a.product_cd = b.product_cd;
    l_p NUMBER;
BEGIN
    FOR s_rec IN s_cur LOOP
    --DBMS_OUTPUT.PUT_LINE(st_rec.school_year||' '||st_rec.class_s);
    IF s_rec.tax_class = 1 THEN
    	l_p := f_tax(s_rec.quantity, s_rec.price, 8);
    	INSERT INTO sales_detail_tbl VALUES (s_rec.product_nm, s_rec.quantity, l_p, 8);
    ELSIF s_rec.tax_class = 2 THEN
    	l_p := f_tax(s_rec.quantity, s_rec.price, 10);
    	INSERT INTO sales_detail_tbl VALUES (s_rec.product_nm, s_rec.quantity, l_p, 10);
    END IF;
    END LOOP;
END;

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE
prc_xxx
IS
  shit NUMBER;
BEGIN
    shit := f_tax(2,100,8);
    DBMS_OUTPUT.PUT_LINE(shit);
END;
/
exec prc_xxx;
--SELECT f_tax(2,100,8) FROM DUAL;
