USE testdb;

DESCRIBE EXTENDED testdb.test_serde_partition PARTITION (col10='abc_new', col20='123');

ALTER TABLE testdb.test_serde_partition PARTITION (col10='abc_new', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
DESCRIBE EXTENDED testdb.test_serde_partition PARTITION (col10='abc_new', col20='123');
