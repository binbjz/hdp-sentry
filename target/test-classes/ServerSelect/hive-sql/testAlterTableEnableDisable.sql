ALTER TABLE testdb.test_enable_disable1 ENABLE NO_DROP;
DROP TABLE testdb.test_enable_disable1;
ALTER TABLE testdb.test_enable_disable1 DISABLE NO_DROP;
DROP TABLE testdb.test_enable_disable1;

ALTER TABLE testdb.test_enable_disable2 ENABLE OFFLINE;
DROP TABLE testdb.test_enable_disable2;
ALTER TABLE testdb.test_enable_disable2 DISABLE OFFLINE;
DROP TABLE testdb.test_enable_disable2;
