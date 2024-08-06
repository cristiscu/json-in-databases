-- JSON Constructors: json_object/array, json_objectagg/arrayagg
use test;

-- {}, {"name": "John", "status": null, "age": 35}
select json_object(),
	json_object('name', 'John', 'status', NULL, 'age', 35),
	json_object("name", "John", "status", NULL, "age", 35);

-- [], ["John", null, 35]
select json_array(),
	json_array('John', NULL, 35),
	json_array("John", NULL, 35);

with books as (
	select "Nigel Rees" as author, "Sayings of the Century"as title
	union select "Evelyn Waugh", "Sword of Honour"
	union select "Herman Melville", "Moby Dick")
select
	json_pretty(json_objectagg(author, title)),
	json_pretty(json_arrayagg(json_object("author", author, "title", title)))
from books;

