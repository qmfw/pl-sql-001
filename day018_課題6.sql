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
	sales_no VARCHAR2(5), detail_num NUMBER, item_cd VARCHAR2(3),
	qty NUMBER, CONSTRAINT xx_sales_detailwk_pk PRIMARY KEY(sales_no, detail_num)
);
CREATE TABLE xx_sales_detail (
	sales_no VARCHAR2(5), detail_num NUMBER, item_cd VARCHAR2(3),
	qty NUMBER, CONSTRAINT xx_sales_detail_pk PRIMARY KEY(sales_no, detail_num)
);

INSERT INTO xx_trans_mst VALUES ('XX_SALES_DETAIL_WK','XX_SALES_DETAIL','1');
INSERT INTO xx_sales_detail_wk VALUES ('aaa',1,'aa',1);
INSERT INTO xx_sales_detail_wk VALUES ('bbb',2,'bb',2);
INSERT INTO xx_sales_detail_wk VALUES ('ccc',3,'cc',3);
INSERT INTO xx_sales_detail VALUES ('aaa',1,'kk',999);

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
    length_org NUMBER; 
    length_col NUMBER;
    length_const NUMBER;    
    name_col VARCHAR(100);
    name_const VARCHAR(100);
BEGIN
    FOR s_rec IN s_cur LOOP
    from_tbl_char := s_rec.from_table_name;
    to_tbl_char := s_rec.to_table_name;
    IF s_rec.transfer_type = 1 THEN
    	execute immediate 'SELECT COUNT(*) FROM '||from_tbl_char||'' into length_org;
        
        
    		FOR i IN 1..length_org LOOP

    			static_sql := 'INSERT INTO '||to_tbl_char||' 
    				SELECT * FROM (SELECT * FROM '||from_tbl_char||'
    				WHERE ROWNUM <= '||i||' ORDER BY ROWNUM DESC)
                    WHERE ROWNUM = 1';

    			BEGIN
    				EXECUTE IMMEDIATE static_sql;
    			EXCEPTION WHEN DUP_VAL_ON_INDEX THEN 
    				execute immediate 'select count(*) from (select column_name from ALL_TAB_COLS 
    				where table_name = :hi)' into length_col using from_tbl_char;
    				FOR j IN 1..length_col LOOP
	    				execute immediate 'select column_name from (SELECT * FROM ALL_TAB_COLS 
							where table_name = :a and ROWNUM <= :a ORDER BY ROWNUM DESC) 
							WHERE ROWNUM = 1' into name_col using from_tbl_char, j;	
						execute immediate 'select count(*) from 
	    					(select col.column_name from USER_CONS_COLUMNS col 
	    					INNER JOIN USER_CONSTRAINTS con ON col.constraint_name = con.constraint_name
	    					WHERE con.table_name = :hi AND con.constraint_type = :hi)' 
    					into length_const using from_tbl_char, 'P';
	    				FOR k IN 1..length_const LOOP
		    				execute immediate 'SELECT * FROM (SELECT col.column_name 
		    					FROM USER_CONS_COLUMNS col INNER JOIN USER_CONSTRAINTS con 
		    					ON col.constraint_name = con.constraint_name
								WHERE con.table_name = :hi AND con.constraint_type = :hi 
								AND ROWNUM <= :a ORDER BY ROWNUM DESC) WHERE ROWNUM = 1'
								INTO name_const using from_tbl_char, 'P', k;
		    				IF name_col = name_const THEN 
		    					DBMS_OUTPUT.PUT_LINE('[test//] table: '||from_tbl_char);
		    					DBMS_OUTPUT.PUT_LINE(i||'行, '||j||'列: '||name_col||'   '||k||' constraint: '||name_const);
	                    	ELSE  
	                            EXECUTE IMMEDIATE 'UPDATE '||to_tbl_char||' b SET '||name_col||' = 
								(SELECT '||name_col||' FROM '||from_tbl_char||' a 
								WHERE a.'||name_const||' = b.'||name_const||')' ;
			                END IF;
		                END LOOP;--loop k, number of constraints
	                END LOOP;--loop j, number of columns
    			END;
    			
    		END LOOP;--loop i, number of rows
    
    ELSIF s_rec.transfer_type = 2 THEN
    	static_sql := 'INSERT INTO '||to_tbl_char||' 
    				SELECT * FROM '||from_tbl_char||'';
    END IF;
    END LOOP;
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
		static_sql := 'UPDATE '||to_tbl_char||' SET
    				SELECT * FROM '||from_tbl_char||'';
	WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('others: ' || SQLERRM);
END;

select * from xx_trans_mst;
select * from xx_sales_dat_wk;
select * from xx_sales_dat;
select * from xx_sales_detail;
select * from xx_sales_detail_wk;
exec xx_trans_prc;
rollback;








--PRACTICE
SET SERVEROUTPUT ON;
DECLARE
    f1 VARCHAR(100) := 'XX_SALES_DAT_WK';
    f2 VARCHAR(5) := 'P';
    k1 VARCHAR(100);
    k2 VARCHAR(100);
    k3 VARCHAR(100);
    i number := 3;
    num1 number := 3;
BEGIN
    execute immediate 'SELECT col.table_name, col.column_name
    FROM USER_CONS_COLUMNS col INNER JOIN USER_CONSTRAINTS con
    ON col.constraint_name = con.constraint_name
    WHERE con.table_name = :hi AND con.constraint_type = :hi' INTO k1, k2
    using f1, f2;
    
    --execute immediate 'select count(*) from (select column_name from DBA_TAB_COLUMNS 
    --where table_name = :a)' into num1 using f1;
    
    select count(*)  into num1 from (select column_name from DBA_TAB_COLUMNS 
    where table_name = 'XX_SALES_DAT_WK');
    
    --execute immediate 'select column_name from DBA_TAB_COLUMNS 
    --where table_name = :a and ROWNUM = 1' into k3 using f1;
    
    --루프 1..howlong
    execute immediate 'select column_name from (SELECT * FROM DBA_TAB_COLUMNS 
    where table_name = :a and ROWNUM <= :a ORDER BY ROWNUM DESC) 
    WHERE ROWNUM = 1' into k3 using f1, i;
    
    --if k2 = k3 then null;
    --else update ...
    
    
    dbms_output.put_line('추출 num1: '||num1);

    dbms_output.put_line('추출 k3: '||k3);
    dbms_output.put_line(k1);
    dbms_output.put_line('추출 k2: '||k2);
END;








UPDATE XX_SALES_DAT m SET (m.store_cd, m.amount) = 
(select c.store_cd, c.amount from XX_SALES_DAT_WK c where m.sales_no = c.sales_no);
WHERE EXISTS (select 1
              from XX_SALES_DAT_WK c
              where m.id = c.id);
select * from  XX_SALES_DAT_WK;
select * from  XX_SALES_DAT;
insert into XX_SALES_DAT values ('aaa',sysdate, '8a8', 100 );
truncate table xx_sales_dat;