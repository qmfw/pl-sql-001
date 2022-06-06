-- テーブル1 
create table zzz_menu_master (
    menu_code varchar2(4),
    menu_name varchar2(50),
    unit_price number,
    constraint zzz_menu_master_pk primary key(menu_code)
);

-- テーブル2
create table zzz_store_master (
    store_code varchar2(3),
    store_name varchar2(50),
    constraint zzz_store_master_pk primary key(store_code)
);

-- テーブル3
create table zzz_sales_income (
    sales_date date,
    store_code varchar2(3),
    receipt_num varchar2(5),
    menu_code varchar2(4),
    amount number,
    constraint zzz_sales_income_pk primary key(receipt_num)
);

-- テーブル1 >>> データ
insert into zzz_menu_master values ('a001', 'カルビ焼肉', 1500);
insert into zzz_menu_master values ('a002', 'キムチ', 300);
insert into zzz_menu_master values ('a003', 'チキン', 1850);
insert into zzz_menu_master values ('a004', 'ラーメン', 850);
insert into zzz_menu_master values ('a005', 'お寿司', 1200);
insert into zzz_menu_master values ('a006', 'サムゲタン', 1500);
insert into zzz_menu_master values ('a007', 'サムギョプサル', 1200);
insert into zzz_menu_master values ('a008', 'カレー', 550);
insert into zzz_menu_master values ('a009', 'うどん', 600);
insert into zzz_menu_master values ('a010', 'ドン勝つ', 650);
insert into zzz_menu_master values ('a011', 'スンドゥブ', 1000);
insert into zzz_menu_master values ('a012', 'コーラ', 200);
insert into zzz_menu_master values ('a013', 'スプライト', 200);

-- テーブル2 >>> データ
insert into zzz_store_master values ('s01', 'ソウル店');
insert into zzz_store_master values ('s02', '東京店');
insert into zzz_store_master values ('s03', '秋葉原店');
insert into zzz_store_master values ('s04', '竹ノ塚店');

-- テーブル3 >>> データ
insert into zzz_sales_income values ('2022-05-28', 's01', 'r0001', 'a001', 3);
insert into zzz_sales_income values ('2022-05-28', 's01', 'r0002', 'a002', 4);
insert into zzz_sales_income values ('2022-05-28', 's01', 'r0003', 'a012', 3);
insert into zzz_sales_income values ('2022-05-28', 's02', 'r0004', 'a008', 3);
insert into zzz_sales_income values ('2022-05-28', 's02', 'r0005', 'a009', 3);
insert into zzz_sales_income values ('2022-05-28', 's03', 'r0006', 'a008', 2);
insert into zzz_sales_income values ('2022-05-28', 's03', 'r0007', 'a009', 4);
insert into zzz_sales_income values ('2022-05-28', 's03', 'r0008', 'a010', 4);
insert into zzz_sales_income values ('2022-05-28', 's03', 'r0009', 'a013', 4);
insert into zzz_sales_income values ('2022-05-28', 's04', 'r0010', 'a003', 2);
insert into zzz_sales_income values ('2022-05-28', 's04', 'r0011', 'a006', 1);
insert into zzz_sales_income values ('2022-05-29', 's01', 'r0012', 'a007', 3);
insert into zzz_sales_income values ('2022-05-29', 's01', 'r0013', 'a011', 3);
insert into zzz_sales_income values ('2022-05-29', 's02', 'r0014', 'a002', 2);
insert into zzz_sales_income values ('2022-05-29', 's02', 'r0015', 'a003', 3);
insert into zzz_sales_income values ('2022-05-29', 's02', 'r0016', 'a012', 3);
insert into zzz_sales_income values ('2022-05-29', 's03', 'r0017', 'a004', 2);
insert into zzz_sales_income values ('2022-05-29', 's03', 'r0018', 'a013', 1);
insert into zzz_sales_income values ('2022-05-29', 's04', 'r0019', 'a009', 1);
insert into zzz_sales_income values ('2022-05-29', 's04', 'r0020', 'a010', 2);
insert into zzz_sales_income values ('2022-05-30', 's01', 'r0021', 'a006', 3);
insert into zzz_sales_income values ('2022-05-30', 's01', 'r0022', 'a007', 2);
insert into zzz_sales_income values ('2022-05-30', 's02', 'r0023', 'a004', 3);
insert into zzz_sales_income values ('2022-05-30', 's02', 'r0024', 'a010', 3);
insert into zzz_sales_income values ('2022-05-30', 's03', 'r0025', 'a005', 5);
insert into zzz_sales_income values ('2022-05-30', 's03', 'r0026', 'a008', 4);
insert into zzz_sales_income values ('2022-05-30', 's03', 'r0027', 'a009', 3);

