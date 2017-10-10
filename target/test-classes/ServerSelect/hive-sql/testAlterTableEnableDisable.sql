ALTER TABLE testDB.test_enable_disable1 ENABLE NO_DROP;
DROP TABLE testDB.test_enable_disable1;
ALTER TABLE testDB.test_enable_disable1 DISABLE NO_DROP;
DROP TABLE testDB.test_enable_disable1;

ALTER TABLE testDB.test_enable_disable2 ENABLE OFFLINE;
DROP TABLE testDB.test_enable_disable2;
ALTER TABLE testDB.test_enable_disable2 DISABLE OFFLINE;
DROP TABLE testDB.test_enable_disable2;
