ALTER TABLE test_db.log_messages ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/test_db.db/log_messages/2012/01/02';
ALTER TABLE test_db.log_messages PARTITION (year = 2012, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW PARTITIONS test_db.log_messages;
DESCRIBE test_db.log_messages;

ALTER TABLE test_db.log_messages_external ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/test_db.db/log_messages_external/2012/01/02';
DESCRIBE test_db.log_messages_external;

ALTER TABLE test_db.log_messages SET FILEFORMAT SEQUENCEFILE;
