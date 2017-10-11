ALTER TABLE testDB.log_messages ADD PARTITION (year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testDB.db/log_messages/2012/01/02';
ALTER TABLE testDB.log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW CREATE TABLE testDB.log_messages;
SHOW PARTITIONS testDB.log_messages;

ALTER TABLE testDB.log_messages_external ADD PARTITION (year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testDB.db/log_messages_external/2012/01/02';
DESCRIBE EXTENDED testDB.log_messages_external;
DESCRIBE testDB.log_messages_external;

ALTER TABLE testDB.log_messages SET FILEFORMAT SEQUENCEFILE;
DESCRIBE testDB.log_messages;
SHOW TBLPROPERTIES testDB.log_messages;

DROP TABLE testDB.log_messages;
DROP TABLE testDB.log_messages_external;
