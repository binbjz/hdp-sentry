DROP DATABASE db4drop;

DROP TABLE testDB.view4drop;
DROP TABLE testDB.tbl4drop;
DROP TABLE testDB.tbl4alter;
DROP TABLE testDB.log_messages;
DROP TABLE testDB.log_messages_external
DROP TABLE testDB.log_messages02;
ALTER TABLE testDB.supply DROP PARTITION (day = 20110102);
ALTER TABLE testDB.supply DROP PARTITION (day = 20110103);
DROP TABLE testDB.supply;
DROP TABLE testDB.collecttest
DROP TABLE testDB.session_test;
DROP TABLE testDB.sessionization_step_one_origins;

DROP TABLE testDB.partition_table001;
DROP TABLE testDB.partition_table002;
DROP TABLE testDB.table001;
DROP TABLE testDB.table002;
DROP TABLE testDB.teacher;
DROP TABLE testDB.whoyouare;
DROP TABLE testDB.test_serde_partition;
DROP TABLE testDB.staged_employees;
DROP TABLE testDB.employees;
DROP TABLE testDB.employees02;
DROP TABLE testDB.test_enable_disable;
DROP TABLE testDB.employees_props;
DROP DATABASE testDB CASCADE;


DROP TABLE db4msck.test_msck;
DROP DATABASE db4msck CASCADE;

ALTER TABLE db4alter.log_messages PARTITION(year = 2017, month = 8, day = 2) DISABLE NO_DROP;
ALTER TABLE db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 2);
DROP TABLE db4alter.log_messages;
DROP DATABASE db4alter;
