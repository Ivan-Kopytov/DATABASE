




DROP TABLE
CREATE TABLE
INSERT 0 3
BEGIN
 val 
-----
 100
(1 row)

 val 
-----
 100
(1 row)

COMMIT
BEGIN
 val 
-----
 100
(1 row)

 val 
-----
 100
(1 row)

COMMIT
BEGIN
 val 
-----
 200
 300
(2 rows)

 val 
-----
 200
 300
(2 rows)

COMMIT
BEGIN
 val 
-----
 200
 300
(2 rows)

 val 
-----
 200
 300
(2 rows)

COMMIT
kopytov=# 