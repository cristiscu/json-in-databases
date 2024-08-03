-- JSON Validation

-- json_pretty
-- json_valid
select j,
	json_pretty(j, ' ') as "pretty",
	json_valid(j) as "valid"
from t1;

-- json_valid
-- json_error_position
select json_valid('{"name": "John", "age": +35.22}') as "invalid",
	json_error_position('{"name": "John", "age": +35.22}') as "err_pos"
from t1;

-- json_type --> 'object', 'array'
select j,
	json_type(j) as "object",
	json_type(j, '$.store.book') as "array"
from t1;
