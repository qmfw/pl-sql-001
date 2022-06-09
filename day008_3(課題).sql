CREATE TABLE z220608_grade_tbl (
	school_year NUMBER(1),
	class_s NUMBER(1),
	student_name VARCHAR2(20),
	student_no VARCHAR2(10) PRIMARY KEY
);

INSERT INTO z220608_grade_tbl VALUES (1,	1,	'生徒1-1-A',	'010101');
INSERT INTO z220608_grade_tbl VALUES (1,	1,	'生徒1-1-B',	'010102');
INSERT INTO z220608_grade_tbl VALUES (1,	1,	'生徒1-1-C',	'010103');
INSERT INTO z220608_grade_tbl VALUES (1,	1,	'生徒1-1-D',	'010104');
INSERT INTO z220608_grade_tbl VALUES (1,	1,	'生徒1-2-E',	'010105');
INSERT INTO z220608_grade_tbl VALUES (1,	1,	'生徒1-2-F',	'010106');
INSERT INTO z220608_grade_tbl VALUES (1,	1,	'生徒1-2-G',	'010107');
INSERT INTO z220608_grade_tbl VALUES (1,	1,	'生徒1-2-H',	'010108');
INSERT INTO z220608_grade_tbl VALUES (1,	1,	'生徒1-3-I',	'010109');
INSERT INTO z220608_grade_tbl VALUES (1,	1,	'生徒1-3-J',	'010110');

CREATE TABLE z220608_jp (
	subject_num NUMBER(1),
	test_date DATE,
	student_no VARCHAR2(10) PRIMARY KEY,
	grade NUMBER(3)
);

INSERT INTO z220608_jp VALUES (1,	'2022/01/01',	'010101',	45);
INSERT INTO z220608_jp VALUES (1,	'2022/01/01',	'010102',	32);
INSERT INTO z220608_jp VALUES (1,	'2022/01/01',	'010103',	90);
INSERT INTO z220608_jp VALUES (1,	'2022/01/01',	'010104',	100);
INSERT INTO z220608_jp VALUES (1,	'2022/01/01',	'010105',	28);
INSERT INTO z220608_jp VALUES (1,	'2022/01/01',	'010106',	60);
INSERT INTO z220608_jp VALUES (1,	'2022/01/01',	'010107',	70);
INSERT INTO z220608_jp VALUES (1,	'2022/01/01',	'010108',	71);
INSERT INTO z220608_jp VALUES (1,	'2022/01/01',	'010109',	69);
INSERT INTO z220608_jp VALUES (1,	'2022/01/01',	'010110',	85);

CREATE TABLE z220608_mat (
	subject_num NUMBER(1),
	test_date DATE,
	student_no VARCHAR2(10) PRIMARY KEY,
	grade NUMBER(3)
);

INSERT INTO z220608_mat VALUES (2,	'2022/01/01',	'010101',	90);
INSERT INTO z220608_mat VALUES (2,	'2022/01/01',	'010102',	80);
INSERT INTO z220608_mat VALUES (2,	'2022/01/01',	'010103',	41);
INSERT INTO z220608_mat VALUES (2,	'2022/01/01',	'010104',	99);
INSERT INTO z220608_mat VALUES (2,	'2022/01/01',	'010105',	48);
INSERT INTO z220608_mat VALUES (2,	'2022/01/01',	'010106',	82);
INSERT INTO z220608_mat VALUES (2,	'2022/01/01',	'010107',	51);
INSERT INTO z220608_mat VALUES (2,	'2022/01/01',	'010108',	47);
INSERT INTO z220608_mat VALUES (2,	'2022/01/01',	'010109',	33);
INSERT INTO z220608_mat VALUES (2,	'2022/01/01',	'010110',	58);

CREATE TABLE z220608_eng (
	subject_num NUMBER(1),
	test_date DATE,
	student_no VARCHAR2(10) PRIMARY KEY,
	grade NUMBER(3)
);

INSERT INTO z220608_eng VALUES (3,	'2022/01/01',	'010101',	38);
INSERT INTO z220608_eng VALUES (3,	'2022/01/01',	'010102',	41);
INSERT INTO z220608_eng VALUES (3,	'2022/01/01',	'010103',	72);
INSERT INTO z220608_eng VALUES (3,	'2022/01/01',	'010104',	89);
INSERT INTO z220608_eng VALUES (3,	'2022/01/01',	'010105',	66);
INSERT INTO z220608_eng VALUES (3,	'2022/01/01',	'010106',	74);
INSERT INTO z220608_eng VALUES (3,	'2022/01/01',	'010107',	49);
INSERT INTO z220608_eng VALUES (3,	'2022/01/01',	'010108',	63);
INSERT INTO z220608_eng VALUES (3,	'2022/01/01',	'010109',	21);
INSERT INTO z220608_eng VALUES (3,	'2022/01/01',	'010110',	65);

