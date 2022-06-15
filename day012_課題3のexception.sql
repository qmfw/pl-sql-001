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

-- 関数を作成
SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION
f_total_price(pn_quantity IN NUMBER, pn_price IN NUMBER, pn_tax_class IN NUMBER) RETURN NUMBER
IS
    ln_sales_price NUMBER;
    re_tax_class NUMBER;
    re_price NUMBER;
    NOT_IN_BETWEEN_0_1 EXCEPTION;
    QUANTITY_NOT_NULL EXCEPTION;
    PRICE_NOT_NULL EXCEPTION;
BEGIN
	IF pn_quantity is NULL THEN
		RAISE QUANTITY_NOT_NULL;
	END IF;
	IF pn_price is NULL THEN
		RAISE PRICE_NOT_NULL;
	END IF;
	IF pn_tax_class < 0 THEN
		re_tax_class := (-1)*pn_tax_class;
	ELSE
		re_tax_class := pn_tax_class;
	END IF;
	IF pn_price < 0 THEN
		re_price := (-1)*pn_price;
	ELSE
		re_price := pn_price;
	END IF;
	IF re_tax_class = 1 THEN
		ln_sales_price := pn_quantity*re_price*1.08;
	ELSIF re_tax_class = 2 THEN
		ln_sales_price := pn_quantity*re_price*1.1;
	ELSE
        RAISE NOT_IN_BETWEEN_0_1;
	END IF;
    RETURN ln_sales_price;
EXCEPTION
    WHEN QUANTITY_NOT_NULL
        THEN DBMS_OUTPUT.PUT_LINE('数量には数値を設定してください。');
        RETURN NULL;
    WHEN PRICE_NOT_NULL
        THEN DBMS_OUTPUT.PUT_LINE('金額には数値を設定してください。');
        RETURN NULL;        
    WHEN NOT_IN_BETWEEN_0_1
        THEN DBMS_OUTPUT.PUT_LINE('税区分には1か2を設定してください。');
        RETURN NULL;
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('OTHERS >> '||SQLERRM);  
        RETURN NULL;
END;
/


-- プロシージャの作成
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE prc_xxx
IS
    CURSOR s_cur IS 
        SELECT b.product_nm, a.quantity, b.price, b.tax_class 
        FROM sales_tbl a INNER JOIN product_mst b ON a.product_cd = b.product_cd;
    l_p NUMBER;
    total_8 NUMBER := 0;
    total_10 NUMBER := 0;
    PRICE_TABLE_NOT_NULL EXCEPTION;
BEGIN
    FOR s_rec IN s_cur LOOP
    IF s_rec.product_nm IS NULL THEN
    	RAISE PRICE_TABLE_NOT_NULL;
    END IF;
    l_p := f_total_price(s_rec.quantity, s_rec.price, s_rec.tax_class);
    IF l_p IS NULL THEN
		DBMS_OUTPUT.PUT_LINE('売上金額が算出できません。');
        l_p := 1;
    ELSIF s_rec.tax_class = 1 THEN
    	INSERT INTO sales_detail_tbl VALUES (s_rec.product_nm, s_rec.quantity, l_p, 8);
        total_8 := total_8 + l_p;
    ELSIF s_rec.tax_class = 2 THEN
    	INSERT INTO sales_detail_tbl VALUES (s_rec.product_nm, s_rec.quantity, l_p, 10);
        total_10 := total_10 + l_p;
    END IF;
    END LOOP;
    IF l_p IS NULL THEN
    	RAISE PRICE_TABLE_NOT_NULL;
    END IF;
    DBMS_OUTPUT.PUT_LINE('売上合計(8%）＝　'||total_8||'円');
    DBMS_OUTPUT.PUT_LINE('売上合計(10%）＝　'||total_10||'円');
    --SELECT * FROM sales_detail_tbl;
    COMMIT;
EXCEPTION
    WHEN PRICE_TABLE_NOT_NULL THEN
		DBMS_OUTPUT.PUT_LINE('売上テーブルに対象データが存在しません。');
		--ROLLBACK;
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('others');
		ROLLBACK;
END;
/


SELECT * FROM sales_tbl;
SELECT * FROM product_mst;
SELECT * FROM sales_detail_tbl;
DROP TABLE sales_tbl;
DROP TABLE product_mst;
DROP TABLE sales_detail_tbl;
SELECT f_total_price(3, 100, 1) from DUAL;
select to_char(sysdate,'yyyy/mm/dd') from dual;
SELECT * FROM sales_detail_tbl;
TRUNCATE TABLE sales_detail_tbl;
SELECT SUM(sales_price) FROM sales_detail_tbl WHERE tax=8;
SELECT SUM(sales_price) FROM sales_detail_tbl WHERE tax=10;













-- プロシージャの作成
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE prc_xxx
IS
    CURSOR s_cur IS 
        SELECT b.product_nm, a.quantity, b.price, b.tax_class 
        FROM sales_tbl a LEFT JOIN product_mst b ON a.product_cd = b.product_cd;
    l_p NUMBER;
    total_8 NUMBER := 0;
    total_10 NUMBER := 0;
    TOTAL_PRICE_NOT_NULL EXCEPTION;
    PRICE_TABLE_NOT_NULL EXCEPTION;
BEGIN
    FOR s_rec IN s_cur LOOP
    IF s_rec.product_nm IS NULL THEN
    	RAISE PRICE_TABLE_NOT_NULL;
    END IF;
    l_p := f_total_price(s_rec.quantity, s_rec.price, s_rec.tax_class);
    IF l_p IS NULL THEN
    	RAISE TOTAL_PRICE_NOT_NULL;
    END IF;
    IF s_rec.tax_class = 1 THEN
    	INSERT INTO sales_detail_tbl VALUES (s_rec.product_nm, s_rec.quantity, l_p, 8);
        total_8 := total_8 + l_p;
    ELSIF s_rec.tax_class = 2 THEN
    	INSERT INTO sales_detail_tbl VALUES (s_rec.product_nm, s_rec.quantity, l_p, 10);
        total_10 := total_10 + l_p;
    END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('売上合計(8%）＝　'||total_8||'円');
    DBMS_OUTPUT.PUT_LINE('売上合計(10%）＝　'||total_10||'円');
    COMMIT;
EXCEPTION
    WHEN PRICE_TABLE_NOT_NULL THEN
		DBMS_OUTPUT.PUT_LINE('売上テーブルに対象データが存在しません。');
		ROLLBACK;
	WHEN TOTAL_PRICE_NOT_NULL THEN
		DBMS_OUTPUT.PUT_LINE('売上金額が算出できません。');
		ROLLBACK;
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('others');
		ROLLBACK;
END;
/