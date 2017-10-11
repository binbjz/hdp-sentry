USE testDB;
ALTER TABLE testDB.test_partition_serde ADD PARTITION (col10='abc', col20='123');
DESCRIBE EXTENDED testDB.test_partition_serde PARTITION (col10='abc', col20='123');

ALTER TABLE testDB.test_partition_serde PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
DESCRIBE EXTENDED testDB.test_partition_serde PARTITION (col10='abc', col20='123');

DROP TABLE testDB.test_partition_serde;

