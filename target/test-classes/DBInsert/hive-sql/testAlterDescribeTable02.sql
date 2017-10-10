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
