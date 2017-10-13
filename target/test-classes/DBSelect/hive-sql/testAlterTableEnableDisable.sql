ALTER TABLE testdb.test_disable_enable01 ENABLE NO_DROP;
--DROP testdb.test_disable_enable01;
ALTER TABLE test.test_disable_enable01 DISABLE NO_DROP;
DROP testdb.test_disable_enable01;

ALTER TABLE testdb.test_disable_enable02 ENABLE OFFLINE;
--DROP TABLE testdb.test_disable_enable02;
ALTER TABLE testdb.test_disable_enable02 DISABLE OFFLINE;
DROP TABLE testdb.test_disable_enable02;
