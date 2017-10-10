ALTER TABLE test_db.supply ADD PARTITION (day = 20110104);
SHOW PARTITIONS test_db.supply;
SET hive.cli.print.header=true;
SELECT id, part, quantity FROM test_db.supply WHERE day >= 20110102 AND day < 20110103 AND quantity < 4 ;
ALTER TABLE test_db.supply DROP PARTITION (day = 20110102);
