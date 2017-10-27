USE db4alter;
DESCRIBE db4alter.test_serde_partition PARTITION (col10='abc', col20='123');

ALTER TABLE db4alter.test_serde_partition PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
DESCRIBE EXTENDED db4alter.test_serde_partition PARTITION (col10='abc', col20='123');
