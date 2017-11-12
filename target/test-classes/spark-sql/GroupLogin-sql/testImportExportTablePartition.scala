USE mart_waimai;

// 导出分区并且导入到分区表分区
EXPORT TABLE mart_waimai.src_employees_import_export PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

IMPORT TABLE mart_waimai.employees_import_export PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS mart_waimai.employees_import_export;

dfs -rm -r /tmp/employee;

System.exit(0);
