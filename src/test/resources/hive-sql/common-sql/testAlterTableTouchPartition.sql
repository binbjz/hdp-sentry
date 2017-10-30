USE testdb;

ALTER TABLE tbl4analyze TOUCH PARTITION (country = 'US', state = 'CA');
