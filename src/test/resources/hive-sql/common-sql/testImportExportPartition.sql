USE testdb;

EXPORT TABLE testdb.src_import_export PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

IMPORT TABLE testdb.import_export PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS testdb.import_export;

dfs -rm -r /tmp/employee;


EXPORT TABLE testdb.src_import_export PARTITION (country = 'US', state = 'CA2') TO '/tmp/employee2';
dfs -cat /tmp/employee2/country=US/state=CA2/california-employees.csv;

IMPORT TABLE testdb.import_export PARTITION (country = 'US', state = 'CA2') FROM '/tmp/employee2';
SHOW PARTITIONS testdb.import_export;

dfs -rm -r /tmp/employee2;