-- corresponding データ by 月/日
select zzz_sales_income.sales_date, sum(zzz_menu_master.unit_price*zzz_sales_income.amount) as "合計"
from zzz_sales_income, zzz_menu_master
where zzz_sales_income.menu_code = zzz_menu_master.menu_code 
group by zzz_sales_income.sales_date;

select zzz_sales_income.sales_date, sum(zzz_menu_master.unit_price*zzz_sales_income.amount) as "合計"
from zzz_sales_income, zzz_menu_master
group by zzz_sales_income.sales_date;

select sales_date,	
	store_name,
	sum(unit_price*amount) as "合計"
from zzz_sales_income_v 	
group by sales_date, store_name	
order by sales_date, store_name;	

select store_name, 	
	 menu_name,
	sum(amount) as "合計"
from zzz_sales_income_v 	
group by store_name, menu_name 
order by store_name, menu_name;	

select store_name, 	
	 menu_name,
	sum(amount) as "合計"
from zzz_sales_income_v 	
group by store_name, menu_name	
having sum(amount) >= 5	
order by store_name, menu_name;	

select store_name, 	
	 menu_name,
	sum(amount) as "合計"
from zzz_sales_income_v 	
where amount >= 5 	
group by store_name, menu_name	
order by store_name, menu_name;	



select sales_date, store_name, sum(unit_price*amount) as "合計" from zzz_sales_income_v 
group by sales_date, store_name order by sales_date;

select store_name, menu_name, sum(amount) as "合計" from zzz_sales_income_v 
group by store_name, menu_name order by store_name;


-- すべてのデータ
select sales_date, store_code, receipt_num, menu_code, amount from zzz_sales_income;
select * from zzz_menu_master;
select * from zzz_store_master;
select * from zzz_sales_income;
select * from zzz_sales_income_v;

-- データ
update zzz_sales_income set menu_code = 'z001' where receipt_num = 'r0001';
commit;

select A.sales_date, A.store_code, B.store_name, A.receipt_num, A.menu_code, A.amount
from zzz_sales_income A inner join zzz_store_master B on B.store_code = A.store_code;

select A.sales_date, A.store_code, B.store_name, A.receipt_num, A.menu_code, c.menu_name, c.unit_price, A.amount 
from zzz_sales_income A inner join zzz_store_master B on B.store_code = A.store_code
inner join zzz_menu_master C on C.menu_code = A.menu_code;

select A.sales_date, A.store_code, B.store_name, A.receipt_num, A.menu_code, c.menu_name, c.unit_price, A.amount 
from zzz_sales_income A left join zzz_store_master B on B.store_code = A.store_code
left join zzz_menu_master C on C.menu_code = A.menu_code;

create or replace view zzz_sales_income_v as select 
A.sales_date, A.store_code, B.store_name, A.receipt_num, A.menu_code, c.menu_name, c.unit_price, A.amount 
from zzz_sales_income A left join zzz_store_master B on B.store_code = A.store_code
left join zzz_menu_master C on C.menu_code = A.menu_code;

-- テーブルの削除
drop table zzz_menu_master;
drop table zzz_store_master;
drop table zzz_sales_income;
drop view  zzz_sales_income_v;

/*
transaction + master : left join
物理削除と論理削除
物理削除：DELETE文で実データを消す
論理削除：有効フラグ、有効終了日、とかで使用しているかを判断
SELECT * FROM 商品マスタ WHERE 有効フラグ = 'Y'

select myview_1.sales_date, myview_1.store_name, sum(myview_1.unit_price*myview_1.amount) as "合計" 
from myview_1, zzz_menu_master
where myview_1.menu_code = zzz_menu_master.menu_code 
group by myview_1.sales_date, myview_1.store_name;

select myview_1.sales_date, myview_1.store_name, sum(myview_1.unit_price*myview_1.amount) as "合計" 
from myview_1, zzz_store_master
where myview_1.store_code = zzz_store_master.store_code 
group by myview_1.sales_date, myview_1.store_name;

select zzz_sales_income.sales_date, zzz_store_master.store_name, sum(zzz_menu_master.unit_price*zzz_sales_income.amount) as "合計"
from zzz_sales_income, zzz_menu_master, zzz_store_master
where zzz_sales_income.menu_code = zzz_menu_master.menu_code and zzz_store_master.store_code = zzz_sales_income.store_code 
group by zzz_sales_income.sales_date, zzz_store_master.store_name;

*/