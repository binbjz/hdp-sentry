ALTER TABLE testDB.test_enable_disable ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE testDB.test_enable_disable PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE testDB.test_enable_disable DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testDB.test_enable_disable PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE testDB.test_enable_disable DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testDB.test_enable_disable ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE testDB.test_enable_disable PARTITION(year = 2017, month = 8, day = 1) ENABLE OFFLINE;
ALTER TABLE testDB.test_enable_disable DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testDB.test_enable_disable PARTITION(year = 2017, month = 8, day = 1) DISABLE OFFLINE;
ALTER TABLE testDB.test_enable_disable DROP PARTITION (year = 2017, month = 8, day = 1);

DROP TABLE testDB.test_enable_disable;
