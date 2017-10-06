DROP DATABASE IF EXISTS db4partition CASCADE;
CREATE DATABASE db4partition;
CREATE TABLE db4partition.supply (id INT, part STRING, quantity INT)  PARTITIONED BY (day INT);
ALTER TABLE db4partition.supply ADD PARTITION (day = 20110102);
ALTER TABLE db4partition.supply ADD PARTITION (day = 20110103);
ALTER TABLE db4partition.supply ADD PARTITION (day = 20110104);
SHOW PARTITIONS db4partition.supply;
SET hive.cli.print.header=true;
SELECT id, part, quantity FROM db4partition.supply WHERE day >= 20110102 AND day < 20110103 AND quantity < 4 ;
ALTER TABLE db4partition.supply DROP PARTITION (day = 20110102);
ALTER TABLE db4partition.supply DROP PARTITION (day = 20110103);
ALTER TABLE db4partition.supply DROP PARTITION (day = 20110104);
SHOW PARTITIONS db4partition.supply;
DROP TABLE db4partition.supply;
DROP DATABASE db4partition;