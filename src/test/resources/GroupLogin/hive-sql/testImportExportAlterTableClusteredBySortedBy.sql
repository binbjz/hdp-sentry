USE mart_waimai;

ALTER TABLE mart_waimai.src_employees_import_export ADD PARTITION (country = 'US', state = 'CA');

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE mart_waimai.src_employees_import_export
PARTITION (country = 'US', state = 'CA');

-- 导出分区并且导入到分区表分区
EXPORT TABLE mart_waimai.src_employees_import_export PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

IMPORT TABLE mart_waimai.employees_import_export PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS mart_waimai.employees_import_export;

ALTER TABLE mart_waimai.employees_import_export TOUCH;

ALTER TABLE mart_waimai.src_employees_import_export TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE mart_waimai.employees_import_export TOUCH PARTITION (country = 'US', state = 'CA') ;

DESCRIBE mart_waimai.employees_import_export PARTITION (country='US', state='CA');
DESCRIBE EXTENDED mart_waimai.employees_import_export PARTITION (country='US', state='CA');

ALTER TABLE mart_waimai.employees_import_export CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
dfs -rm -r /tmp/employee;