CREATE TABLE z220608_sci (
	subject_num NUMBER(1),
	test_date DATE,
	student_no VARCHAR2(10) PRIMARY KEY,
	grade NUMBER(3)
);

INSERT INTO z220608_sci VALUES (4,	'2022/01/01',	'010101',	83);
INSERT INTO z220608_sci VALUES (4,	'2022/01/01',	'010102',	78);
INSERT INTO z220608_sci VALUES (4,	'2022/01/01',	'010103',	49);
INSERT INTO z220608_sci VALUES (4,	'2022/01/01',	'010104',	98);
INSERT INTO z220608_sci VALUES (4,	'2022/01/01',	'010105',	56);
INSERT INTO z220608_sci VALUES (4,	'2022/01/01',	'010106',	91);
INSERT INTO z220608_sci VALUES (4,	'2022/01/01',	'010107',	43);
INSERT INTO z220608_sci VALUES (4,	'2022/01/01',	'010108',	71);
INSERT INTO z220608_sci VALUES (4,	'2022/01/01',	'010109',	40);
INSERT INTO z220608_sci VALUES (4,	'2022/01/01',	'010110',	55);

CREATE TABLE z220608_soc (
	subject_num NUMBER(1),
	test_date DATE,
	student_no VARCHAR2(10) PRIMARY KEY,
	grade NUMBER(3)
);

INSERT INTO z220608_soc VALUES (5,	'2022/01/01',	'010101',	60);
INSERT INTO z220608_soc VALUES (5,	'2022/01/01',	'010102',	52);
INSERT INTO z220608_soc VALUES (5,	'2022/01/01',	'010103',	88);
INSERT INTO z220608_soc VALUES (5,	'2022/01/01',	'010104',	94);
INSERT INTO z220608_soc VALUES (5,	'2022/01/01',	'010105',	51);
INSERT INTO z220608_soc VALUES (5,	'2022/01/01',	'010106',	72);
INSERT INTO z220608_soc VALUES (5,	'2022/01/01',	'010107',	69);
INSERT INTO z220608_soc VALUES (5,	'2022/01/01',	'010108',	57);
INSERT INTO z220608_soc VALUES (5,	'2022/01/01',	'010109',	90);
INSERT INTO z220608_soc VALUES (5,	'2022/01/01',	'010110',	72);

CREATE TABLE z220608_subject_master (
	subject_num NUMBER(1) PRIMARY KEY,
	subject_name VARCHAR2(10)
);

INSERT INTO z220608_subject_master VALUES (1,	'国語');
INSERT INTO z220608_subject_master VALUES (2,	'数学');
INSERT INTO z220608_subject_master VALUES (3,	'英語');
INSERT INTO z220608_subject_master VALUES (4,	'理科');
INSERT INTO z220608_subject_master VALUES (5,	'社会');

ALTER TABLE z220608_jp ADD (jp_grade VARCHAR2(20));
ALTER TABLE z220608_mat ADD (mat_grade VARCHAR2(20));
ALTER TABLE z220608_eng ADD (eng_grade VARCHAR2(20));
ALTER TABLE z220608_sci ADD (sci_grade VARCHAR2(20));
ALTER TABLE z220608_soc ADD (soc_grade VARCHAR2(20));

UPDATE z220608_jp SET jp_grade = CASE
    WHEN grade >= 70 THEN 'A'
    ELSE 'B'
END;
UPDATE z220608_mat SET mat_grade = CASE
    WHEN grade >= 70 THEN 'A'
    ELSE 'B'
END;
UPDATE z220608_eng SET eng_grade = CASE
    WHEN grade >= 70 THEN 'A'
    ELSE 'B'
END;
UPDATE z220608_sci SET sci_grade = CASE
    WHEN grade >= 70 THEN 'A'
    ELSE 'B'
END;
UPDATE z220608_soc SET soc_grade = CASE
    WHEN grade >= 70 THEN 'A'
    ELSE 'B'
END;

create or replace view z220608_grade_tbl_v as select 
A.school_year 学年, A.class_s クラス, A.student_name 名前, B.test_date テスト期間, 
B.grade 国語点数, B.jp_grade 国語評価, C.grade 数学点数, C.mat_grade 数学評価, 
D.grade 英語点数, D.eng_grade 英語評価, E.grade 理科点数, E.sci_grade 理科評価, 
F.grade 社会点数, F.soc_grade 社会評価
from z220608_grade_tbl A left join z220608_jp B on b.student_no = A.student_no
left join z220608_mat C on C.student_no = A.student_no 
left join z220608_eng D on D.student_no = A.student_no 
left join z220608_sci E on E.student_no = A.student_no 
left join z220608_soc F on F.student_no = A.student_no;

