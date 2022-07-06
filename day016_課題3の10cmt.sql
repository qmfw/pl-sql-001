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
INSERT INTO sales_tbl VALUES (11,1);
INSERT INTO sales_tbl VALUES (12,3);
INSERT INTO sales_tbl VALUES (13,5);
INSERT INTO sales_tbl VALUES (14,7);
INSERT INTO sales_tbl VALUES (15,9);
INSERT INTO sales_tbl VALUES (16,8);
INSERT INTO sales_tbl VALUES (17,6);
INSERT INTO sales_tbl VALUES (18,4);
INSERT INTO sales_tbl VALUES (19,2);
INSERT INTO sales_tbl VALUES (20,2);
INSERT INTO sales_tbl VALUES (21,3);
INSERT INTO sales_tbl VALUES (22,1);
INSERT INTO sales_tbl VALUES (23,4);
INSERT INTO sales_tbl VALUES (24,4);
INSERT INTO sales_tbl VALUES (25,9);
INSERT INTO sales_tbl VALUES (26,8);
INSERT INTO sales_tbl VALUES (27,5);
INSERT INTO sales_tbl VALUES (28,6);
INSERT INTO sales_tbl VALUES (29,7);
INSERT INTO sales_tbl VALUES (30,7);

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
INSERT INTO product_mst VALUES (11,	'牛乳2',	100,	1);
INSERT INTO product_mst VALUES (12,	'バター2',	150,	1);
INSERT INTO product_mst VALUES (13,	'ワイン2',	300,	2);
INSERT INTO product_mst VALUES (14,	'ジュース2',	400,	1);
INSERT INTO product_mst VALUES (15,	'ビール2',	250,	2);
INSERT INTO product_mst VALUES (16,	'チョコレート2',	50,	1);
INSERT INTO product_mst VALUES (17,	'焼酎2',	800,	2);
INSERT INTO product_mst VALUES (18,	'ビスケット2',	120,	1);
INSERT INTO product_mst VALUES (19,	'日本酒2',	750,	2);
INSERT INTO product_mst VALUES (20,	'アイスクリーム2',	70,	1);--check 1
INSERT INTO product_mst VALUES (21,	'牛乳3',	100,	1);
INSERT INTO product_mst VALUES (22,	'バター3',	150,	1);
INSERT INTO product_mst VALUES (23,	'ワイン3',	300,	2);
INSERT INTO product_mst VALUES (24,	'ジュース3',	400,	1);
INSERT INTO product_mst VALUES (25,	'ビール3',	250,	2);
INSERT INTO product_mst VALUES (26,	'チョコレート3',	50,	1);
INSERT INTO product_mst VALUES (27,	'焼酎3',	800,	2);
INSERT INTO product_mst VALUES (28,	'ビスケット3',	120,	1);
INSERT INTO product_mst VALUES (29,	'日本酒3',	750,	2);
INSERT INTO product_mst VALUES (30,	'アイスクリーム3',	70,	1);

CREATE TABLE sales_detail_tbl (
    product_nm VARCHAR2(30), quantity NUMBER(2),
    sales_price NUMBER, tax NUMBER(2)
);








--課題5　課題3を10件ずつコミットするように修正する
CREATE OR REPLACE PACKAGE sales_pkg
IS
	FUNCTION f_total_price_mean(pn_quantity IN NUMBER, pn_price IN NUMBER, pn_tax_class IN NUMBER) RETURN NUMBER;
	PROCEDURE prc_xxx;
END sales_pkg;



SET SERVEROUTPUT ON;
CREATE OR REPLACE PACKAGE BODY sales_pkg 
IS

-- 関数を作成
	FUNCTION f_total_price_mean(pn_quantity IN NUMBER, pn_price IN NUMBER, pn_tax_class IN NUMBER) RETURN NUMBER
	IS
	    ln_sales_price NUMBER;
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
		IF pn_tax_class = 1 THEN
			ln_sales_price := pn_quantity*pn_price*1.08;
		ELSIF pn_tax_class = 2 THEN
			ln_sales_price := pn_quantity*pn_price*1.1;
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
	END f_total_price_mean;

-- プロシージャの作成
	PROCEDURE prc_xxx
	IS
	    CURSOR s_cur IS 
	        SELECT b.product_nm, a.quantity, b.price, b.tax_class 
	        FROM sales_tbl a INNER JOIN product_mst b ON a.product_cd = b.product_cd;
	    l_p NUMBER;
	    total_8 NUMBER := 0;
	    total_10 NUMBER := 0;
	    commit_ch NUMBER := 0;
	    PRICE_TABLE_NOT_NULL EXCEPTION;
	BEGIN
	    FOR s_rec IN s_cur LOOP
	    IF s_rec.product_nm IS NULL THEN
	    	RAISE PRICE_TABLE_NOT_NULL;
	    END IF;
	    l_p := f_total_price_mean(s_rec.quantity, s_rec.price, s_rec.tax_class);
	    --l_p := sales_pkg.f_total_price_mean(s_rec.quantity, s_rec.price, s_rec.tax_class);
	    IF l_p IS NULL THEN
			DBMS_OUTPUT.PUT_LINE('売上金額が算出できません。');
	        l_p := 1;
	    ELSIF s_rec.tax_class = 1 THEN
	    	INSERT INTO sales_detail_tbl VALUES (s_rec.product_nm, s_rec.quantity, l_p, 8);
	        total_8 := total_8 + l_p;
	        commit_ch := commit_ch + 1;
	    ELSIF s_rec.tax_class = 2 THEN
	    	INSERT INTO sales_detail_tbl VALUES (s_rec.product_nm, s_rec.quantity, l_p, 10);
	        total_10 := total_10 + l_p;
	        commit_ch := commit_ch + 1;	        
	    END IF;
	    --10件ことにcommit
	    IF mod(commit_ch, 10) = 0 THEN
	    	COMMIT;
	    	--l_p := 1 / 0;
	    END IF;
	    END LOOP;
	    IF l_p IS NULL THEN
	    	RAISE PRICE_TABLE_NOT_NULL;
	    END IF;
	    DBMS_OUTPUT.PUT_LINE('売上合計(8%）＝　'||total_8||'円');
	    DBMS_OUTPUT.PUT_LINE('売上合計(10%）＝　'||total_10||'円');
	    COMMIT;
	EXCEPTION
	    WHEN PRICE_TABLE_NOT_NULL THEN
			DBMS_OUTPUT.PUT_LINE('売上テーブルに対象データが存在しません。');
	    WHEN OTHERS THEN 
	        DBMS_OUTPUT.PUT_LINE('OTHERS >> '||SQLERRM);  
	END prc_xxx;
END sales_pkg;
/
SELECT sales_pkg.f_total_price_mean(3, 100, 1) from DUAL;
EXEC sales_pkg.prc_xxx;