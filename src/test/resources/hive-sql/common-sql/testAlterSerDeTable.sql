USE testdb;

ALTER TABLE testdb.test_serde SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
SHOW CREATE TABLE testdb.test_serde;
