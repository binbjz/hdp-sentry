ALTER TABLE test_db.test_enable_disable1 ENABLE NO_DROP;
DROP TABLE test_db.test_enable_disable1;
ALTER TABLE test_db.test_enable_disable1 DISABLE NO_DROP;
DROP TABLE test_db.test_enable_disable1;

ALTER TABLE test_db.test_enable_disable2 ENABLE OFFLINE;
DROP TABLE test_db.test_enable_disable2;
ALTER TABLE test_db.test_enable_disable2 DISABLE OFFLINE;
DROP TABLE test_db.test_enable_disable2;
