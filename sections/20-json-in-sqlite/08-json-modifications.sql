 -- JSON Manipulation Functions

-- =================================================
-- json_insert = insert new V values in X by P1... (ignored if there)
-- json_replace = update existing V values in X by P1... (ignored if missing)
-- json_set = (~upsert) update/insert V values in X by P1... (never ignored)
select j,
	json_insert(j,
		'$.store.book[1].isbn', '0-555-55555-1',
		'$.store.bicycle.color', 'blue') as "insert",
	json_replace(j,
		'$.store.book[1].isbn', '0-555-55555-1',
		'$.store.bicycle.color', 'blue') as "replace",
	json_set(j,
		'$.store.book[1].isbn', '0-555-55555-1',
		'$.store.bicycle.color', 'blue') as "set"
from t1;

-- =================================================
-- json_patch = merge/replace/append elems w/ keys from P to T
select bicycle,
	json_patch(bicycle,
	'{"color": "yellow", "status": ["new", "sold"]}') as "patch"
from (
	select json_extract(j, '$.store.bicycle') as bicycle
	from t1);

-- =================================================
-- json_remove = remove key-values at P1... keys in X (ignored if missing)
select j,
	json_remove(j,
		'$.store.book[1].isbn',
		'$.store.bicycle.color') as "remove"
from t1;
