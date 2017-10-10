SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

LOAD DATA LOCAL INPATH '${env:FILEPATH}/california-employees.csv'
INTO TABLE testDB.staged_employees02
PARTITION (country = 'US', state = 'CA');

SET hive.cli.print.header=true;
SELECT * FROM testDB.staged_employees02;

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;

INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM testDB.staged_employees02 se WHERE se.country = 'US' and se.state = 'CA';
!ls -l /tmp/ca_employees;
!rm -r /tmp/ca_employees;

FROM (
SELECT emp.name, emp.salary FROM testDB.staged_employees02 emp WHERE emp.salary < 6000
UNION ALL
SELECT emp.name, emp.salary FROM testDB.staged_employees02 emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;
dfs -cat /tmp/union.out/* ;
dfs -rm -r /tmp/union.out ;

ANALYZE TABLE testDB.staged_employees02 COMPUTE STATISTICS FOR columns name, salary;
-- 只搜集分区
ANALYZE TABLE testDB.staged_employees02 PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
-- 如果执行,则同时搜集分区间OR/CA/IL
ANALYZE TABLE testDB.staged_employees02 PARTITION (country = 'US', state)  COMPUTE STATISTICS;
-- 如果执行 搜集所有分区
ANALYZE TABLE testDB.staged_employees02 PARTITION (country, state) COMPUTE STATISTICS;
-- 查看分区的统计信息
DESCRIBE EXTENDED testDB.staged_employees02;
DESCRIBE EXTENDED testDB.staged_employees02 PARTITION (country = 'US', state = 'CA');
