--Execution:
ALTER TABLE testdb.log_messages ENABLE NO_DROP;
DROP TABLE testdb.log_messages;
ALTER TABLE testdb.log_messages DISABLE NO_DROP;
DROP TABLE testdb.log_messages;

ALTER TABLE testdb.log_messages ENABLE OFFLINE;
DROP TABLE testdb.log_messages;
ALTER TABLE testdb.log_messages DISABLE OFFLINE;
DROP TABLE testdb.log_messages;
