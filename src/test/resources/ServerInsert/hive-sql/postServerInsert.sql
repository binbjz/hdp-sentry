DROP DATABASE db4drop;

DROP TABLE test_db.view4drop;
DROP TABLE test_db.tbl4drop;
DROP TABLE test_db.tbl4alter;
DROP TABLE test_db.log_messages;
DROP TABLE test_db.log_messages_external
DROP TABLE test_db.log_messages02;
ALTER TABLE test_db.supply DROP PARTITION (day = 20110102);
ALTER TABLE test_db.supply DROP PARTITION (day = 20110103);
DROP TABLE test_db.supply;
DROP TABLE test_db.collecttest
DROP TABLE test_db.session_test;
DROP TABLE test_db.sessionization_step_one_origins;

DROP TABLE test_db.partition_table001;
DROP TABLE test_db.partition_table002;
DROP TABLE test_db.table001;
DROP TABLE test_db.table002;
DROP TABLE test_db.teacher;
DROP TABLE test_db.whoyouare;
DROP TABLE test_db.test_serde_partition;
DROP TABLE test_db.staged_employees;
DROP TABLE test_db.employees;
DROP TABLE test_db.employees02;
DROP TABLE test_db.test_enable_disable;
DROP TABLE test_db.employees_props;
DROP DATABASE test_db CASCADE;


DROP TABLE db4msck.test_msck;
DROP DATABASE db4msck CASCADE;

ALTER TABLE db4alter.log_messages PARTITION(year = 2017, month = 8, day = 2) DISABLE NO_DROP;
ALTER TABLE db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 2);
DROP TABLE db4alter.log_messages;
DROP DATABASE db4alter;
