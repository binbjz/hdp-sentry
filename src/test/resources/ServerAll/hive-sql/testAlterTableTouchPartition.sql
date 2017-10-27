USE testdb;

ANALYZE TABLE tbl4analyze TOUCH PARTITION (country = 'US', state = 'CA');
