-- JSON Test

-- open sqlite.db, w/ employees table
select * from employees;

-- should be v3.45+ (w/ JSONB)
select sqlite_version();

-- open mydb.db --> must be v3.45+ (w/ JSONB) --> 3.46
select sqlite_version();
