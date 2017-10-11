<<<<<<< HEAD
USE testdb;

ALTER TABLE testdb.test_enable_disable1 ENABLE NO_DROP;
DROP TABLE testdb.test_enable_disable1;
ALTER TABLE testdb.test_enable_disable1 DISABLE NO_DROP;
DROP TABLE testdb.test_enable_disable1;

=======
ALTER TABLE testdb.test_enable_disable1 ENABLE NO_DROP;
DROP TABLE testdb.test_enable_disable1;
ALTER TABLE testdb.test_enable_disable1 DISABLE NO_DROP;
DROP TABLE testdb.test_enable_disable1;

>>>>>>> b0450854b2f7ed1c2e1b2c8651afe9e2db333a37
ALTER TABLE testdb.test_enable_disable2 ENABLE OFFLINE;
DROP TABLE testdb.test_enable_disable2;
ALTER TABLE testdb.test_enable_disable2 DISABLE OFFLINE;
DROP TABLE testdb.test_enable_disable2;