SELECT * FROM z220608_grade_tbl;
SELECT * FROM z220608_jp;
SELECT * FROM z220608_mat;
SELECT * FROM z220608_eng;
SELECT * FROM z220608_sci;
SELECT * FROM z220608_soc;
SELECT * FROM z220608_subject_master;
select * from z220608_grade_tbl_v;
DROP  TABLE z220608_grade_tbl;
DROP  TABLE z220608_jp;
DROP  TABLE z220608_mat;
DROP  TABLE z220608_eng;
DROP  TABLE z220608_sci;
DROP  TABLE z220608_soc;
DROP  TABLE z220608_subject_master;
drop view z220608_grade_tbl_v;

--------------------------------------------------------------------
SET SERVEROUTPUT ON;
DECLARE
    CURSOR st_cur IS 
        SELECT * FROM z220608_grade_tbl_v;
    st_rec z220608_grade_tbl_v%ROWTYPE;
    student_check_1 NUMBER := 0;
    student_check_2 NUMBER := 0;
    student_check_3 NUMBER := 0;
    student_check_4 NUMBER := 0;
    student_check_5 NUMBER := 0;
BEGIN
    open st_cur;
    LOOP
    FETCH st_cur INTO st_rec;
    EXIT WHEN st_cur%NOTFOUND;
    --DBMS_OUTPUT.PUT_LINE(st_rec.school_year||' '||st_rec.class_s);
    IF st_rec.国語評価 = 'A' THEN student_check_1 := student_check_1+1;
    END IF;
    IF st_rec.数学評価 = 'A' THEN student_check_2 := student_check_2+1;
    END IF;
    IF st_rec.英語評価 = 'A' THEN student_check_3 := student_check_3+1;
    END IF;
    IF st_rec.理科評価 = 'A' THEN student_check_4 := student_check_4+1;
    END IF;
    IF st_rec.社会評価 = 'A' THEN student_check_5 := student_check_5+1;
    END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('国語成績がAの年生は'||student_check_1||'人、'||'数学成績がAのは'
    ||student_check_2||'人、'||'英語成績がAのは'||student_check_3||'人、'||'理科成績がAのは'
    ||student_check_4||'人、'||'社会成績がAのは'||student_check_5||'人です。');
    CLOSE st_cur;
END;

/*
DECLARE
school_year NUMBER(1);
PRODUCT_NAME varchar2(100);
st_count NUMBER;
CURSOR EX_CUR IS
    SELECT * FROM STUDENT_TBL;

BEGIN
OPEN EX_CUR;-- 2. 명시적 커서 오픈
DBMS_OUTPUT.PUT_LINE('제품코드  제품명');

LOOP
FETCH EX_CUR INTO PRODUCT_ID, PRODUCT_NAME; --커서에서 데이터 가져오기
EXIT WHEN EX_CUR %NOTFOUND; --커서가 없을 경우 종료
DBMS_OUTPUT.PUT_LINE(PRODUCT_ID||'  '||PRODUCT_NAME);
END LOOP;

CLOSE EX_CUR; --커서 닫기
END;*/

--더 간단한 방법
SET SERVEROUTPUT ON;
DECLARE
    CURSOR st_cur IS 
        SELECT * FROM z220608_grade_tbl_v;
    student_check_1 NUMBER := 0;
    student_check_2 NUMBER := 0;
    student_check_3 NUMBER := 0;
    student_check_4 NUMBER := 0;
    student_check_5 NUMBER := 0;
BEGIN
    FOR st_rec IN st_cur LOOP
    --DBMS_OUTPUT.PUT_LINE(st_rec.school_year||' '||st_rec.class_s);
    IF st_rec.国語評価 = 'A' THEN student_check_1 := student_check_1+1;
    END IF;
    IF st_rec.数学評価 = 'A' THEN student_check_2 := student_check_2+1;
    END IF;
    IF st_rec.英語評価 = 'A' THEN student_check_3 := student_check_3+1;
    END IF;
    IF st_rec.理科評価 = 'A' THEN student_check_4 := student_check_4+1;
    END IF;
    IF st_rec.社会評価 = 'A' THEN student_check_5 := student_check_5+1;
    END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('国語成績がAの年生は'||student_check_1||'人、'||'数学成績がAのは'
    ||student_check_2||'人、'||'英語成績がAのは'||student_check_3||'人、'||'理科成績がAのは'
    ||student_check_4||'人、'||'社会成績がAのは'||student_check_5||'人です。');
END;
