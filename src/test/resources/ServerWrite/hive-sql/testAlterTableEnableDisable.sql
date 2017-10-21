--DROP DATABASE IF EXISTS db4enable CASCADE;
--CREATE DATABASE db4enable;
--DROP DATABASE db4enable;

USE db4enable;

CREATE TABLE IF NOT EXISTS db4enable.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE db4enable.log_messages ENABLE NO_DROP;
DROP TABLE db4enable.log_messages;

ALTER TABLE db4enable.log_messages DISABLE NO_DROP;
DROP TABLE db4enable.log_messages;

ALTER TABLE db4enable.log_messages ENABLE OFFLINE;
DROP TABLE db4enable.log_messages;

ALTER TABLE db4enable.log_messages DISABLE OFFLINE;
DROP TABLE db4enable.log_messages;
