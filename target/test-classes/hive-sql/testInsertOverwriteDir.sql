USE testdb;

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;

INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM testdb.test_insert_overwrite_dir se WHERE se.country = 'US' and se.state = 'CA';
!ls -l /tmp/ca_employees;
!rm -r /tmp/ca_employees;

FROM (
SELECT emp.name, emp.salary FROM testdb.test_insert_overwrite_dir emp WHERE emp.salary < 6000
UNION ALL
SELECT emp.name, emp.salary FROM testdb.test_insert_overwrite_dir emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;
dfs -cat /tmp/union.out/*;
dfs -rm -r /tmp/union.out;
