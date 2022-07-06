create table abc (
    char1 varchar(20),
    char2 varchar(20)
);

insert into abc values ('aa', 'abc2');

create table abc2 (
    char1 varchar(20),
    char2 varchar(20)
); 

SET SERVEROUTPUT ON;
DECLARE
    CURSOR s_cur IS 
        SELECT * FROM abc;
    vs_sql varchar(200);
    check1 varchar(20);
BEGIN
    FOR s_rec IN s_cur LOOP
    check1 := s_rec.char2;
    dbms_output.put_line(check1);
    vs_sql := 'INSERT INTO '||check1||' VALUES (:a, :a)';
    check1 := s_rec.char2;
    EXECUTE IMMEDIATE vs_sql USING  'aaa', 'ss';
    
    --INSERT INTO abc2 VALUES (3,'anc');
    END LOOP;
END;



select * from abc2;
drop table abc2;
drop table abc;

'SELECT COUNT(*) INTO any_rows FROM '||to_tbl_char||'';
insert /*+ ignore_row_on_dupkey_index(abc2 abc2_gang)*/ into abc2 select * from abc;








DECLARE
    CURSOR s_cur IS 
        SELECT * FROM abc;
    any_rows number;
    JUNGSANGSOO number := 0;
    to_tbl_char VARCHAR(300);
    length_char VARCHAR(300);
BEGIN
    to_tbl_char := 'abc';
    execute immediate 'SELECT COUNT(*) FROM '||to_tbl_char||'' into any_rows;
    for i in 1..any_rows
    loop
        BEGIN
            insert into abc values ('aa', 'abc1');
        EXCEPTION WHEN DUP_VAL_ON_INDEX THEN 
            JUNGSANGSOO := JUNGSANGSOO + 1;
            NULL;
        END;
    end loop;
    if any_rows = 1 then
        DBMS_OUTPUT.PUT_LINE('ya g');
    else
        DBMS_OUTPUT.PUT_LINE('any_rows:'||any_rows||' JUNGSANGSOO: '||JUNGSANGSOO);
    end if;
END;










SET SERVEROUTPUT ON;
DECLARE
    f1 VARCHAR(100) := 'XX_SALES_DAT_WK';
    f11 VARCHAR(100) := 'XX_SALES_DETAIL_WK';
    from_tbl_char VARCHAR(100) := 'XX_SALES_DAT_WK';
    f2 VARCHAR(5) := 'P';
    k1 VARCHAR(100);
    k2 VARCHAR(100);
    i number := 1;
    num1 number := 3;
    length_const number;
    name_col VARCHAR(100);
BEGIN
    execute immediate 'select column_name from (SELECT * FROM DBA_TAB_COLUMNS 
        where table_name = :a and ROWNUM <= :a ORDER BY ROWNUM DESC) 
        WHERE ROWNUM = 1' into name_col using from_tbl_char, 2;	 

    execute immediate 'select count(*) from 
    (select col.column_name from USER_CONS_COLUMNS col 
    INNER JOIN USER_CONSTRAINTS con ON col.constraint_name = con.constraint_name
    WHERE con.table_name = :hi AND con.constraint_type = :hi)' 
    into length_const using f11, 'P';
    dbms_output.put_line('constraint 길이: '||length_const);
    
    execute immediate 'SELECT * FROM
    (SELECT col.table_name, col.column_name FROM USER_CONS_COLUMNS col 
    INNER JOIN USER_CONSTRAINTS con ON col.constraint_name = con.constraint_name
    WHERE con.table_name = :hi AND con.constraint_type = :hi 
    AND ROWNUM <= :a ORDER BY ROWNUM DESC) 
    WHERE ROWNUM = 1' INTO k1, k2 using f11, f2, 2;
    --execute immediate 'select count(*) from (select column_name from DBA_TAB_COLUMNS 
    --where table_name = :a)' into num1 using f1;
    
    select count(*)  into num1 from (select column_name from DBA_TAB_COLUMNS 
    where table_name = 'XX_SALES_DAT_WK');
    
    --execute immediate 'select column_name from DBA_TAB_COLUMNS 
    --where table_name = :a and ROWNUM = 1' into k3 using f1; 
    
    if k2 = name_col then dbms_output.put_line('전두환 폭동');
    else dbms_output.put_line('노무현 데뷔');
    end if;    

    dbms_output.put_line('추출 num1: '||num1);

    dbms_output.put_line('추출 name_col: '||name_col);
    dbms_output.put_line(k1);
    dbms_output.put_line('추출 k2: '||k2);
END;