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
-- json_value/query

-- NULL, NULL, 35, John
select j,
	json_value(j, '$.persons'),
	json_value(j, '$.persons[0]'),
	json_value(j, '$.persons[0].age'),
	json_value(j, '$.persons[0].name')
from t2;

-- [...], {...}, NULL, NULL
select j,
	json_query(j, '$.persons'),
	json_query(j, '$.persons[0]'),
	json_query(j, '$.persons[0].age'),
	json_query(j, '$.persons[0].name')
from t2;
