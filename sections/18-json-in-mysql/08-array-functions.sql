-- Array Manipulation Functions: JSON_ARRAY_INSERT/APPEND

-- ["X", 1, 2, [3]], [[1, "X"], 2, [3]]
SELECT 
    JSON_ARRAY_INSERT('[1, 2, [3]]', '$[0]', "X"),
    JSON_ARRAY_APPEND('[1, 2, [3]]', '$[0]', "X");

-- [1, "X", 2, [3]], [1, [2, "X"], [3]]
SELECT
    JSON_ARRAY_INSERT('[1, 2, [3]]', '$[1]', "X"),
    JSON_ARRAY_APPEND('[1, 2, [3]]', '$[1]', "X");

-- [1, 2, "X", [3]], [1, 2, [3, "X"]]
SELECT
    JSON_ARRAY_INSERT('[1, 2, [3]]', '$[2]', "X"),
    JSON_ARRAY_APPEND('[1, 2, [3]]', '$[2]', "X");

-- [1, "X", "Y", 2, [3]], [1, [2, "X"], [3, "Y"]]
SELECT
    JSON_ARRAY_INSERT('[1, 2, [3]]', '$[1]', "X", '$[2]', "Y"),
    JSON_ARRAY_APPEND('[1, 2, [3]]', '$[1]', "X", '$[2]', "Y");

-- NULL, {"a":1, "b":2, "c":[3, "X"]}
SELECT
	JSON_ARRAY_INSERT('{"a":1, "b":2, "c": [3]}', '$.c', "X"),
	JSON_ARRAY_APPEND('{"a":1, "b":2, "c": [3]}', '$.c', "X");

-- NULL, [1, 2, [3], "X"]
SELECT
	JSON_ARRAY_INSERT('[1, 2, [3]]', '$', "X"),
 	JSON_ARRAY_APPEND('[1, 2, [3]]', '$', "X");
