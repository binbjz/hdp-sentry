--Execution:
ALTER TABLE test_db.log_messages ENABLE NO_DROP;
DROP TABLE test_db.log_messages;
ALTER TABLE test_db.log_messages DISABLE NO_DROP;
DROP TABLE test_db.log_messages;

ALTER TABLE test_db.log_messages ENABLE OFFLINE;
DROP TABLE test_db.log_messages;
ALTER TABLE test_db.log_messages DISABLE OFFLINE;
DROP TABLE test_db.log_messages;
