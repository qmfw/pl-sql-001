CREATE TABLE student_tbl (
	school_year NUMBER(1),
	class_s NUMBER(1),
	student_name VARCHAR2(20),
	student_no VARCHAR2(10) PRIMARY KEY
);

INSERT INTO student_tbl VALUES (1,	1,	'生徒1-1-A',	'010101');
INSERT INTO student_tbl VALUES (1,	1,	'生徒1-1-B',	'010102');
INSERT INTO student_tbl VALUES (1,	1,	'生徒1-1-C',	'010103');
INSERT INTO student_tbl VALUES (1,	1,	'生徒1-1-D',	'010104');
INSERT INTO student_tbl VALUES (1,	2,	'生徒1-2-E',	'010201');
INSERT INTO student_tbl VALUES (1,	2,	'生徒1-2-F',	'010202');
INSERT INTO student_tbl VALUES (1,	2,	'生徒1-2-G',	'010203');
INSERT INTO student_tbl VALUES (1,	2,	'生徒1-2-H',	'010204');
INSERT INTO student_tbl VALUES (1,	3,	'生徒1-3-I',	'010301');
INSERT INTO student_tbl VALUES (1,	3,	'生徒1-3-J',	'010302');
INSERT INTO student_tbl VALUES (2,	1,	'生徒2-1-A',	'020101');
INSERT INTO student_tbl VALUES (2,	1,	'生徒2-1-B',	'020102');
INSERT INTO student_tbl VALUES (2,	1,	'生徒2-1-C',	'020103');
INSERT INTO student_tbl VALUES (2,	2,	'生徒2-2-D',	'020201');
INSERT INTO student_tbl VALUES (2,	2,	'生徒2-2-E',	'020202');
INSERT INTO student_tbl VALUES (2,	2,	'生徒2-2-F',	'020203');
INSERT INTO student_tbl VALUES (2,	2,	'生徒2-2-G',	'020204');
INSERT INTO student_tbl VALUES (2,	3,	'生徒2-3-H',	'020301');
INSERT INTO student_tbl VALUES (2,	3,	'生徒2-3-I',	'020302');
INSERT INTO student_tbl VALUES (2,	3,	'生徒2-3-J',	'020303');
INSERT INTO student_tbl VALUES (3,	1,	'生徒3-1-A',	'030101');
INSERT INTO student_tbl VALUES (3,	1,	'生徒3-1-B',	'030102');
INSERT INTO student_tbl VALUES (3,	2,	'生徒3-2-C',	'030201');
INSERT INTO student_tbl VALUES (3,	2,	'生徒3-2-D',	'030202');
INSERT INTO student_tbl VALUES (3,	2,	'生徒3-2-E',	'030203');
INSERT INTO student_tbl VALUES (3,	3,	'生徒3-3-F',	'030301');
INSERT INTO student_tbl VALUES (3,	3,	'生徒3-3-G',	'030302');
INSERT INTO student_tbl VALUES (3,	3,	'生徒3-3-H',	'030303');
INSERT INTO student_tbl VALUES (3,	3,	'生徒3-3-I',	'030304');
INSERT INTO student_tbl VALUES (3,	3,	'生徒3-3-J',	'030305');

SELECT * FROM STUDENT_TBL;
DROP  TABLE STUDENT_TBL;
select * from employees;
------------------------------------------------------------------
SET SERVEROUTPUT ON;
DECLARE
    CURSOR emp_cur IS
        SELECT * FROM student_tbl;
    emp_rec student_tbl%ROWTYPE;
BEGIN
    open emp_cur;
    LOOP
    FETCH emp_cur INTO emp_rec;
    EXIT WHEN emp_cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(emp_rec.school_year||' '||emp_rec.class_s);
    END LOOP;
    CLOSE emp_cur;
END;
--------------------------------------------------------------------
SET SERVEROUTPUT ON;
DECLARE
    CURSOR st_cur IS 
        SELECT * FROM student_tbl;
    st_rec student_tbl%ROWTYPE;
    student_check_1 NUMBER := 0;
    student_check_2 NUMBER := 0;
    student_check_3 NUMBER := 0;
BEGIN
    open st_cur;
    LOOP
    FETCH st_cur INTO st_rec;
    EXIT WHEN st_cur%NOTFOUND;
    --DBMS_OUTPUT.PUT_LINE(st_rec.school_year||' '||st_rec.class_s);
    IF st_rec.school_year = 1 THEN student_check_1 := student_check_1+1;
    ELSIF st_rec.school_year = 2 THEN student_check_2 := student_check_2+1;
    ELSE student_check_3 := student_check_3+1;
    END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('1年生は'||student_check_1||'人、'||'2年生は'||student_check_2||
    '人、'||'3年生は'||student_check_3||'人です。');
    CLOSE st_cur;
END;