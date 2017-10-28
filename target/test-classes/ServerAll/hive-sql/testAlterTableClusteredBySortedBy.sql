USE testdb;

ALTER TABLE testdb.tbl4analyze CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
