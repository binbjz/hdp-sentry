<<<<<<< HEAD
USE testdb;

ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE testdb.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE testdb.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testdb.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE testdb.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE testdb.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) ENABLE OFFLINE;
ALTER TABLE testdb.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 1);

=======
ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE testdb.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE testdb.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testdb.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE testdb.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE testdb.test_enable_disable_partition ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE testdb.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) ENABLE OFFLINE;
ALTER TABLE testdb.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 1);

>>>>>>> b0450854b2f7ed1c2e1b2c8651afe9e2db333a37
ALTER TABLE testdb.test_enable_disable_partition PARTITION(year = 2017, month = 8, day = 1) DISABLE OFFLINE;
ALTER TABLE testdb.test_enable_disable_partition DROP PARTITION (year = 2017, month = 8, day = 1);
