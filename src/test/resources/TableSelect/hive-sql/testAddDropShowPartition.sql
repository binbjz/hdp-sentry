SHOW PARTITIONS testdb.supply;
SET hive.cli.print.header=true;
SELECT id, part, quantity FROM testdb.supply WHERE day >= 20110102 AND day < 20110103 AND quantity < 4 ;
ALTER TABLE testdb.supply DROP PARTITION (day = 20110102);
ALTER TABLE testdb.supply DROP PARTITION (day = 20110103);
SHOW PARTITIONS testdb.supply;
DROP TABLE testdb.supply;
