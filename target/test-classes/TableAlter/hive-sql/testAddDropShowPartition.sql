USE testdb;

SET hive.cli.print.header=true;
ALTER TABLE testdb.tbl4partition ADD PARTITION (day = 20110103);
SHOW PARTITIONS testdb.tbl4partition;

SELECT id, part, quantity FROM testdb.tbl4partition WHERE day >= 20110102 AND day < 20110104 AND quantity < 4 ;
ALTER TABLE testdb.tbl4partition DROP PARTITION (day = 20110102);
SHOW PARTITIONS testdb.tbl4partition;
