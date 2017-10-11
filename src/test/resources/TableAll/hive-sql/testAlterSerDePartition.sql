USE testdb;
ALTER TABLE testdb.test_partition_serde ADD PARTITION (col10='abc', col20='123');
DESCRIBE EXTENDED testdb.test_partition_serde PARTITION (col10='abc', col20='123');

ALTER TABLE testdb.test_partition_serde PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
DESCRIBE EXTENDED testdb.test_partition_serde PARTITION (col10='abc', col20='123');

DROP TABLE testdb.test_partition_serde;

