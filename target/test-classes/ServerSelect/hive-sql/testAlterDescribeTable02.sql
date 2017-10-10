ALTER TABLE testDB.log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW CREATE TABLE testDB.log_messages;
SHOW PARTITIONS testDB.log_messages;
DESCRIBE testDB.log_messages;

DESCRIBE EXTENDED testDB.log_messages_external;
DESCRIBE testDB.log_messages_external;

ALTER TABLE testDB.log_messages SET FILEFORMAT SEQUENCEFILE;
DESCRIBE testDB.log_messages;

