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

CREATE TABLE z220609_sales_id (
    id_num NUMBER(2), product_cd NUMBER(2),
    sales_price NUMBER, tax NUMBER(2)
);
CREATE SEQUENCE z1_seq START WITH 1 INCREMENT BY 1 MAXVALUE 100 CYCLE NOCACHE;
INSERT INTO z220609_sales_id(id_num, product_cd) values(z1_seq.NEXTVAL, 1);
INSERT INTO z220609_sales_id(id_num, product_cd) values(z1_seq.NEXTVAL, 2);
INSERT INTO z220609_sales_id(id_num, product_cd) values(z1_seq.NEXTVAL, 3);
INSERT INTO z220609_sales_id(id_num, product_cd) values(z1_seq.NEXTVAL, 4);
INSERT INTO z220609_sales_id(id_num, product_cd) values(z1_seq.NEXTVAL, 5);
INSERT INTO z220609_sales_id(id_num, product_cd) values(z1_seq.NEXTVAL, 8);
INSERT INTO z220609_sales_id(id_num, product_cd) values(z1_seq.NEXTVAL, 9);


CREATE TABLE sales_detail_tbl AS SELECT 
b.product_nm, a.quantity, c.sales_price, c.tax, c.id_num, b.tax_class, b.price
FROM sales_tbl a LEFT JOIN product_mst b ON a.product_cd = b.product_cd 
LEFT JOIN z220609_sales_id c ON c.product_cd = a.product_cd;
--ALTER TABLE sales_detail_tbl ADD (sales_price NUMBER, tax NUMBER(2));

SELECT * FROM sales_tbl;
SELECT * FROM product_mst;
SELECT * FROM z220609_sales_id;
SELECT * FROM sales_detail_tbl;
DROP TABLE sales_tbl;
DROP TABLE product_mst;
DROP TABLE z220609_sales_id;
DROP TABLE sales_detail_tbl;


SET SERVEROUTPUT ON;
DECLARE
    CURSOR st_cur IS 
        SELECT * FROM sales_detail_tbl;
    check_1 NUMBER := 1;
BEGIN
    FOR st_rec IN st_cur LOOP
    --DBMS_OUTPUT.PUT_LINE(st_rec.school_year||' '||st_rec.class_s);
    IF st_rec.tax_class = 1 THEN
    	UPDATE sales_detail_tbl
        SET sales_price = st_rec.quantity*st_rec.price*1.08, tax = 8
    	WHERE id_num = check_1;
        check_1 := check_1 + 1;
    ELSIF st_rec.tax_class = 2 THEN
        UPDATE sales_detail_tbl
        SET sales_price = st_rec.quantity*st_rec.price*1.1, tax = 10
    	WHERE id_num = check_1;
        check_1 := check_1 + 1;
    END IF;
    END LOOP;
END;
 
SELECT product_nm, quantity, sales_price, tax FROM sales_detail_tbl;
