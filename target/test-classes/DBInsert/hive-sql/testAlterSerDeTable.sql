--Precondition:
CREATE DATABASE db4alter;
CREATE TABLE db4alter.test_serde (c0 string, c1 string, c2 string) ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

--Execution:
ALTER TABLE db4alter.test_serde SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');

SHOW CREATE TABLE db4alter.test_serde;

--Cleanup:
DROP TABLE db4alter.test_serde;
DROP DATABASE db4alter;