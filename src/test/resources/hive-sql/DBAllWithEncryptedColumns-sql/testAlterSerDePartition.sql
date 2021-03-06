--encrypt_db4data.test_serde_partition=encrypt_c0
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

USE encrypt_db4data;
CREATE TABLE encrypt_db4data.test_serde_partition(encrypt_c0 string, c1 string, c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

ALTER TABLE encrypt_db4data.test_serde_partition ADD PARTITION (col10='abc', col20='123');
DESCRIBE EXTENDED encrypt_db4data.test_serde_partition PARTITION (col10='abc', col20='123');
SELECT * FROM encrypt_db4data.test_serde_partition;

ALTER TABLE encrypt_db4data.test_serde_partition PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
DESCRIBE EXTENDED encrypt_db4data.test_serde_partition PARTITION (col10='abc', col20='123');
SELECT * FROM encrypt_db4data.test_serde_partition;

DROP TABLE encrypt_db4data.test_serde_partition;
