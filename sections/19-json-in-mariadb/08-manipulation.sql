 -- JSON Manipulation Functions
use test;

-- =================================================
-- json_insert = insert new V values in X by P1... (ignored if there)
-- json_replace = update existing V values in X by P1... (ignored if missing)
-- json_set = (~upsert) update/insert V values in X by P1... (never ignored)
select j,
	json_pretty(json_insert(j,
		'$.store.book[1].isbn', '0-555-55555-1',
		'$.store.bicycle.color', 'blue')),
	json_pretty(json_replace(j,
		'$.store.book[1].isbn', '0-555-55555-1',
		'$.store.bicycle.color', 'blue')),
	json_pretty(json_set(j,
		'$.store.book[1].isbn', '0-555-55555-1',
		'$.store.bicycle.color', 'blue'))
from t1;

-- =================================================
-- json_merge_patch = merge docs (remove dups)
-- json_merge_preserve = ~json_merge, deprecated, to concatenate docs (w/ dups)
select json_extract(j, '$.store.bicycle') as bicycle
from t1;

select json_extract(j, '$.store.bicycle'),
	json_merge_patch(
		json_extract(j, '$.store.bicycle'),
		'{"color": "yellow", "status": ["new", "sold"]}'),
	json_merge_preserve(
		json_extract(j, '$.store.bicycle'),
		'{"color": "yellow", "status": ["new", "sold"]}')
from t1;

select
	json_merge_patch(
		'{"color": "red", "price": 19.95}',
		'{"color": "yellow", "status": ["new", "sold"]}'),
	json_merge_preserve(
		'{"color": "red", "price": 19.95}',
		'{"color": "yellow", "status": ["new", "sold"]}');

select
	json_merge_patch('[1, 2]', '[2, 3]'),
	json_merge_preserve('[1, 2]', '[2, 3]');

select
	json_merge_patch('{"a":1, "b":2}', '{"b":3, "c":4}'),
	json_merge_preserve('{"a":1, "b":2}', '{"b":3, "c":4}');

-- =================================================
-- json_remove = remove key-values at P1... keys in X (ignored if missing)
select j, json_pretty(json_remove(j, '$.store.book[1].isbn', '$.store.bicycle.color'))
from t1;
