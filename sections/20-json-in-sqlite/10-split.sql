-- JSON Split into Rows

-- json_each
SELECT value, id, key
FROM t1, json_each(j, '$.store.book');

-- 2-levels json_each
with cte as (
	SELECT value, id, key
	FROM t1, json_each(j, '$.store.book'))
select je.key, je.value
from cte, json_each(cte.value) je;

-- json_tree
SELECT value, id, key
FROM t1, json_tree(j, '$.store')
WHERE type = 'object';
