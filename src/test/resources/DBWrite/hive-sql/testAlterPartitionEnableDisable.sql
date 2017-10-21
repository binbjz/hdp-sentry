--DROP TABLE testdb.log_messages;

USE testdb;
CREATE TABLE IF NOT EXISTS testdb.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE testdb.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE testdb.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE testdb.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testdb.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE testdb.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testdb.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE testdb.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE OFFLINE;
ALTER TABLE testdb.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testdb.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE OFFLINE;
ALTER TABLE testdb.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
