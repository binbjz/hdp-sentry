--Execution:
ALTER TABLE testDB.log_messages ENABLE NO_DROP;
DROP TABLE testDB.log_messages;
ALTER TABLE testDB.log_messages DISABLE NO_DROP;
DROP TABLE testDB.log_messages;

ALTER TABLE testDB.log_messages ENABLE OFFLINE;
DROP TABLE testDB.log_messages;
ALTER TABLE testDB.log_messages DISABLE OFFLINE;
DROP TABLE testDB.log_messages;
