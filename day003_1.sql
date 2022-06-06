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
select zzz_sales_income.sales_date, zzz_store_master.store_name, sum(zzz_menu_master.unit_price*zzz_sales_income.amount) as "合計"
from zzz_sales_income, zzz_menu_master, zzz_store_master
where zzz_sales_income.menu_code = zzz_menu_master.menu_code and zzz_store_master.store_code = zzz_sales_income.store_code 
group by zzz_sales_income.sales_date, zzz_store_master.store_name;

select zzz_sales_income.sales_date, sum(zzz_menu_master.unit_price*zzz_sales_income.amount) as "合計"
from zzz_sales_income, zzz_menu_master
where zzz_sales_income.menu_code = zzz_menu_master.menu_code 
group by zzz_sales_income.sales_date;

-- すべてのデータ
select * from zzz_menu_master;
select * from zzz_store_master;
select * from zzz_sales_income;

-- テーブルの削除
drop table zzz_menu_master;
drop table zzz_store_master;
drop table zzz_sales_income;


