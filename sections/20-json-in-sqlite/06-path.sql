-- JSON Path Expressions

-- ===============================================
-- drop table t2;
create table t2(j jsonb);

insert into t2
values ('{"persons":[{"name": "John", "status": "married", "age": 35, "children": [{ "name": "George" }, { "name": "Mary" }]}]}');

select * from t2;

-- ===============================================
-- (X -> P) and (X ->> P) operators
select
	j,
	j -> '$.persons[0].name' as name1,
	cast(j -> '$.persons[0].name' as text) as name2,
	cast(j ->> '$.persons[0].name' as text) as name3
from t2;

-- '$.persons[0]["age"]' --> NULL (not supported!)
select
	j,
	j -> '$.persons[0]["age"]' as age1,
	j -> '$.persons[0].age' as age2,
	j ->> '$.persons[0].age' as age3
from t2;

-- json_extract ~= (X ->> P)
select
	j,
	j ->> '$.persons[0].children[1].name' as name1,
	j ->> '$.persons[0].children[#-1].name' as name2,
	json_extract(j, '$.persons[0].children[1].name') as name3
from t2;
