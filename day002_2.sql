set serveroutput on
declare
    vi_num1 number := 1;
    vi_num2 number := 2;    
begin
    if vi_num1 >= vi_num2 then
        dbms_output.put_line(vi_num1 || ' is bigger than ' || vi_num2);
    else
        dbms_output.put_line(vi_num2 || ' is bigger than ' || vi_num1);
    end if;
end;
/