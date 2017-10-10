CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE test_db.log_messages ENABLE NO_DROP;
DROP test_db.log_messages;
ALTER TABLE test_db.log_messages DISABLE NO_DROP;
DROP test_db.log_messages;

ALTER TABLE test_db.log_messages ENABLE OFFLINE;
DROP test_db.log_messages;
ALTER TABLE test_db.log_messages DISABLE OFFLINE;
DROP test_db.log_messages;
