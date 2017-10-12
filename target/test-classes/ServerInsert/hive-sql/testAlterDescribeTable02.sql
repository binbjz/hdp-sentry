USE testdb;
ALTER TABLE testdb.log_messages ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/log_messages/2012/01/02';
ALTER TABLE testdb.log_messages PARTITION (year = 2012, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW PARTITIONS testdb.log_messages;
DESCRIBE testdb.log_messages;

ALTER TABLE testdb.log_messages_external ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/log_messages_external/2012/01/02';
DESCRIBE testdb.log_messages_external;

ALTER TABLE testdb.log_messages SET FILEFORMAT SEQUENCEFILE;
