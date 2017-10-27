DROP TABLE db4load.collecttest;
DROP DATABASE db4load CASCADE;

DROP DATABASE db4query CASCADE;

DROP TABLE db4overwrite.table001;
DROP TABLE db4overwrite.table002;
DROP TABLE db4overwrite.partition_table001;
DROP TABLE db4overwrite.partition_table002;
DROP DATABASE db4overwrite CASCADE;

DROP TABLE db4func.tbl4jarfile;
DROP DATABASE db4func CASCADE;

DROP TABLE db4addfile.tbl4addfile;
DROP DATABASE db4addfile CASCADE;

DROP TABLE db4alter.test_serde;
DROP TABLE db4alter.test_serde_partition;


DROP TABLE db4alter.tbl4addcolumns;
DROP TABLE db4alter.tbl4change;
DROP TABLE db4alter.tbl4rename;
DROP TABLE db4alter.tbl4replacecolumns;
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

DROP TABLE testdb.test_enable_disable;
DROP TABLE testdb.test_msck;
DROP TABLE testdb.employees_props;

DROP TABLE testdb.src_employees_dir;

DROP TABLE testdb.src_employees_analyze;

DROP DATABASE testdb CASCADE;

DROP DATABASE db4tbl CASCADE;
