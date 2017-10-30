USE mart_waimai;

ANALYZE TABLE mart_waimai.src_employees_insert_overwrite COMPUTE STATISTICS FOR columns name, salary;
-- 只搜集分区
ANALYZE TABLE mart_waimai.src_employees_insert_overwrite PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
-- 如果执行,则同时搜集分区间OR/CA/IL
ANALYZE TABLE mart_waimai.src_employees_insert_overwrite PARTITION (country = 'US', state)  COMPUTE STATISTICS;
-- 如果执行 搜集所有分区
ANALYZE TABLE mart_waimai.src_employees_insert_overwrite PARTITION (country, state) COMPUTE STATISTICS;
-- 查看分区的统计信息
DESCRIBE EXTENDED mart_waimai.src_employees_insert_overwrite;
DESCRIBE EXTENDED mart_waimai.src_employees_insert_overwrite PARTITION (country = 'US', state = 'CA');
