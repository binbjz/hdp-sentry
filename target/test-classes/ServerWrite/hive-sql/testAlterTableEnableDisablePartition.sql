--CREATE DATABASE db4partition;
--CREATE TABLE IF NOT EXISTS db4partition.test_enable_disable_partition (hms INT, severity STRING, server STRING, process_id INT, message STRING)
--PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

--DROP TABLE db4partition.test_enable_disable_partition;
--DROP DATABASE db4partition CASCADE;

USE db4partition;
ALTER TABLE db4partition.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE db4partition.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE db4partition.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE db4partition.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE db4partition.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE db4partition.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 2);
ALTER TABLE db4partition.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) ENABLE OFFLINE;
ALTER TABLE db4partition.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 2);

ALTER TABLE db4partition.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) DISABLE OFFLINE;
ALTER TABLE db4partition.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 2);