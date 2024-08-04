-- JSON Update
use test;

create or replace table t3(j json)
as select j from t1;
select * from t3;

update t3
set j = json_set(j,
	'$.store.book[1].isbn', '0-555-55555-1',
	'$.store.bicycle.color', 'blue');

select json_pretty(j) from t3;
