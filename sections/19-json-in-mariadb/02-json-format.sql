-- JSON Formatting
use test;

select j,
	json_pretty(j),
	json_pretty(j, 1)
from t1;

select j,
	json_detailed(j),
	json_loose(j),
	json_compact(j)
from t1;

select j,
	json_normalize(j),
	json_equals(j, json_normalize(j))
from t1;
