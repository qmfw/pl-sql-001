create table ppl (
    pref_name varchar2(10),
    cate varchar2(10),
    population number
);

insert into ppl values ('kkk','aaa',300);
insert into ppl values ('kka','aaa',300);
insert into ppl values ('kkb','bbb',50);
insert into ppl values ('kkc','bbb',40);

select * from ppl;

select
    case
        when pref_name in ('kka', 'kkb') then 'unji'
        when pref_name in ('kkc', 'kkk') then 'jeondoohwan'
        else null
        end as distrit, sum(population)
from ppl
group by
    case
        when pref_name in ('kka', 'kkb') then 'unji'
        when pref_name in ('kkc', 'kkk') then 'jeondoohwan'
        else null
        end;

select
    case
        when pref_name in ('kka', 'kkb') then 'unji'
        when pref_name in ('kkc', 'kkk') then 'jeondoohwan'
        else null
        end as dist, population
from ppl;

select pref_name,
    case
        when pref_name in ('kka', 'kkb') then 'unji'
        when pref_name in ('kkc', 'kkk') then 'jeondoohwan'
        else null
        end as population
from ppl;

select pref_name,
    case
        when pref_name in ('kka', 'kkb') then 'unji'
        when pref_name in ('kkc', 'kkk') then 'jeondoohwan'
        else null
        end as dist, population
from ppl;

drop table ppl;






select * from ppl;

select * from ppl 
where population > (select avg(population) from ppl);


select * from ppl p1
where population >= (select avg(population) from ppl p2
                    where p1.cate = p2.cate
                    group by cate);