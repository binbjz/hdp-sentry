USE testdb;

ALTER TABLE testdb.test_enable_disable ENABLE NO_DROP;
DROP TABLE testdb.test_enable_disable;
ALTER TABLE testdb.test_enable_disable DISABLE NO_DROP;
DROP TABLE testdb.test_enable_disable;

ALTER TABLE testdb.test_enable_disable ENABLE OFFLINE;
DROP TABLE testdb.test_enable_disable;
ALTER TABLE testdb.test_enable_disable DISABLE OFFLINE;
DROP TABLE testdb.test_enable_disable;
