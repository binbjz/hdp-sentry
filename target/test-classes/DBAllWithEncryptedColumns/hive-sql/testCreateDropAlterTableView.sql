SHOW TABLES;

CREATE TABLE encrypt_db4tbl.tbl2serde(c0 string, c1 string, c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

ALTER TABLE encrypt_db4tbl.tbl2serde ADD PARTITION (col10='abc', col20='123');
DESCRIBE EXTENDED encrypt_db4tbl.tbl2serde PARTITION (col10='abc', col20='123');

ALTER TABLE encrypt_db4tbl.tbl2serde PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
DESCRIBE EXTENDED encrypt_db4tbl.tbl2serde PARTITION (col10='abc', col20='123');

CREATE VIEW encrypt_db4tbl.view2serde AS SELECT c0, c1, c2 FROM encrypt_db4tbl.tbl2serde;
SHOW TABLES;
ALTER TABLE encrypt_db4tbl.tbl4show SET TBLPROPERTIES ('qa comments' = 'test add table properties');
ALTER TABLE encrypt_db4tbl.tbl2serde SET TBLPROPERTIES ('qa comments' = 'test add table properties');
ALTER VIEW encrypt_db4tbl.view2serde SET TBLPROPERTIES ('qa comments' = 'test add table properties');
ALTER VIEW encrypt_db4tbl.view4show SET TBLPROPERTIES ('qa comments' = 'test add table properties');


USE encrypt_db4tbl;
SHOW TABLES;
SHOW TBLPROPERTIES encrypt_db4tbl.tbl4show;
SHOW TBLPROPERTIES encrypt_db4tbl.tbl2serde;
SHOW TBLPROPERTIES encrypt_db4tbl.view2serde;
SHOW TBLPROPERTIES encrypt_db4tbl.view4show;

SHOW CREATE TABLE encrypt_db4tbl.tbl2serde;

DROP TABLE encrypt_db4tbl.tbl4show;
DROP TABLE encrypt_db4tbl.tbl2serde;
DROP VIEW encrypt_db4tbl.view2serde;
DROP VIEW encrypt_db4tbl.view4show;
SHOW TABLES;
