-- JSON Sets: json_array_intersect, json_overlaps, json_object_to_array
use test;

-- 0, 1
select
	json_overlaps('{ "name":"John", "age":35 }', '{ "age2":35, "name":"John2" }'),
	json_overlaps('{ "name":"John", "age":35 }', '{ "age2":35, "name":"John" }');

-- 0 --> NULL, 1 --> [3]
select
	json_overlaps('[1, 2, 3]', '[4, 5, null]'),
	json_array_intersect('[1, 2, 3]', '[4, 5, null]'),
	json_overlaps('[1, 2, 3]', '[3, 5, null]'),
	json_array_intersect('[1, 2, 3]', '[3, 5, null]');

-- [["name", "John"], ["status", null], ["age", 35]]
select json_object_to_array(
	json_object('name', 'John', 'status', NULL, 'age', 35));

-- [["age", 35]]
select json_array_intersect(
	json_object_to_array(
		json_object('age', 35, 'name', 'Mark')),
 	json_object_to_array(
		json_object('name', 'John', 'status', NULL, 'age', 35)));
