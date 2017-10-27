USE testdb;

ALTER TABLE testdb.tbl4partiton ADD PARTITION (day = 20110102);
ALTER TABLE testdb.tbl4partiton ADD PARTITION (day = 20110103);
SHOW PARTITIONS testdb.tbl4partiton;
SET hive.cli.print.header=true;
SELECT id, part, quantity FROM testdb.tbl4partiton WHERE day >= 20110102 AND day < 20110103 AND quantity < 4 ;
ALTER TABLE testdb.tbl4partiton DROP PARTITION (day = 20110102);
ALTER TABLE testdb.tbl4partiton DROP PARTITION (day = 20110103);

ALTER TABLE testdb.tbl4partiton DROP PARTITION (day = 20110101);
SHOW PARTITIONS testdb.tbl4partiton;
