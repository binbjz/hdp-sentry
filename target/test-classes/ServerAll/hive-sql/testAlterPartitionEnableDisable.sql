DROP DATABASE IF EXISTS db4partition CASCADE;
CREATE DATABASE db4partition;

CREATE TABLE IF NOT EXISTS db4partition.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

USE db4partition;
ALTER TABLE db4partition.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE db4partition.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE db4partition.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE db4partition.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE db4partition.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE db4partition.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE db4partition.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE OFFLINE;
ALTER TABLE db4partition.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE db4partition.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE OFFLINE;
ALTER TABLE db4partition.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

DROP TABLE db4partition.log_messages;
DROP DATABASE db4partition;
