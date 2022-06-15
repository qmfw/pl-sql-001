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

CREATE TABLE z220609_sales_add_1 AS SELECT 
b.product_nm, a.quantity, b.tax_class, b.price
FROM sales_tbl a LEFT JOIN product_mst b ON a.product_cd = b.product_cd;

--ALTER TABLE sales_detail_tbl ADD (sales_price NUMBER, tax NUMBER(2));
SELECT * FROM sales_tbl;
SELECT * FROM product_mst;
SELECT * FROM z220609_sales_add_1;
DROP TABLE sales_tbl;
DROP TABLE product_mst;
DROP TABLE z220609_sales_add_1;

CREATE TABLE z220609_sales_add_2 (
    sales_price NUMBER, tax NUMBER(2)
);
DROP TABLE z220609_sales_add_2;
SELECT * FROM z220609_sales_add_2;

SET SERVEROUTPUT ON;
DECLARE
    CURSOR st_cur IS 
        SELECT * FROM z220609_sales_add_1;
    student_check_1 NUMBER := 0;
BEGIN
    FOR st_rec IN st_cur LOOP
    --DBMS_OUTPUT.PUT_LINE(st_rec.school_year||' '||st_rec.class_s);
    IF st_rec.tax_class = 1 THEN
    	INSERT INTO z220609_sales_add_2(sales_price, tax) 
    	VALUES (st_rec.quantity*st_rec.price*1.08, 8);
    ELSIF st_rec.tax_class = 2 THEN
    	INSERT INTO z220609_sales_add_2(sales_price, tax) 
    	VALUES (st_rec.quantity*st_rec.price*1.1, 10);    
    END IF;
    END LOOP;
END;

SELECT * FROM z220609_sales_add_1;
SELECT * FROM z220609_sales_add_2;

CREATE TABLE sales_detail_tbl AS SELECT 
a.product_nm, a.quantity, b.sales_price, b.tax
FROM z220609_sales_add_1 a UNION z220609_sales_add_2 b ON 1=1;

SELECT * FROM sales_detail_tbl;
DROP TABLE sales_detail_tbl;

2개의 방법: 7x7 조인 말고 그대로 가로로 합치기 or insert할때