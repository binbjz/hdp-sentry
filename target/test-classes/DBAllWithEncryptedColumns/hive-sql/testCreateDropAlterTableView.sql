--encrypt_db4tbl.tbl4view=encrypt_c0,encrypt_c1,encrypt_c2
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4tbl;

CREATE TABLE encrypt_db4tbl.tbl4view(encrypt_c0 string, encrypt_c1 string, encrypt_c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

ALTER TABLE encrypt_db4tbl.tbl4view ADD PARTITION (col10='abc', col20='123');
DESCRIBE EXTENDED encrypt_db4tbl.tbl4view PARTITION (col10='abc', col20='123');

ALTER TABLE encrypt_db4tbl.tbl4view PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
DESCRIBE EXTENDED encrypt_db4tbl.tbl4view PARTITION (col10='abc', col20='123');

CREATE VIEW encrypt_db4tbl.view4serde_0 AS SELECT encrypt_c0, encrypt_c1, encrypt_c2 FROM encrypt_db4tbl.tbl4view;
CREATE VIEW encrypt_db4tbl.view4serde_1 AS SELECT * FROM encrypt_db4tbl.tbl4view;
SHOW TABLES LIKE '*4view*';

ALTER TABLE encrypt_db4tbl.tbl4view SET TBLPROPERTIES ('qa comments' = 'test add table properties');
ALTER VIEW encrypt_db4tbl.view4serde_1 SET TBLPROPERTIES ('qa comments' = 'test add view properties');

SELECT * FROM encrypt_db4tbl.tbl4view;
SELECT * FROM encrypt_db4tbl.view4serde_1;
SELECT encrypt_c0, encrypt_c1, encrypt_c2 FROM encrypt_db4tbl.tbl4view;
SELECT encrypt_c0, encrypt_c1, encrypt_c2 FROM encrypt_db4tbl.view4serde_1;


SHOW TABLES LIKE '*4view*';
SHOW TBLPROPERTIES encrypt_db4tbl.tbl4view;
SHOW TBLPROPERTIES encrypt_db4tbl.view4serde_1;

SHOW CREATE TABLE encrypt_db4tbl.tbl4view;

DROP TABLE encrypt_db4tbl.tbl4view;
DROP VIEW encrypt_db4tbl.view4serde_1;
SHOW TABLES LIKE '*4view*';
