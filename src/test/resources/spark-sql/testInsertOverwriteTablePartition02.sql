USE testdb;

FROM testdb.src_test_insert_overwrite_tbl_partition se
INSERT OVERWRITE TABLE testdb.test_insert_overwrite_tbl_partition PARTITION (country = 'US', state = 'OR')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
INSERT OVERWRITE TABLE testdb.test_insert_overwrite_tbl_partition PARTITION (country = 'US', state = 'IL')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
INSERT OVERWRITE TABLE testdb.test_insert_overwrite_tbl_partition PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA';

SET hive.cli.print.header=true;
SELECT * FROM testdb.test_insert_overwrite_tbl_partition;

INSERT OVERWRITE TABLE testdb.test_insert_overwrite_tbl_partition PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address FROM testdb.src_test_insert_overwrite_tbl_partition se WHERE se.country = 'US' AND se.state = 'CA';

TRUNCATE TABLE testdb.test_insert_overwrite_tbl_partition;

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;
INSERT OVERWRITE TABLE testdb.test_insert_overwrite_tbl_partition PARTITION (country = 'US', state)
SELECT se.name, se.salary, se.subordinates, se.deductions, se.address, se.state FROM testdb.src_test_insert_overwrite_tbl_partition se WHERE se.country = 'US';
SELECT * FROM testdb.test_insert_overwrite_tbl_partition;
