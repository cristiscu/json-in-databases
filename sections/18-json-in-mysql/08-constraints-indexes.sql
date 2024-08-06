-- JSON Constraints and Indexes
use test;

-- ========================================================
-- second INSERT will fail w/ invalid JSON
create or replace table t4(j json check(json_valid(j)));
insert into t4 values ('{"id": 1, "name": "John"}');
insert into t4 values ('{"id": 2, "name": Mary}');
select * from t4;

-- add additional constraint on the JSON docs --> first INSER will fail
alter table t4
    add constraint check_json
    check (json_type(j) = 'OBJECT' and json_length(j) = 2);
insert into t4 values ('[{"id": 2, "name": "Mary"}]');
insert into t4(j) values ('{"id": 2, "name": "Mary"}');

-- ========================================================
-- create virtual column (~calculated) based on JSON value
alter table t4
	add column name varchar(20)
   as (json_value(j, '$.name')) virtual;
select * from t4;

-- create index on the new virtual column
create index name_idx on t4(name);
select * from t4;
