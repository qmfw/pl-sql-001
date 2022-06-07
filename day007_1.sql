create table unji (
	num1 number constraints check1 check (num1 between 1 and 9),
	gender varchar2(10) constraints check2 check (gender in ('male','female'))
);

drop table unji;
select * from unji;
insert into unji values (1,'male');



create sequence myseq1
increment by 1
start with 1
minvalue 0
maxvalue 70
nocycle
nocache;

create table unji2 (
    unji_num number
);

insert into unji2 values (myseq1.nextval);
select * from unji2;
drop table unji2;
drop sequence myseq1;
