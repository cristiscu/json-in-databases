-- JSON Path Expressions

-- no obj["prop"] path
SELECT json_extract(j, '$.store.bicycle["color"]') as str2
FROM t1;

-- json_extract = get obj/arr/value
-- json_array_length
SELECT json_extract(j, '$.store.book[1]') as obj,
	json_extract(j, '$.store.bicycle.color') as str,
	json_extract(j, '$.store.bicycle.price') as intgr,
	json_array_length(json_extract(j, '$.store.book')) as len
FROM t1;

-- X -> P operator
SELECT j -> '$.store.book[1]' as obj,
	j -> '$.store.bicycle.color' as str,
	j -> '$.store.bicycle.price' as intgr
FROM t1;

-- X ->> P operator
SELECT j ->> '$.store.book[1]' as obj,
	j ->> '$.store.bicycle.color' as str,
	j ->> '$.store.bicycle.price' as intgr
FROM t1;

-- json_quote = str (JSON) --> "str" (SQL)
SELECT json_quote(j ->> '$.store.book[1]') as obj,
	json_quote(j ->> '$.store.bicycle.color') as str,
	json_quote(j ->> '$.store.bicycle.price') as intgr
FROM t1;
