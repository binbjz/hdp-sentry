USE testdb;
ALTER TABLE testdb.log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW CREATE TABLE testdb.log_messages;
SHOW PARTITIONS testdb.log_messages;
DESCRIBE testdb.log_messages;

DESCRIBE EXTENDED testdb.log_messages_external;
DESCRIBE testdb.log_messages_external;

ALTER TABLE testdb.log_messages SET FILEFORMAT SEQUENCEFILE;
DESCRIBE testdb.log_messages;
