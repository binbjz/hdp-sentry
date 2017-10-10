CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE test_db.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE test_db.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE test_db.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE test_db.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE test_db.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE test_db.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE test_db.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE OFFLINE;
ALTER TABLE test_db.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE test_db.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE OFFLINE;
ALTER TABLE test_db.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

DROP TABLE test_db.log_messages;
