--sqlplus apps/apps@t06db
--Ykkap@345

CREATE TABLE T1 (
	XXNUMBER NUMBER,
	COL_A VARCHAR(3),
	col_B VARCHAR(1),
	LAST_UPDATE_DATE DATE
);

SELECT * FROM T1;
INSERT INTO T1 VALUES (1,'ABC','1',SYSDATE);
INSERT INTO T1 VALUES (2,'ABC','1',SYSDATE);
INSERT INTO T1 VALUES (3,'ABC','1',SYSDATE);

INSERT INTO T1 VALUES (1,'ABC','1',SYSDATE);

CREATE TABLE T2 (
	XXNUMBER NUMBER,
	COL_A VARCHAR(3),
	col_B VARCHAR(1),
	LAST_UPDATE_DATE DATE,
	CONSTRAINT T2_PK PRIMARY KEY(XXNUMBER)
);

INSERT INTO T2 VALUES (1,'ABC','1',SYSDATE);
INSERT INTO T2 VALUES (2,'ABC','1',SYSDATE);
INSERT INTO T2 VALUES (1,'ABC','1',SYSDATE);