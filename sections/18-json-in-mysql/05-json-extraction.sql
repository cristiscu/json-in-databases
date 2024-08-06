-- JSON Extraction: json_keys, json_value/extract
use test;

-- =================================================
-- json_keys

-- ["a", "b", "c"]
select json_keys('{"a":1, "b":2, "c":3}');

-- ["name", "status", "age", "children"]
select j, json_keys(j, '$.persons[0]') from t2;

-- =================================================
-- json_value

-- NULL, NULL, 35, John
select j,
	json_value(j, '$.persons'),
	json_value(j, '$.persons[0]'),
	json_value(j, '$.persons[0].age'),
	json_value(j, '$.persons[0].name')
from t2;

-- =================================================
-- json_extract

-- [...] --> 1, {...} --> 4, 35 --> 1, "John" --> 1, [...] --> 2
select j,
	json_extract(j, '$.persons'), json_length(j, '$.persons'),
	json_extract(j, '$.persons[0]'), json_length(j, '$.persons[0]'),
	json_extract(j, '$.persons[0].age'), json_length(j, '$.persons[0].age'),
	json_extract(j, '$.persons[0].name'), json_length(j, '$.persons[0].name'),
	json_extract(j, '$.persons[0].children'), json_length(j, '$.persons[0].children')
from t2;

-- ["John", 35]
select j,
	json_extract(j, '$.persons[0].age', '$.persons[0].name')
from t2;

-- NULL, "John", John, "John"
select j,
	json_extract(j, '$.persons[0]["name"]'),
	json_extract(j, '$.persons[0]."name"'),
	json_unquote(json_extract(j, '$.persons[0].name')),
	json_quote(json_unquote(json_extract(j, '$.persons[0].name')))
from t2;

-- 6, 4
select j,
	json_depth(j),
	json_depth(json_extract(j, '$.persons[0]'))
from t2;

-- =====================================================================
-- json_extract w/ array indices

-- "Mary", "Mary", "George", ["George", "Mary"]
select j,
	json_extract(j, '$.persons[0].children[1].name'),
	json_extract(j, '$.persons[0].children[-1].name'),
	json_extract(j, '$.persons[0].children[last-1].name'),
	json_extract(j, '$.persons[0].children[0 to 1].name')
from t2;

-- [[4], 5, 6]
select json_extract('[[1, 2], [3, [4], 5, 6]]', '$[1][1 to 3]');

-- =====================================================================
-- json_extract w/ * wildcards

-- object/array --> array of values/elements: [1, 2, 3] for both
select
	json_extract('{"a":1, "b":2, "c":3}', '$.*'),
	json_extract('[1, 2, 3]', '$[*]');

-- object --> array of values: ["John", "married", 35, [{"name": "George"}, {"name": "Mary"}]]
select j, json_extract(j, '$.persons[0].*')
from t2;

-- array --> array of elements: [{"name": "George"}, {"name": "Mary"}]
select j, json_extract(j, '$.persons[0].children[*]')
from t2;

-- =====================================================================
-- json_extract w/ ** wildcards

-- ["John", "George", "Mary"]
select j, json_extract(j, '$**.name')
from t2;

-- ["Mary"]
select j, json_extract(j, '$**[0]**[1].name')
from t2;

-- =====================================================================
-- member of

-- 1, 0, 1
select
	2 member of ('[1, 2, 3]'),
	10 member of ('[1, 2, 3]'),
	'{ "name":"John", "age":35 }' member of ('[{ "name":"Mary", "age":22 }, { "name":"John", "age":35 }]');

-- 1, 0
select j
	'{ "name": "Mary" }' member of (json_query(j, '$.persons[0].children')),
	'{ "name": "Laura" }' member of (json_query(j, '$.persons[0].children'))
from t2;
