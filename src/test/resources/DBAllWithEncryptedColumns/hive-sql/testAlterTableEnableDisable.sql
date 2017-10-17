CREATE TABLE IF NOT EXISTS encrypt_db4alter.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

USE encrypt_db4alter;
ALTER TABLE encrypt_db4alter.log_messages ENABLE NO_DROP;
SELECT hms INT, severity, server, process_id, message FROM encrypt_db4alter.log_messages;
DROP TABLE encrypt_db4alter.log_messages;
ALTER TABLE encrypt_db4alter.log_messages DISABLE NO_DROP;
DROP TABLE encrypt_db4alter.log_messages;

CREATE TABLE IF NOT EXISTS encrypt_db4alter.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE encrypt_db4alter.log_messages ENABLE OFFLINE;
SELECT hms INT, severity, server, process_id, message FROM encrypt_db4alter.log_messages;
DROP TABLE encrypt_db4alter.log_messages;
ALTER TABLE encrypt_db4alter.log_messages DISABLE OFFLINE;
DROP TABLE encrypt_db4alter.log_messages;
