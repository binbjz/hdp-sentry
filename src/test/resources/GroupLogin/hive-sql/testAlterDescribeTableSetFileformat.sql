USE mart_waimai;

CREATE TABLE IF NOT EXISTS log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE log_messages ADD PARTITION(year = 2011, month = 1, day = 1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages/2011/01/01';
DESCRIBE EXTENDED log_messages PARTITION (year = 2011, month = 1, day = 1);

ALTER TABLE log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW PARTITIONS log_messages;
DESCRIBE EXTENDED log_messages PARTITION (year = 2011, month = 1, day = 1);

CREATE EXTERNAL TABLE IF NOT EXISTS log_messages_external (hms INT, severity STRING, server STRING, process_id INT, message STRING) PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE mart_waimai.log_messages_external ADD PARTITION(year = 2011, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages_external/2011/01/02';
DESCRIBE EXTENDED mart_waimai.log_messages_external;

ALTER TABLE mart_waimai.log_messages_external SET FILEFORMAT SEQUENCEFILE;

DROP TABLE mart_waimai.log_messages;
DROP TABLE mart_waimai.log_messages_external;

dfs -rm -r /user/hive/warehouse/mart_waimai.db/log_messages_external;
