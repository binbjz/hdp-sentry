ALTER TABLE testDB.supply ADD PARTITION (day = 20110104);
SHOW PARTITIONS testDB.supply;
SET hive.cli.print.header=true;
SELECT id, part, quantity FROM testDB.supply WHERE day >= 20110102 AND day < 20110103 AND quantity < 4 ;
ALTER TABLE testDB.supply DROP PARTITION (day = 20110102);
SHOW PARTITIONS testDB.supply;
