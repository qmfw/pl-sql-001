select table_name from user_tables;





select table_name from user_tables;


select substr('あいうえお',1,2) from dual;
select sysdate from dual;
select to_char(sysdate,'YYYY/MM/DD') from dual;


select * from zzz_menu_master;




DECLARE
	--l_menu_name zzz_menu_master.menu_name%TYPE;
	l_menu_name VARCHAR2(30);
    
BEGIN
	SELECT menu_name
	INTO l_menu_name
	FROM zzz_menu_master
	WHERE menu_code = 'a001';	
    DBMS_OUTPUT.PUT_LINE('メニュー名 >> '||l_menu_name);
    
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('ERROR >> '||SQLERRM);
END;
/




DECLARE
	--l_menu_name zzz_menu_master.menu_name%TYPE;
	l_menu_name VARCHAR2(30);

BEGIN
	SELECT menu_name
	INTO l_menu_name
	FROM zzz_menu_master
	WHERE menu_code = 'x001';	
    DBMS_OUTPUT.PUT_LINE('メニュー名 >> '||l_menu_name);
    
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('ERROR >> '||SQLERRM);
END;
/