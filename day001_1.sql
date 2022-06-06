--sqlplus apps/apps@t06db
--Ykkap@345

SET SERVEROUTPUT ON
DECLARE
  --変数宣言部
  ln_xxNo  NUMBER;
BEGIN
  --本文
  ln_xxNo := 'ABC';
  DBMS_OUTPUT.PUT_LINE('正常終了！');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('ERROR >> '||SQLERRM);
END;
/
DECLARE
  --変数宣言部
  ln_xxNo  NUMBER;
BEGIN
  --本文
  ln_xxNo := 123;
  DBMS_OUTPUT.PUT_LINE('正常終了！');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('ERROR >> '||SQLERRM);
END;
/