USE mart_waimai;

FROM mart_waimai.src_employees_insert_overwrite se
INSERT OVERWRITE TABLE mart_waimai.employees_insert_overwrite PARTITION (country = 'US', state = 'OR')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
INSERT OVERWRITE TABLE mart_waimai.employees_insert_overwrite PARTITION (country = 'US', state = 'IL')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
INSERT OVERWRITE TABLE mart_waimai.employees_insert_overwrite PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA';

SET hive.cli.print.header=true;
SELECT * FROM mart_waimai.employees_insert_overwrite;

INSERT OVERWRITE TABLE mart_waimai.employees_insert_overwrite PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address FROM mart_waimai.src_employees_insert_overwrite se WHERE se.country = 'US' AND se.state = 'CA';

TRUNCATE TABLE mart_waimai.employees_insert_overwrite;

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;
INSERT OVERWRITE TABLE mart_waimai.employees_insert_overwrite PARTITION (country = 'US', state)
SELECT se.name, se.salary, se.subordinates, se.deductions, se.address, se.state FROM mart_waimai.src_employees_insert_overwrite se WHERE se.country = 'US';
SELECT * FROM mart_waimai.employees_insert_overwrite;
