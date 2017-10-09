--Precondition:
CREATE DATABASE db4alter;
CREATE TABLE db4alter.test_serde(c0 string, c1 string, c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

--Execution:
ALTER TABLE db4alter.test_serde ADD PARTITION (col10='abc', col20='123');
DESCRIBE db4alter.test_serde PARTITION (col10='abc', col20='123');

ALTER TABLE db4alter.test_serde PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
DESCRIBE EXTENDED db4alter.test_serde PARTITION (col10='abc', col20='123');

--Cleanup:
DROP TABLE db4alter.test_serde;
DROP DATABASE db4alter;