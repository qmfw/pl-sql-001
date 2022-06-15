CREATE TABLE salesp_mst (
	salesp_no NUMBER(3), salesp_name VARCHAR2(20), shop_no NUMBER(1)
);
INSERT INTO salesp_mst VALUES (101,	'販売員Ａ',	1);
INSERT INTO salesp_mst VALUES (102,	'販売員Ｂ',	1);
INSERT INTO salesp_mst VALUES (103,	'販売員Ｃ',	1);
INSERT INTO salesp_mst VALUES (104,	'販売員Ｄ',	1);
INSERT INTO salesp_mst VALUES (105,	'販売員Ｅ',	1);
INSERT INTO salesp_mst VALUES (201,	'販売員Ｆ',	2);
INSERT INTO salesp_mst VALUES (202,	'販売員Ｇ',	2);
INSERT INTO salesp_mst VALUES (203,	'販売員Ｈ',	2);
INSERT INTO salesp_mst VALUES (204,	'販売員Ｉ',	2);
INSERT INTO salesp_mst VALUES (205,	'販売員Ｊ',	2);
INSERT INTO salesp_mst VALUES (301,	'販売員Ｋ',	3);
INSERT INTO salesp_mst VALUES (302,	'販売員Ｌ',	3);
INSERT INTO salesp_mst VALUES (303,	'販売員Ｍ',	3);
INSERT INTO salesp_mst VALUES (304,	'販売員Ｎ',	3);
INSERT INTO salesp_mst VALUES (305,	'販売員Ｏ',	3);

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE prc_xxa(l_s number)
IS
	TYPE record1 IS RECORD (
		salesp_no		salesp_mst.salesp_no%TYPE,
		salesp_name     salesp_mst.salesp_name%TYPE,
		shop_no			salesp_mst.shop_no%TYPE
	);
    rec1 record1;
    CURSOR s_cur IS 
        SELECT * FROM salesp_mst;
        --SELECT * FROM salesp_mst WHERE salesp_no = l_s;
    NO_RECORD EXCEPTION;
BEGIN
    rec1.salesp_name := 'ERROR_EXCEPTION!';
    FOR s_rec IN s_cur LOOP
    IF s_rec.salesp_no = l_s THEN 
    	rec1.salesp_no := s_rec.salesp_no;
        rec1.salesp_name := s_rec.salesp_name;
        rec1.shop_no := s_rec.shop_no;
    END IF;
    END LOOP;
    IF rec1.salesp_name = 'ERROR_EXCEPTION!' THEN
        RAISE NO_RECORD;
    ELSE
        DBMS_OUTPUT.PUT_LINE('[販売員番号 : '||rec1.salesp_no||'] [販売員名 : '||
        rec1.salesp_name||'] [店番号 : '||rec1.shop_no||']');
    END IF;
EXCEPTION
    WHEN NO_RECORD THEN
        DBMS_OUTPUT.PUT_LINE('対象販売員がいません');
        --DBMS_OUTPUT.PUT_LINE('ERROR >> '||SQLERRM);
END;
/
exec prc_xxa(100);
exec prc_xxa(101);




















SET SERVEROUTPUT ON;
DECLARE
    l_s NUMBER;
	TYPE record1 IS RECORD (
		salesp_no NUMBER(3), salesp_name VARCHAR2(20), shop_no NUMBER(1)
	);
    rec1 record1;
    CURSOR s_cur IS 
        SELECT * FROM salesp_mst;
    NOT_EXIST_PHONE EXCEPTION;
BEGIN
    l_s := &x;
    rec1.salesp_no := -999;
    FOR s_rec IN s_cur LOOP
    IF s_rec.salesp_no = l_s THEN 
    	rec1.salesp_no := s_rec.salesp_no;
        rec1.salesp_name := s_rec.salesp_name;
        rec1.shop_no := s_rec.shop_no;
    END IF;
    END LOOP;
    IF rec1.salesp_no = -999 THEN
        RAISE NOT_EXIST_PHONE;
    ELSE
        DBMS_OUTPUT.PUT_LINE('data');
        DBMS_OUTPUT.PUT_LINE(rec1.salesp_no||' '||rec1.salesp_name||' '||rec1.shop_no);
    END IF;
EXCEPTION
    WHEN NOT_EXIST_PHONE THEN
        DBMS_OUTPUT.PUT_LINE('対象販売員がいません');
        --DBMS_OUTPUT.PUT_LINE('ERROR >> '||SQLERRM);
END;
/

declare
i integer;
j integer;
s integer;
begin
i:=:i;      -----observe this statement. This statement will tell the machine to take input of i through user.
j:=:j;      -----observe this statement. This statement will tell the machine to take input of j through user.
s:=i+j;
dbms_output.put_line('sum of '||i||' and '||j||' is '||s);     
end;