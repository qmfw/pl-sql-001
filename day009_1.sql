DECLARE
  --l_menu_name  zzz_menu_master.menu_name%TYPE;
  l_menu_name  VARCHAR2(30);
  l_var        VARCHAR2(3);
BEGIN
  SELECT menu_name
    INTO l_menu_name
    FROM zzz_menu_master
   WHERE menu_code = 'a001';
   --l_var := 'abcdefg';
   --insert into zzz_menu_master(menu_code, menu_name, unit_price) values('a001', '石焼ビビンバ',980);
   insert into zzz_menu_master(menu_code, menu_name, unit_price) 
      values('a001', 'カルビ焼肉',1500);
   DBMS_OUTPUT.PUT_LINE('メニュー名 >> '||l_menu_name);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('NO DATA FOUND >> '||SQLERRM);
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('TOO MANY ROWS >> '||SQLERRM);
  WHEN VALUE_ERROR THEN
    DBMS_OUTPUT.PUT_LINE('VALUE ERROR >> '||SQLERRM);
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX >> '||SQLERRM);
    update zzz_menu_master 
        SET menu_name = '特上カルビ焼肉', unit_price = 1630
            where menu_code = 'a001';
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('OTHERS >> '||SQLERRM);  
END;
/
select * from zzz_menu_master;

--例外処理について
DECLARE
  --l_menu_name  zzz_menu_master.menu_name%TYPE;
  l_menu_name  VARCHAR2(30);
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
