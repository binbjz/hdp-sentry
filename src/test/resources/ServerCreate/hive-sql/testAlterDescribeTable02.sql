CREATE TABLE IF NOT EXISTS testdb.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE testdb.log_messages ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/log_messages/2012/01/02';
ALTER TABLE log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW CREATE TABLE testdb.log_messages;
SHOW PARTITIONS testdb.log_messages;
DESCRIBE EXTENDED testdb.log_messages;
DESCRIBE testdb.log_messages;


CREATE EXTERNAL TABLE IF NOT EXISTS testdb.log_messages_external (hms INT, severity STRING, server STRING, process_id INT, message STRING) PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE testdb.log_messages_external ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/log_messages_external/2012/01/02';
DESCRIBE EXTENDED testdb.log_messages_external;
DESCRIBE testdb.log_messages_external;


ALTER TABLE testdb.log_messages SET FILEFORMAT SEQUENCEFILE;
DESCRIBE EXTENDED testdb.log_messages;
DESCRIBE testdb.log_messages;

DROP TABLE testdb.log_messages;
