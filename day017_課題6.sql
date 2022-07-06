CREATE TABLE xx_trans_mst (
	from_table_name VARCHAR2(30), to_table_name VARCHAR2(30), transfer_type VARCHAR2(1)	
);

CREATE TABLE xx_sales_dat_wk (
	sales_no VARCHAR2(5), sales_date DATE, store_cd VARCHAR2(3),
	amount NUMBER, CONSTRAINT xx_sales_datwk_pk PRIMARY KEY(sales_no)
);

CREATE TABLE xx_sales_dat (
	sales_no VARCHAR2(5), sales_date DATE, store_cd VARCHAR2(3),
	amount NUMBER, CONSTRAINT xx_trans_dat_pk PRIMARY KEY(sales_no)
);

INSERT INTO xx_trans_mst VALUES ('XX_SALES_DAT_WK','XX_SALES_DAT','1');
INSERT INTO xx_sales_dat_wk VALUES ('aaa',SYSDATE,'aa',1);
INSERT INTO xx_sales_dat_wk VALUES ('bbb',SYSDATE,'bb',1);
INSERT INTO xx_sales_dat_wk VALUES ('ccc',SYSDATE,'cc',1);


CREATE TABLE xx_sales_detail_wk (
	sales_no VARCHAR2(5), sales_date DATE, store_cd VARCHAR2(3),
	amount NUMBER, CONSTRAINT xx_trans_mst_pk PRIMARY KEY(sales_no)
);
CREATE TABLE xx_sales_detail (
	sales_no VARCHAR2(5), sales_date DATE, store_cd VARCHAR2(3),
	amount NUMBER, CONSTRAINT xx_trans_mst_pk PRIMARY KEY(sales_no)
);
CREATE TABLE xx_trans_mst (
	from_table_name VARCHAR2(30),
	to_table_name VARCHAR2(30),
	transfer_type VARCHAR2(1)	
);

SELECT * FROM sales_tbl;
SELECT * FROM product_mst;
SELECT * FROM sales_detail_tbl;
DROP TABLE sales_tbl;
DROP TABLE product_mst;
DROP TABLE sales_detail_tbl;





-- プロシージャの作成

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE xx_trans_prc
IS
    CURSOR s_cur IS 
        SELECT * FROM xx_trans_mst;
    from_tbl_char VARCHAR(100);
    to_tbl_char VARCHAR(100);
    length_char VARCHAR(100);
    static_sql VARCHAR(200);
    how_long NUMBER; 
BEGIN
    FOR s_rec IN s_cur LOOP
    from_tbl_char := s_rec.from_table_name;
    to_tbl_char := s_rec.to_table_name;
    IF s_rec.transfer_type = 1 THEN
    	execute immediate 'SELECT COUNT(*) FROM '||from_tbl_char||'' into how_long;

        
        
    		FOR i IN 1..how_long
    		LOOP
    			static_sql := 'INSERT INTO '||to_tbl_char||' 
    				SELECT * FROM (SELECT * FROM '||from_tbl_char||'
    				WHERE ROWNUM <= '||i||' ORDER BY ROWNUM DESC)
                    WHERE ROWNUM = 1';
    			BEGIN
    				EXECUTE IMMEDIATE static_sql;
    			EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
    			END;
    		END LOOP;
    /*
    ELSIF s_rec.transfer_type := 2 THEN
    	static_sql := 'INSERT INTO '||to_tbl_char||' 
    				SELECT * FROM '||from_tbl_char||'';
    END IF;
    */
    END IF;
    END LOOP;
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
		static_sql := 'UPDATE '||to_tbl_char||' SET
    				SELECT * FROM '||from_tbl_char||'';
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('others: ' || SQLERRM);
END;

SELECT * FROM sales_detail_tbl;
TRUNCATE TABLE sales_detail_tbl;