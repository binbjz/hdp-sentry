USE testdb;
ALTER TABLE testdb.test_enable_disable PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE testdb.test_enable_disable DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testdb.test_enable_disable PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE testdb.test_enable_disable DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testdb.test_enable_disable PARTITION(year = 2017, month = 8, day = 2) ENABLE OFFLINE;
ALTER TABLE testdb.test_enable_disable DROP PARTITION (year = 2017, month = 8, day = 2);

ALTER TABLE testdb.test_enable_disable PARTITION(year = 2017, month = 8, day = 2) DISABLE OFFLINE;
ALTER TABLE testdb.test_enable_disable DROP PARTITION (year = 2017, month = 8, day = 2);

DROP TABLE testdb.test_enable_disable;
