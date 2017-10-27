USE testdb;
ALTER TABLE testdb.src_employees_dir ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.src_employees_dir ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE testdb.src_employees_dir ADD PARTITION (country = 'US', state = 'IL');

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.src_employees_dir
PARTITION (country = 'US', state = 'CA');

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;

INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM testdb.src_employees_dir se WHERE se.country = 'US' and se.state = 'CA';
!ls -l /tmp/ca_employees;
!rm -r /tmp/ca_employees;

FROM (
      SELECT emp.name, emp.salary FROM testdb.src_employees_dir emp WHERE emp.salary < 6000
      UNION ALL
      SELECT emp.name, emp.salary FROM testdb.src_employees_dir emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;
dfs -cat /tmp/union.out/*;
dfs -rm -r /tmp/union.out;
