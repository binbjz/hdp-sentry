--DROP TABLE db4alter.log_messages;
--DROP TABLE db4alter.log_messages_external;

USE db4alter;
CREATE TABLE IF NOT EXISTS db4alter.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE db4alter.log_messages ADD PARTITION(year = 2011, month = 1, day = 1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages/2011/01/01';
DESCRIBE EXTENDED db4alter.log_messages PARTITION (year = 2011, month = 1, day = 1);
--need to verify location:viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages/2011/01/01, inputFormat:org.apache.hadoop.mapred.TextInputFormat, outputFormat:org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat
ALTER TABLE db4alter.log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW PARTITIONS db4alter.log_messages;
DESCRIBE EXTENDED db4alter.log_messages PARTITION (year = 2011, month = 1, day = 1);
--need to verify location:viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages/2011/01/01, inputFormat:org.apache.hadoop.mapred.SequenceFileInputFormat, outputFormat:org.apache.hadoop.mapred.SequenceFileOutputFormat

CREATE EXTERNAL TABLE IF NOT EXISTS db4alter.log_messages_external (hms INT, severity STRING, server STRING, process_id INT, message STRING) PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE db4alter.log_messages_external ADD PARTITION(year = 2011, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages_external/2011/01/02';
DESCRIBE EXTENDED db4alter.log_messages_external;
--need to verify location:viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages_external, inputFormat:org.apache.hadoop.mapred.TextInputFormat, outputFormat:org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat
ALTER TABLE db4alter.log_messages_external SET FILEFORMAT SEQUENCEFILE;
--need to verify location:viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages_external, inputFormat:org.apache.hadoop.mapred.SequenceFileInputFormat, outputFormat:org.apache.hadoop.mapred.SequenceFileOutputFormat

dfs -rm -r /user/hive/warehouse/db4alter.db/log_messages_external;
