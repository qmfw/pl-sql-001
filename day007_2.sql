CREATE TABLE memberTBL (
	userid varchar2(10),
	username varchar2(10),
	addr varchar2(2)
);

INSERT INTO memberTBL VALUES ('LSG','이승기','서울');
INSERT INTO memberTBL VALUES ('KBS','김범수','경남');
INSERT INTO memberTBL VALUES ('KKH','김경호','전남');
INSERT INTO memberTBL VALUES ('JYP','조용필','경기');
INSERT INTO memberTBL VALUES ('SSK','성시경','서울');
INSERT INTO memberTBL VALUES ('LJB','임재범','서울');

CREATE TABLE changeTBL (
	userid varchar2(10),
	username varchar2(10),
	addr varchar2(2),
	changeType varchar2(4)
);

INSERT INTO changeTBL VALUES ('TKV','태권브이','한국','신규가입');
INSERT INTO changeTBL VALUES ('LSG',  null ,'제주','주소변경');
INSERT INTO changeTBL VALUES ('LJB',  null ,'영국','주소변경');
INSERT INTO changeTBL VALUES ('SSK',  null ,'탈퇴','회원탈퇴');


select * from memberTBL;
drop table memberTBL;

select * from changeTBL;
drop table changeTBL;

MERGE INTO memberTBL M --변경될 테이블 (target 테이블)
-- 변경할 기준이 되는 테이블 (source 테이블)
USING (SELECT changeType, userID, userName, addr FROM changeTBL) C
ON (M.userID = C.userID) --userID 를 기준으로 두 테이블을 비교한다
--target 테이블에 source 테이블의 행이 있으면 주소를 변경한다.
WHEN MATCHED THEN
UPDATE SET M.addr = C.addr
--target 테이블에 source 테이블의 행이 있고, 사유가 '회원탈퇴'라면 해당 행을 삭제한다.
DELETE WHERE C.changeType = '회원탈퇴'
--target 테이블에 source 테이블의 행이 없으면 새로운 행을 추가한다.
WHEN NOT MATCHED THEN
INSERT (userID, userName, addr) VALUES(C.userID, C.userName, C.addr);




-- GOOGLE PLAY BOOK ORACLE EXAMPLE
MERGE INTO ex3_3 d
USING (SELECT employee_id, salary, manager_id FROM employees WHERE manager_id = 146) b
ON (d.employee_id = b.employee_id)
WHEN MATCHED THEN UPDATE SET d.bonus_amt = d.bonus_amt + b.salary*0.01
WHEN NOT MATCHED THEN INSERT (d.employee_id, d.bonus_amt) VALUES (b.employee_id, b.salary *.001)
WHERE (b.salary<8000);


/*
CREATE TABLE SourceProducts(
    ProductID		INT,
    ProductName		VARCHAR(50),
    Price		DECIMAL(9,2)
);
    
INSERT INTO SourceProducts(ProductID,ProductName, Price) VALUES(1,'Table',100);
INSERT INTO SourceProducts(ProductID,ProductName, Price) VALUES(2,'Desk',80);
INSERT INTO SourceProducts(ProductID,ProductName, Price) VALUES(3,'Chair',50);
INSERT INTO SourceProducts(ProductID,ProductName, Price) VALUES(4,'Computer',300);

CREATE TABLE TargetProducts(
    ProductID		INT,
    ProductName		VARCHAR(50),
    Price		DECIMAL(9,2)
);
    
INSERT INTO TargetProducts(ProductID,ProductName, Price) VALUES(1,'Table',100);
INSERT INTO TargetProducts(ProductID,ProductName, Price) VALUES(2,'Desk',180);
INSERT INTO TargetProducts(ProductID,ProductName, Price) VALUES(5,'Bed',50);
INSERT INTO TargetProducts(ProductID,ProductName, Price) VALUES(6,'Cupboard',300);

SELECT * FROM SourceProducts left join TargetProducts;
*/
