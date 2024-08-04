-- JSON Split into Rows - see https://mariadb.com/kb/en/json_table/

-- extract subdocument into a column --> [1,2,3,4]
select * from json_table('{"foo": [1,2,3,4]}', '$'
  columns (
    jscol json path '$.foo')
) as jt;

-- COLUMNS w/ PATH
set @json='[
  {"name":"Laptop", "color":"black", "price":"1000"},
  {"name":"Jeans",  "color":"blue"}]';

select * from json_table(@json, '$[*]' 
  columns (
   name  varchar(10) path '$.name', 
   color varchar(10) path '$.color',
   price decimal(8,2) path '$.price') 
) as jt;

-- COLUMNS w/ ORDINALITY
set @json='[
  {"name":"Laptop", "color":"black"},
  {"name":"Jeans",  "color":"blue"}]';

select * from json_table(@json, '$[*]' 
  columns (
   id for ordinality, 
   name  varchar(10) path '$.name')
) as jt;

-- COLUMNS w/ EXISTS PATH
set @json='[
  {"name":"Laptop", "color":"black", "price":1000},
  {"name":"Jeans",  "color":"blue"}]';

select * from json_table(@json, '$[*]' 
  columns (
   name  varchar(10) path '$.name',
   has_price integer exists path '$.price')
) as jt;

-- ====================================================
-- COLUMNS w/ NESTED PATH
set @json='[
  {"name":"Jeans",  "sizes": [32, 34, 36]},
  {"name":"T-Shirt", "sizes":["Medium", "Large"]},
  {"name":"Cellphone"}]';
select * from json_table(@json, '$[*]' 
  columns (
    name  varchar(10) path '$.name', 
    nested path '$.sizes[*]' columns (size varchar(32) path '$'))
) as jt;

set @json='[{"name":"Jeans", "sizes": [32, 34, 36], "colors":["black", "blue"]}]';
select * from json_table(@json, '$[*]' 
  columns (
    name  varchar(10) path '$.name', 
    nested path '$.sizes[*]' columns (size varchar(32) path '$'),
    nested path '$.colors[*]' columns (color varchar(32) path '$'))
) as jt;


-- ===========================================
-- JSON Split into Rows

SELECT * FROM t1;

-- json_each
SELECT value, id, key
FROM t1, json_each(j, '$.store');

SELECT value, id, key
FROM t1, json_each(j, '$.store.bicycle');

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
