DROP TABLE testdb.tbl4rename;
DROP TABLE testdb.tbl4rename_new;
DROP TABLE testdb.tbl4replacecolumns;
DROP TABLE testdb.tbl4analyze;

DROP TABLE testdb.tbl4drop;
DROP VIEW testdb.view4drop;
DROP TABLE testdb.tbl4drop_no_r;
DROP VIEW testdb.view4drop_no_r;

DROP TABLE testdb.import_export;
DROP TABLE testdb.src_import_export;

DROP TABLE testdb.sessionization_step_one_origins;
DROP TABLE testdb.session_test;

DROP TABLE testdb.src_insert_overwrite_tbl;
DROP TABLE testdb.insert_overwrite_tb;

DROP TABLE testdb.test_insert_overwrite_dir;

DROP TABLE testdb.src_insert_overwrite_tbl_partition;
DROP TABLE testdb.insert_overwrite_tbl_partition;


DROP TABLE testdb.load_data_local_into_table;
DROP TABLE testdb.load_data_local_into_partition;

DROP TABLE testdb.test_msck;
DROP TABLE testdb.tbl4query;
DROP TABLE testdb.employees_props;

DROP TABLE default.tbl4drop;
DROP VIEW default.view4drop;
DROP TABLE default.tbl4drop_no_r;
DROP VIEW default.view4drop_no_r;

DROP DATABASE testdb CASCADE;

DROP DATABASE db4create CASCADE;
DROP DATABASE db4create_no_privilege CASCADE;

DROP DATABASE db4drop CASCADE;
DROP DATABASE db4drop_cascade CASCADE;
