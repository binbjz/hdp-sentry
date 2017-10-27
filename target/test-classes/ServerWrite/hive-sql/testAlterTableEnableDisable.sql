--DROP DATABASE IF EXISTS db4enable CASCADE;
--CREATE DATABASE db4enable;
--CREATE TABLE IF NOT EXISTS db4enable.test_enable_disable (hms INT, severity STRING, server STRING, process_id INT, message STRING)
--PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

--DROP TABLE db4enable.test_enable_disable;
--DROP DATABASE db4enable;

USE db4enable;

ALTER TABLE db4enable.test_enable_disable ENABLE NO_DROP;
DROP TABLE db4enable.test_enable_disable;

ALTER TABLE db4enable.test_enable_disable DISABLE NO_DROP;
DROP TABLE db4enable.test_enable_disable;

ALTER TABLE db4enable.test_enable_disable ENABLE OFFLINE;
DROP TABLE db4enable.test_enable_disable;

ALTER TABLE db4enable.test_enable_disable DISABLE OFFLINE;
DROP TABLE db4enable.test_enable_disable;
