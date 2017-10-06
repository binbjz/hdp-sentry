DROP DATABASE IF EXISTS db4alter CASCADE;
CREATE DATABASE db4alter;

USE db4alter;
CREATE TABLE IF NOT EXISTS db4alter.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE db4alter.log_messages ADD PARTITION(year = 2011, month = 1, day = 1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages/2011/01/01';
ALTER TABLE log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW CREATE TABLE db4alter.log_messages;
SHOW PARTITIONS db4alter.log_messages;
DESCRIBE EXTENDED db4alter.log_messages;
DESCRIBE db4alter.log_messages;
ALTER TABLE db4alter.log_messages SET FILEFORMAT SEQUENCEFILE;
DESCRIBE EXTENDED db4alter.log_messages;
DESCRIBE db4alter.log_messages;

CREATE EXTERNAL TABLE IF NOT EXISTS db4alter.log_messages_external (hms INT, severity STRING, server STRING, process_id INT, message STRING) PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE db4alter.log_messages_external ADD PARTITION(year = 2011, month = 1, day = 1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages_external/2011/01/01';
DESCRIBE EXTENDED db4alter.log_messages_external;
DESCRIBE db4alter.log_messages_external;

DROP TABLE db4alter.log_messages;
DROP DATABASE db4alter CASCADE;
