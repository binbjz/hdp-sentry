ALTER TABLE test_db.log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW CREATE TABLE test_db.log_messages;
SHOW PARTITIONS test_db.log_messages;
DESCRIBE test_db.log_messages;

DESCRIBE EXTENDED test_db.log_messages_external;
DESCRIBE test_db.log_messages_external;

ALTER TABLE test_db.log_messages SET FILEFORMAT SEQUENCEFILE;
DESCRIBE test_db.log_messages;

