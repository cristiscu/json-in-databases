-- JSON Update
use test;

create or replace table t3(j json) as select j from t1;
select * from t3;

-- change color to blue (isbn ignored)
select j, json_pretty(json_set(j,
	'$.store.book[1].isbn', '0-555-55555-1',
	'$.store.bicycle.color', 'blue'))
from t3;

update t3
set j = json_pretty(json_set(j,
	'$.store.book[1].isbn', '0-555-55555-1',
	'$.store.bicycle.color', 'blue'));

-- insert NEW book object after first book in array
select j, json_pretty(json_array_insert(j, '$.store.book[1]', 
	json_pretty('{"title":"NEW", "author":"NEW"}')))
from t3;

update t3
set j = json_pretty(json_array_insert(j, '$.store.book[1]',
	json_pretty('{"title":"NEW", "author":"NEW"}')));

select j from t3;
