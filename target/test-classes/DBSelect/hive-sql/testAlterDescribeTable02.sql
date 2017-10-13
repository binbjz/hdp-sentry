USE db4alter;
ALTER TABLE db4alter.log_messages ADD PARTITION(year = 2011, month = 1, day = 1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages/2011/01/01';
DESCRIBE EXTENDED db4alter.log_messages PARTITION (year = 2011, month = 1, day = 1);

--need to verify location:viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages/2011/01/01, inputFormat:org.apache.hadoop.mapred.TextInputFormat, outputFormat:org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat
ALTER TABLE db4alter.log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW PARTITIONS db4alter.log_messages;
DESCRIBE EXTENDED db4alter.log_messages PARTITION (year = 2011, month = 1, day = 1);
--need to verify location:viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages/2011/01/01, inputFormat:org.apache.hadoop.mapred.SequenceFileInputFormat, outputFormat:org.apache.hadoop.mapred.SequenceFileOutputFormat

ALTER TABLE db4alter.log_messages_external ADD PARTITION(year = 2011, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages_external/2011/01/02';
DESCRIBE EXTENDED db4alter.log_messages_external;
--need to verify location:viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages_external, inputFormat:org.apache.hadoop.mapred.TextInputFormat, outputFormat:org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat
ALTER TABLE db4alter.log_messages_external SET FILEFORMAT SEQUENCEFILE;
--need to verify location:viewfs://hadoop-meituan-test/user/hive/warehouse/db4alter.db/log_messages_external, inputFormat:org.apache.hadoop.mapred.SequenceFileInputFormat, outputFormat:org.apache.hadoop.mapred.SequenceFileOutputFormat

dfs -rm -r /user/hive/warehouse/db4alter.db/log_messages_external;
