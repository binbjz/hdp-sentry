--Precondition:
CREATE DATABASE db4alter2;
CREATE TABLE IF NOT EXISTS db4alter2.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE db4alter2.log_messages ADD PARTITION(year = 2011, month = 1, day = 1);
CREATE EXTERNAL TABLE IF NOT EXISTS db4alter2.log_messages_external (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

--Execution:
USE db4alter2;
ALTER TABLE log_messages ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter2.db/log_messages/2012/01/02';
ALTER TABLE log_messages ADD PARTITION(year = 2012, month = 1, day = 3);
ALTER TABLE log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
ALTER TABLE db4alter2.log_messages_external ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter2.db/log_messages_external/2012/01/02';
ALTER TABLE db4alter2.log_messages SET FILEFORMAT SEQUENCEFILE;
DESC FORMATTED db4alter2.log_messages partition (year = 2011, month = 1, day =1);
ALTER TABLE db4alter2.log_messages DROP PARTITION(year = 2011, month = 1, day = 1);
DROP TABLE db4alter2.log_messages;

--Cleanup:
DROP DATABASE db4alter2 CASCADE;