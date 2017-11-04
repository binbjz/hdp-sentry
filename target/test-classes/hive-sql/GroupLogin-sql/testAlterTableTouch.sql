USE mart_waimai;

ALTER TABLE mart_waimai.employees_import_export TOUCH;

ALTER TABLE mart_waimai.src_employees_import_export TOUCH PARTITION (country='US', state='CA') ;
ALTER TABLE mart_waimai.employees_import_export TOUCH PARTITION (country='US', state='CA') ;

DESCRIBE mart_waimai.employees_import_export PARTITION (country='US', state='CA');
DESCRIBE EXTENDED mart_waimai.employees_import_export PARTITION (country='US', state='CA');
