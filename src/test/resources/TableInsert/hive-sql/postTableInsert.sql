DROP TABLE testdb.tbl4query;

DROP TABLE testdb.tbl4partiton;
DROP TABLE testdb.tbl4addfile;

DROP TABLE testdb.tbl4fileformat;
DROP TABLE testdb.tbl4fileformat_external;
DROP TABLE testdb.log_messages2;
DROP TABLE testdb.test_enable_disable;
DROP TABLE testdb.test_enable_disable_partition;

DROP TABLE testdb.test_serde_partition;
DROP TABLE testdb.test_serde;
DROP TABLE testdb.session_test;
DROP TABLE testdb.sessionization_step_one_origins;
DROP TABLE testdb.import_export;
DROP TABLE testdb.src_import_export;

DROP TABLE testdb.table001;
DROP TABLE testdb.table002;
DROP TABLE testdb.src_employees;
DROP TABLE testdb.employees;
DROP TABLE testdb.partition_table001;
DROP TABLE testdb.partition_table002;
DROP TABLE testdb.collecttest;
DROP TABLE testdb.test_msck;
DROP TABLE testdb.employees_props;

DROP TABLE testdb.test_msck;
DROP TABLE testdb.tbl4jarfile;
DROP TABLE testdb.tbl4drop_no_r;
DROP TABLE testdb.view4drop_no_r;

DROP TABLE testdb.tbl4alter_new;

DROP TABLE testdb.src_employees_analyze;
DROP TABLE testdb.src_employees_dir;

DROP TABLE testdb.tbl4addcolumns;
DROP TABLE testdb.tbl4replacecolumns;
DROP TABLE testdb.tbl4change;
DROP TABLE testdb.tbl4rename_new;

DROP DATABASE unaccessdb;
DROP DATABASE testdb CASCADE;
DROP DATABASE db4drop_cascade CASCADE;
