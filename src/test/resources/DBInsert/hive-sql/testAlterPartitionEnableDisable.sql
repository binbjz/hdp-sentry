ALTER TABLE test_db2.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE test_db2.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE test_db2.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE test_db2.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE test_db2.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE test_db2.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE test_db2.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE OFFLINE;
ALTER TABLE test_db2.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE test_db2.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE OFFLINE;
ALTER TABLE test_db2.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
