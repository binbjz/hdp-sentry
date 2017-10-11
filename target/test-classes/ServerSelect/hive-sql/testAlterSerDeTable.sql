<<<<<<< HEAD
USE testdb;
=======
>>>>>>> b0450854b2f7ed1c2e1b2c8651afe9e2db333a37
ALTER TABLE testdb.test_serde SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s')
SHOW CREATE TABLE testdb.test_serde;
