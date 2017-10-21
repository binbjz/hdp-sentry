--encrypt_db4data.test_serde=encrypt_c0,encrypt_c1,encrypt_c2
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

USE encrypt_db4data;

CREATE TABLE encrypt_db4data.test_serde (encrypt_c0 string, encrypt_c1 string, encrypt_c2 string) ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

ALTER TABLE encrypt_db4data.test_serde SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
SHOW CREATE TABLE encrypt_db4data.test_serde;

SELECT * FROM encrypt_db4data.test_serde

DROP TABLE encrypt_db4data.test_serde;
