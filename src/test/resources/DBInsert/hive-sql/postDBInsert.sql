DROP TABLE db4load.collecttest;
DROP DATABASE db4load CASCADE;

DROP DATABASE db4query CASCADE;

DROP TABLE db4overwrite.table001;
DROP TABLE db4overwrite.table002;
DROP TABLE db4overwrite.partition_table001;
DROP TABLE db4overwrite.partition_table002;
DROP DATABASE db4overwrite CASCADE;

DROP TABLE testdb.tbl4jarfile;

DROP TABLE testdb.tbl4addfile;

DROP TABLE testdb.test_serde;
DROP TABLE testdb.test_serde_partition;


DROP TABLE testdb.tbl4addcolumns;
DROP TABLE testdb.tbl4change;
DROP TABLE testdb.tbl4rename;
DROP TABLE testdb.tbl4replacecolumns;
DROP DATABASE db4alter CASCADE;

DROP DATABASE db4show CASCADE;

DROP TABLE db4alter2.tbl4fileformat;
DROP TABLE db4alter2.tbl4fileformat_external;
DROP DATABASE db4alter2 CASCADE;

DROP TABLE testdb.src_employees;
DROP TABLE testdb.employees;
DROP TABLE testdb.employees02;
DROP TABLE testdb.src_employees02;
DROP TABLE testdb.log_messages02;

DROP TABLE testdb.test_enable_disable1;
DROP TABLE testdb.test_enable_disable2;
DROP TABLE testdb.test_enable_disable_partition;
DROP TABLE testdb.test_msck;
DROP TABLE testdb.employees_props;

DROP TABLE testdb.test_insert_overwrite_dir;

DROP TABLE testdb.src_employees_analyze;

DROP TABLE testdb.tbl4query;

DROP DATABASE testdb CASCADE;

DROP DATABASE db4tbl CASCADE;
