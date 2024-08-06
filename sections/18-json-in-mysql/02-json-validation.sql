-- JSON Validation: json_valid, json_schema_valid, json_schema_validation_report
-- see https://dev.mysql.com/doc/refman/9.0/en/json-validation-functions.html
use test;

-- 1, 0 (W35 not a number)
select
	json_valid('{"name":"John", "age":35}'),
	json_valid('{"name":"John", "age":W35}');

set @schema = '{ "properties": { "age": { "maximum":30 }, "name": { "maxLength":4 }}}';
select @schema, json_pretty(@schema);

-- 1 --> { "valid": true }, 0 --> { "valid": false, ... }
select
	json_schema_valid(@schema, '{ "name":"John", "age":35 }'),
	json_schema_validation_report(@schema, '{ "name":"John", "age":35 }'),
	json_schema_valid(@schema, '{ "name":"Frederic", "age":45 }'),
	json_pretty(json_schema_validation_report(@schema, '{ "name":"Frederic", "age":45 }'));

/*
{
  "valid": false,
  "reason": "The JSON document location '#/longitude' failed requirement 'maximum' at JSON Schema location '#/properties/longitude'",
  "schema-location": "#/properties/longitude",
  "document-location": "#/longitude",
  "schema-failed-keyword": "maximum"
}
*/