-- JSON Aggregations

-- json_group_object
SELECT value, id, key
FROM t1, json_each(j, '$.store.book');

with cte as (
	SELECT value, id, key
	FROM t1, json_each(j, '$.store.book'))
select json_group_object(value -> '$.category', id)
FROM cte;

-- json_group_array
with cte as (
	SELECT value, id, key
	FROM t1, json_each(j, '$.store.book'))
select json_group_array(value)
FROM cte;

-- json_group_array/object
with cte as (
	SELECT value, id, key
	FROM t1, json_each(j, '$.store.book')),
cte2 as (
	select je.key, je.value
	from cte, json_each(cte.value) je),
cte3 as (
	select key, json_group_array(value) v
	FROM cte2
	GROUP BY key),
cte4 as (
	select json_pretty(json_group_object(key, v))
	FROM cte3)
SELECT * FROM cte4;
