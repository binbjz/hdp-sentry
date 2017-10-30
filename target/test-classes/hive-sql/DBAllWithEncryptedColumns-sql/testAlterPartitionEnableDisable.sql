--encrypt_db4alter.test_enable_disable_partition=encrypt_message
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;
CREATE TABLE IF NOT EXISTS encrypt_db4alter.test_enable_disable_partition (hms INT, severity STRING, server STRING, process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE encrypt_db4alter.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE encrypt_db4alter.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 2);

ALTER TABLE encrypt_db4alter.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE encrypt_db4alter.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE encrypt_db4alter.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE encrypt_db4alter.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE encrypt_db4alter.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 2) ENABLE OFFLINE;
ALTER TABLE encrypt_db4alter.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 2);

ALTER TABLE encrypt_db4alter.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 2) DISABLE OFFLINE;
ALTER TABLE encrypt_db4alter.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 2);

DROP TABLE encrypt_db4alter.test_enable_disable_partition;
