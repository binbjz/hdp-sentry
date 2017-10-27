USE testdb;
SHOW PARTITIONS testdb.tbl4partition;
SET hive.cli.print.header=true;
SELECT id, part, quantity FROM testdb.tbl4partition WHERE day >= 20110102 AND day < 20110103 AND quantity < 4 ;
ALTER TABLE testdb.tbl4partition DROP PARTITION (day = 20110102);
ALTER TABLE testdb.tbl4partition DROP PARTITION (day = 20110103);
SHOW PARTITIONS testdb.tbl4partition;
