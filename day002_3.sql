create table a1 (
    xnumber NUMBER PRIMARY KEY NOT NULL,
    ynumber NUMBER(3,1),
    col_a VARCHAR(3) UNIQUE,
    ydate DATE
);

insert into a1 values (1, 7, 'abc', sysdate);
insert into a1 values (2, 8, 'def', sysdate-30);
insert into a1 values (3, 7, 'ghi', sysdate-30);

select * from a1;
select col_a, length(col_a) as bi from a1;
select col_a from a1 where ydate<'2022-06-26';
select col_a from a1 where col_a='abc';
select col_a from a1 order by ynumber desc, col_a desc;
select ynumber, sum(ynumber) from a1 group by ynumber;
select ynumber, count(*) as ycnt from a1 group by ynumber having count(*)>0;


drop table a1;

create table order_items (
    order_id number(12,0),
    line_item_id number(3,0),
    product_id number(3,0),
    unit_price number(8,2) default 0,
    quantity number(8,0) default 0,
    constraint tb_order_id primary key(order_id, line_item_id)
);
insert into order_items values (555, 167, 254, default, default);
select * from order_items;
drop table order_items;




CREATE TABLE T2 (
	XXNUMBER NUMBER,
	COL_A VARCHAR(3),
	col_B VARCHAR(1),
	LAST_UPDATE_DATE DATE,
	CONSTRAINT T2_PK PRIMARY KEY(XXNUMBER)
);

ALTER TABLE T2 ADD UNIQUE(COL_A);
ALTER TABLE T2 ADD UNIQUE(COL_B);
ALTER TABLE T2 ADD UNIQUE(LAST_UPDATE_DATE);
ALTER TABLE T2 ADD CONSTRAINT last_d UNIQUE(last_update_date);

INSERT INTO T2 VALUES (1,'ABC','1',SYSDATE);
INSERT INTO T2 VALUES (1,'BCD','2',SYSDATE+1);
INSERT INTO T2 VALUES (2,'AtC','2',SYSDATE);
INSERT INTO T2 VALUES (3,'ACD','3',SYSDATE+1); --大丈夫

select * from t2;
drop table t2;


CREATE TABLE T3 (
	XXNUMBER NUMBER,
	COL_A VARCHAR(3) UNIQUE,
	col_B VARCHAR(1) UNIQUE,
	LAST_UPDATE_DATE DATE UNIQUE,
	CONSTRAINT T3_PK PRIMARY KEY(XXNUMBER)
);

INSERT INTO T3 VALUES (1,'ABC','1',SYSDATE);
INSERT INTO T3 VALUES (1,'BCD','2',SYSDATE+1); --不可能
INSERT INTO T3 VALUES (2,'ABd','2',SYSDATE);   --不可能
INSERT INTO T3 VALUES (2,'BCD','2',SYSDATE+1); --大丈夫

select * from t3;
drop table t3;
