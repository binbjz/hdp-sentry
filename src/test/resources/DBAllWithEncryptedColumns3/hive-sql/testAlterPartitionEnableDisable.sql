CREATE TABLE IF NOT EXISTS encrypt_db4alter.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE encrypt_db4alter.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE encrypt_db4alter.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
SELECT hms, severity, server, process_id, message FROM encrypt_db4alter.log_messages;
ALTER TABLE encrypt_db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE encrypt_db4alter.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE encrypt_db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE encrypt_db4alter.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE encrypt_db4alter.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE OFFLINE;
SELECT hms, severity, server, process_id, message FROM encrypt_db4alter.log_messages;
ALTER TABLE encrypt_db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE encrypt_db4alter.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE OFFLINE;
ALTER TABLE encrypt_db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

DROP TABLE encrypt_db4alter.log_messages;
