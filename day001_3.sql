--無名ブロックを作成し、T2にデータを作成します。
--重複データを登録しようとしたら、データが重複していますと表示するプログラム。
--sqlplus apps/apps@t06db
--Ykkap@345

CREATE TABLE T2 (
	XXNUMBER NUMBER,
	COL_A VARCHAR(3),
	col_B VARCHAR(1),
	LAST_UPDATE_DATE DATE,
	CONSTRAINT T2_PK PRIMARY KEY(XXNUMBER)
);

ALTER TABLE T2 ADD UNIQUE(COL_A, COL_B, LAST_UPDATE_DATE);

INSERT INTO T2 VALUES (1,'ABC','1',SYSDATE);
INSERT INTO T2 VALUES (1,'BCD','2',SYSDATE+1);
INSERT INTO T2 VALUES (2,'ABC','1',SYSDATE);
INSERT INTO T2 VALUES (3,'BCD','2',SYSDATE+1); --大丈夫

ALTER TABLE T2 ADD CONSTRAINT T2_MULTI UNIQUE(COL_A, COL_B, LAST_UPDATE_DATE);

CREATE TABLE T3 (
	XXNUMBER NUMBER,
	COL_A VARCHAR(3) UNIQUE,
	col_B VARCHAR(1) UNIQUE,
	LAST_UPDATE_DATE DATE UNIQUE,
	CONSTRAINT T3_PK PRIMARY KEY(XXNUMBER)
);

INSERT INTO T3 VALUES (1,'ABC','1',SYSDATE);
INSERT INTO T3 VALUES (1,'BCD','2',SYSDATE+1); --不可能
INSERT INTO T3 VALUES (2,'ABC','1',SYSDATE);   --不可能
INSERT INTO T3 VALUES (2,'BCD','2',SYSDATE+1); --大丈夫