--encrypt_db4alter.log_messages=encrypt_hms,encrypt_severity,encrypt_server,encrypt_process_id,encrypt_message
--encrypt_db4alter.log_messages_external=encrypt_hms,encrypt_severity,encrypt_server,encrypt_process_id,encrypt_message
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;

CREATE TABLE IF NOT EXISTS encrypt_db4alter.log_messages (encrypt_hms INT, encrypt_severity STRING, encrypt_server STRING, encrypt_process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE encrypt_db4alter.log_messages ADD PARTITION(year = 2011, month = 1, day = 1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4alter.db/log_messages/2011/01/01';
DESCRIBE EXTENDED encrypt_db4alter.log_messages PARTITION (year = 2011, month = 1, day = 1);
ALTER TABLE encrypt_db4alter.log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW PARTITIONS encrypt_db4alter.log_messages;
DESCRIBE EXTENDED encrypt_db4alter.log_messages PARTITION (year = 2011, month = 1, day = 1);
ALTER TABLE encrypt_db4alter.log_messages SET FILEFORMAT SEQUENCEFILE;

SELECT * FROM encrypt_db4alter.log_messages;


CREATE EXTERNAL TABLE IF NOT EXISTS encrypt_db4alter.log_messages_external (encrypt_hms INT, encrypt_severity STRING, encrypt_server STRING, encrypt_process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE encrypt_db4alter.log_messages_external ADD PARTITION(year = 2011, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4alter.db/log_messages_external/2011/01/02';
DESCRIBE EXTENDED encrypt_db4alter.log_messages_external PARTITION (year = 2011, month = 1, day = 2);
ALTER TABLE encrypt_db4alter.log_messages_external PARTITION (year = 2011, month = 1, day = 2) SET FILEFORMAT SEQUENCEFILE;
SHOW PARTITIONS encrypt_db4alter.log_messages_external;
DESCRIBE EXTENDED encrypt_db4alter.log_messages_external PARTITION (year = 2011, month = 1, day = 2);
ALTER TABLE encrypt_db4alter.log_messages_external SET FILEFORMAT SEQUENCEFILE;

SELECT * FROM encrypt_db4alter.log_messages_external;

DROP TABLE encrypt_db4alter.log_messages;
DROP TABLE encrypt_db4alter.log_messages_external;
dfs -rm -r /user/hive/warehouse/encrypt_db4alter.db/log_messages_external;
