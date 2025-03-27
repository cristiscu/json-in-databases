-- JSON Path Syntax: https://dev.mysql.com/doc/refman/9.0/en/json.html#json-path-syntax
use test;

create or replace table t2(j json)
as select json_pretty('{
	"persons":[{
		"name": "John",
		"status": "married",
		"age": 35,
	 	"children": [
		 	{ "name": "George" },
			{ "name": "Mary" }
		]}
	]}') j;

select * from t2;

-- =================================================
-- json_exists/contains/contains_path/search

-- 1, 0
select j,
	json_exists(j, '$.persons'),
	json_exists(j, '$.persons2')
from t2;

-- 1, 0
select j,
	json_contains(j, 35, '$.persons[0].age'),
	json_contains(j, 30, '$.persons[0].age')
from t2;

-- 1, 0
select j,
	json_contains_path(j, 'one', '$.persons[0].age', '$.persons[0].name1'),
	json_contains_path(j, 'all', '$.persons[0].age', '$.persons[0].name1')
from t2;

-- "$.persons[0].children[1].name", NULL
select j,
	json_search(j, 'one', 'Mary'),
	json_search(j, 'all', 30)
from t2;

-- =================================================
-- json_overlaps

-- 0, 1
select
	json_overlaps('{ "name":"John", "age":35 }', '{ "age2":35, "name":"John2" }'),
	json_overlaps('{ "name":"John", "age":35 }', '{ "age2":35, "name":"John" }');

-- 0 --> NULL, 1 --> [3]
select
	json_overlaps('[1, 2, 3]', '[4, 5, null]'),
	json_overlaps('[1, 2, 3]', '[3, 5, null]');
