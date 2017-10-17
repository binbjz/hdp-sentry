DROP DATABASE db4drop;

DROP TABLE testdb.view4drop;
DROP TABLE testdb.tbl4drop;
DROP TABLE testdb.tbl4alter;
DROP TABLE testdb.log_messages;
DROP TABLE testdb.log_messages_external
DROP TABLE testdb.log_messages02;
ALTER TABLE testdb.supply DROP PARTITION (day = 20110102);
ALTER TABLE testdb.supply DROP PARTITION (day = 20110103);
DROP TABLE testdb.supply;
DROP TABLE testdb.collecttest
DROP TABLE testdb.session_test;
DROP TABLE testdb.sessionization_step_one_origins;

DROP TABLE testdb.partition_table001;
DROP TABLE testdb.partition_table002;
DROP TABLE testdb.table001;
DROP TABLE testdb.table002;
DROP TABLE testdb.teacher;
DROP TABLE testdb.whoyouare;
DROP TABLE testdb.test_serde_partition;
DROP TABLE testdb.src_tgt_employees;
DROP TABLE testdb.employees;
DROP TABLE testdb.employees02;
DROP TABLE testdb.test_enable_disable;
DROP TABLE testdb.employees_props;
DROP DATABASE testdb CASCADE;


DROP TABLE db4msck.test_msck;
DROP DATABASE db4msck CASCADE;

ALTER TABLE db4alter.log_messages PARTITION(year = 2017, month = 8, day = 2) DISABLE NO_DROP;
ALTER TABLE db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 2);
DROP TABLE db4alter.log_messages;
DROP DATABASE db4alter;
