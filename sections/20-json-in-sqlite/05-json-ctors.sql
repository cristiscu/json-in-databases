-- JSON Constructors

-- json_object
select
	-- json('') as empty,
	json('{"name": "John", "status": null, "age": 35}') as obj1,
	jsonb('{"name": "John", "status": null, "age": 35}') as obj1b,
	json_object('name', 'John', 'status', NULL, 'age', 35) as obj2,
	json_object() as obj_empty;

-- json_array
select
	json('["John", null, 35]') as arr1,
	jsonb('["John", null, 35]') as arr1b,
	json_array('John', NULL, 35) as arr2,
	json_array() as arr_empty;
