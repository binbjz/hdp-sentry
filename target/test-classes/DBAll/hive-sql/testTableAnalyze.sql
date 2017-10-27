USE testdb;
ALTER TABLE testdb.src_employees_analyze ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE testdb.src_employees_analyze ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE testdb.src_employees_analyze ADD PARTITION (country = 'US', state = 'IL');

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.src_employees_analyze
PARTITION (country = 'US', state = 'CA');

ANALYZE TABLE testdb.src_employees_analyze COMPUTE STATISTICS FOR columns name, salary;
-- 只搜集分区
ANALYZE TABLE testdb.src_employees_analyze PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
-- 如果执行,则同时搜集分区间OR/CA/IL
ANALYZE TABLE testdb.src_employees_analyze PARTITION (country = 'US', state)  COMPUTE STATISTICS;
-- 如果执行 搜集所有分区
ANALYZE TABLE testdb.src_employees_analyze PARTITION (country, state) COMPUTE STATISTICS;
-- 查看分区的统计信息
DESCRIBE EXTENDED testdb.src_employees_analyze;
DESCRIBE EXTENDED testdb.src_employees_analyze PARTITION (country = 'US', state = 'CA');
