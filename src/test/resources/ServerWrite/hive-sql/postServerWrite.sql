DROP TABLE testdb.tbl4query;

---DB db4alter---------------

DROP TABLE db4alter.tbl4fileformat;
DROP TABLE db4alter.tbl4fileformat_external;
DROP TABLE db4alter.tbl4setlocation;
DROP TABLE db4alter.employees;
DROP TABLE db4alter.src_employees;
DROP DATABASE db4alter CASCADE;

---DB db2alter---------------
DROP DATABASE db2alter;

---DB db4view---------------
DROP VIEW db4view.test_view;
DROP TABLE db4view.tbl4view;
DROP DATABASE db4view CASCADE;

---DB db4drop_cascade---------------
DROP DATABASE db4drop_cascade CASCADE;

---DB db4create---------------
DROP DATABASE db4create;

---DB testdb---------------
DROP TABLE testdb.tbl4create;
DROP TABLE testdb.tbl4create_external;
DROP TABLE testdb.tbl4ctas;
DROP TABLE testdb.tbl4like;
DROP TABLE testdb.src_employees_analyze;
DROP TABLE testdb.test_serde_partition;;
DROP TABLE testdb.test_serde;
DROP TABLE testdb.test_enable_disable_partition;
DROP TABLE testdb.test_enable_disable1;
DROP TABLE testdb.test_enable_disable2;

DROP TABLE testdb.tbl4addcolumns;
DROP TABLE testdb.tbl4change;
DROP TABLE testdb.tbl4rename_new;
DROP TABLE testdb.tbl4replacecolumns;

DROP DATABASE testdb CASCADE;

---DB db4data---------------
DROP TABLE db4data.session_test;
DROP TABLE db4data.sessionization_step_one_origins;
DROP TABLE db4data.src_employees_dir;
DROP TABLE db4data.table001;
DROP TABLE db4data.table002;
DROP TABLE db4data.src_employees;
DROP TABLE db4data.employees;
DROP TABLE db4data.src_employees_analyze;
DROP DATABASE db4data;

---DB db4partition---------------
DROP TABLE db4partition.partition_table001;
DROP TABLE db4partition.partition_table002;
DROP TABLE db4partition.tbl4partition;
DROP DATABASE db4partition CASCADE;

---DB testdb---------------
DROP TABLE testdb.collecttest;
DROP TABLE testdb.test_msck
DROP DATABASE testdb CASCADE;

---DB db4add---------------
DROP TABLE db4add.tbl4addfile;
DROP DATABASE db4add;

---DB db4func---------------
DROP TABLE db4func.tbl4func;
DROP DATABASE db4func;

---DB db4properties---------------
DROP TABLE db4properties.employees_props;
DROP DATABASE db4properties;