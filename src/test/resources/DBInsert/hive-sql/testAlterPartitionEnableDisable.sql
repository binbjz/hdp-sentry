USE testdb;
ALTER TABLE testdb.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE testdb.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testdb.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE testdb.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testdb.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE OFFLINE;
ALTER TABLE testdb.log_messages DROP PARTITION (year = 2017, month = 8, day = 2);

ALTER TABLE testdb.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE OFFLINE;
ALTER TABLE testdb.log_messages DROP PARTITION (year = 2017, month = 8, day = 2);
