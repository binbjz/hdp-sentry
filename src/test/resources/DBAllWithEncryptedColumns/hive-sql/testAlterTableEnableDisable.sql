--encrypt_db4alter.test_enable_disable=encrypt_message
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;
CREATE TABLE IF NOT EXISTS encrypt_db4alter.test_enable_disable (hms INT, severity STRING, server STRING, process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE encrypt_db4alter.test_enable_disable ENABLE NO_DROP;
DROP TABLE encrypt_db4alter.test_enable_disable;

SELECT * FROM encrypt_db4alter.test_enable_disable;
SELECT server, encrypt_message FROM encrypt_db4alter.test_enable_disable;

ALTER TABLE encrypt_db4alter.test_enable_disable DISABLE NO_DROP;
DROP TABLE encrypt_db4alter.test_enable_disable;

CREATE TABLE IF NOT EXISTS encrypt_db4alter.test_enable_disable (hms INT, severity STRING, server STRING, process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE encrypt_db4alter.test_enable_disable ENABLE OFFLINE;
DROP TABLE encrypt_db4alter.test_enable_disable;

SELECT * FROM encrypt_db4alter.test_enable_disable;
SELECT server, encrypt_message FROM encrypt_db4alter.test_enable_disable;

ALTER TABLE encrypt_db4alter.test_enable_disable DISABLE OFFLINE;
DROP TABLE encrypt_db4alter.test_enable_disable;
