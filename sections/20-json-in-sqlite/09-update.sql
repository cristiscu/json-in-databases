-- JSON Update

-- drop table t3;
create table t3(j jsonb);

insert into t3(j)
values ('{"store":{"book":[{"category":"reference","author":"Nigel Rees","title":"Sayings of the Century","price":8.95},{"category":"fiction","author":"Evelyn Waugh","title":"Sword of Honour","price":12.99},{"category":"fiction","author":"Herman Melville","title":"Moby Dick","isbn":"0-553-21311-3","price":8.99},{"category":"fiction","author":"J. R. R. Tolkien","title":"The Lord of the Rings","isbn":"0-395-19395-8","price":22.99}],"bicycle":{"color":"red","price":19.95}}}');

select * from t3;

update t3
set j = json_set(j,
	'$.store.book[1].isbn', '0-555-55555-1',
	'$.store.bicycle.color', 'blue');

select * from t3;