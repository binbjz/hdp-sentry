--encrypt_db4alter.log_messages=encrypt_hms,encrypt_severity,encrypt_server,encrypt_process_id,encrypt_message
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;
CREATE TABLE IF NOT EXISTS encrypt_db4alter.log_messages (encrypt_hms INT, encrypt_severity STRING, encrypt_server STRING, encrypt_process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE encrypt_db4alter.log_messages ENABLE NO_DROP;
DROP TABLE encrypt_db4alter.log_messages;

SELECT * FROM encrypt_db4alter.log_messages;
SELECT encrypt_hms, encrypt_severity, encrypt_server, encrypt_process_id, encrypt_message FROM encrypt_db4alter.log_messages;

ALTER TABLE encrypt_db4alter.log_messages DISABLE NO_DROP;
DROP TABLE encrypt_db4alter.log_messages;

CREATE TABLE IF NOT EXISTS encrypt_db4alter.log_messages (encrypt_hms INT, encrypt_severity STRING, encrypt_server STRING, encrypt_process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE encrypt_db4alter.log_messages ENABLE OFFLINE;
DROP TABLE encrypt_db4alter.log_messages;

SELECT * FROM encrypt_db4alter.log_messages;
SELECT encrypt_hms, encrypt_severity, encrypt_server, encrypt_process_id, encrypt_message FROM encrypt_db4alter.log_messages;

ALTER TABLE encrypt_db4alter.log_messages DISABLE OFFLINE;
DROP TABLE encrypt_db4alter.log_messages;
