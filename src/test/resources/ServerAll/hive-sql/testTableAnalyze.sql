USE testdb;

ANALYZE TABLE testdb.tbl4analyze COMPUTE STATISTICS FOR columns name, salary;
-- 只搜集分区
ANALYZE TABLE testdb.tbl4analyze PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
-- 如果执行,则同时搜集分区间OR/CA/IL
ANALYZE TABLE testdb.tbl4analyze PARTITION (country = 'US', state)  COMPUTE STATISTICS;
-- 如果执行 搜集所有分区
ANALYZE TABLE testdb.tbl4analyze PARTITION (country, state) COMPUTE STATISTICS;
-- 查看分区的统计信息：
DESCRIBE EXTENDED testdb.tbl4analyze;
DESCRIBE EXTENDED testdb.tbl4analyze PARTITION (country = 'US', state = 'CA');
