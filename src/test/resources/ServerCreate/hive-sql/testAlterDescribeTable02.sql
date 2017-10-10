CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE test_db.log_messages ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/test_db.db/log_messages/2012/01/02';
ALTER TABLE log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW CREATE TABLE test_db.log_messages;
SHOW PARTITIONS test_db.log_messages;
DESCRIBE EXTENDED test_db.log_messages;
DESCRIBE test_db.log_messages;


CREATE EXTERNAL TABLE IF NOT EXISTS test_db.log_messages_external (hms INT, severity STRING, server STRING, process_id INT, message STRING) PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE test_db.log_messages_external ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/test_db.db/log_messages_external/2012/01/02';
DESCRIBE EXTENDED test_db.log_messages_external;
DESCRIBE test_db.log_messages_external;


ALTER TABLE test_db.log_messages SET FILEFORMAT SEQUENCEFILE;
DESCRIBE EXTENDED test_db.log_messages;
DESCRIBE test_db.log_messages;

DROP TABLE test_db.log_messages;
