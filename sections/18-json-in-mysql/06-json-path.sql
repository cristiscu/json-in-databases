-- JSON Path Expressions: https://mariadb.com/kb/en/jsonpath-expressions/
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
-- json_keys, json_object_filter_keys

-- ["a", "b", "c"], {"a": 1, "c": 3}
select j,
	json_keys('{"a":1, "b":2, "c":3}'),
	json_object_filter_keys('{"a":1, "b":2, "c":3}', '["a", "c"]')
from t2;

-- ["name", "status", "age", "children"], {"name": "John", "age": 35}
select j,
	json_keys(j, '$.persons[0]'),
	json_object_filter_keys(json_extract(j, '$.persons[0]'), '["age", "name"]')
from t2;
