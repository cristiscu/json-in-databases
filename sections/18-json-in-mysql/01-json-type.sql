-- JSON native data type: see https://dev.mysql.com/doc/refman/9.0/en/json.html

-- should be v8.0+ (2018)
select version();

-- create and select test database;
CREATE DATABASE test;
USE test;

set @json='{
    "store": {
        "book": [
            {
                "category": "reference",
                "author": "Nigel Rees",
                "title": "Sayings of the Century",
                "price": 8.95
            },
            {
                "category": "fiction",
                "author": "Evelyn Waugh",
                "title": "Sword of Honour",
                "price": 12.99
            },
            {
                "category": "fiction",
                "author": "Herman Melville",
                "title": "Moby Dick",
                "isbn": "0-553-21311-3",
                "price": 8.99
            },
            {
                "category": "fiction",
                "author": "J. R. R. Tolkien",
                "title": "The Lord of the Rings",
                "isbn": "0-395-19395-8",
                "price": 22.99
            }
        ],
        "bicycle": {
            "color": "red",
            "price": 19.95
        }
    }
}';

-- drop table t1;
create table t1(j json);

insert into t1(j) values (@json);

select j,
    json_type(j),
    json_storage_size(j),
    json_storage_freed(j)
from t1;

