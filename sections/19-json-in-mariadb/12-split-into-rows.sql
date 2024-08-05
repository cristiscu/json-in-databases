-- JSON Split into Rows - see https://mariadb.com/kb/en/json_table/
use test;

-- expand array -->  1, 2, 3 on rows (array elements)
select *
from json_table('[1, 2, 3]', '$[*]'
	columns (value json path '$')) jt;

-- expand object --> 1, 2, 3 on rows (key values)
select *
from json_table('{"a":1, "b":2, "c":3}', '$.*'
	columns (value json path '$')) jt;

-- expand object --> values
select jt.*
from t2, json_table(j, '$.persons[0].*'
	columns (value json path '$')) jt;

-- ================================================
-- expand array --> elements
select jt.*
from t2, json_table(j, '$.persons[*]'
	columns (parent varchar(20) path '$.name')) jt;

-- expand nested array in array --> elements
select jt.*
from t2, json_table(j, '$.persons[0].children[*]'
  	columns (child varchar(20) path '$.name')) jt;

-- expand 2 nested arrays --> both elements
select jt.*
from t2, json_table(j, '$.persons[*]'
	columns (
		parent varchar(20) path '$.name',
    	nested path '$.children[*]'
    		columns (child varchar(20) path '$.name')
)) jt;

-- ================================================
-- expand arrays w/ all different clauses

select jt.*
from t2, json_table(j, '$.persons[*]'
  	columns (
    	id for ordinality,
		obj json path '$',
    	parent varchar(20) path '$.name',
    	age int path '$.age',
    	has_status boolean exists path '$.status',
    	nested path '$.children[*]'
    		columns (child varchar(20) path '$.name')
)) jt;

select jt.*
from t2, json_table(j, '$.persons[0].children[*]'
  	columns (
    	id for ordinality,
		obj json path '$',
    	child varchar(20) path '$.name',
    	has_status boolean exists path '$.status'
)) jt;

