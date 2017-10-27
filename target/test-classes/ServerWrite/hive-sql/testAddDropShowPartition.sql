--DROP DATABASE IF EXISTS db4partition CASCADE;
--CREATE DATABASE db4partition;
--CREATE TABLE db4partition.tbl4partition (id INT, part STRING, quantity INT) PARTITIONED BY (day INT);

--DROP TABLE db4partition.tbl4partition;
--DROP DATABASE db4partition;

USE db4partition;
ALTER TABLE db4partition.tbl4partition ADD PARTITION (day = 20110102);
ALTER TABLE db4partition.tbl4partition ADD PARTITION (day = 20110103);
ALTER TABLE db4partition.tbl4partition ADD PARTITION (day = 20110104);
SHOW PARTITIONS db4partition.tbl4partition;
SET hive.cli.print.header=true;
SELECT id, part, quantity FROM db4partition.tbl4partition WHERE day >= 20110102 AND day < 20110103 AND quantity < 4 ;
ALTER TABLE db4partition.tbl4partition DROP PARTITION (day = 20110102);
ALTER TABLE db4partition.tbl4partition DROP PARTITION (day = 20110103);
ALTER TABLE db4partition.tbl4partition DROP PARTITION (day = 20110104);
SHOW PARTITIONS db4partition.tbl4partition;
