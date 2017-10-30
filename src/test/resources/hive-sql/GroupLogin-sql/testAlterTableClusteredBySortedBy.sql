USE mart_waimai;

ALTER TABLE mart_waimai.employees_import_export CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
dfs -rm -r /tmp/employee;
