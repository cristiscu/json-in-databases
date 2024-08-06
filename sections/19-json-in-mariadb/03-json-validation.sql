-- JSON Validation: json_valid, json_schema_valid
use test;

select
	json_valid('{"name":"John", "age":35}'),
	json_valid('{"name":"John", "age":W35}');

select
	json_schema_valid(
		'{ "properties": { "age": { "maximum":40 }, "name": { "maxLength":10 }}}',
		'{ "name":"John", "age":35 }'),
	json_schema_valid(
		'{ "properties": { "age": { "maximum":30 }, "name": { "maxLength":3 }}}',
		'{ "name":"John", "age":35 }');
