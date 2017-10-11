CREATE TABLE encrypt_db4alter.supply (id INT, part STRING, quantity INT)  PARTITIONED BY (day INT);
ALTER TABLE encrypt_db4alter.supply ADD PARTITION (day = 20110102);
ALTER TABLE encrypt_db4alter.supply ADD PARTITION (day = 20110103);
ALTER TABLE encrypt_db4alter.supply ADD PARTITION (day = 20110104);
SHOW PARTITIONS encrypt_db4alter.supply;
SET hive.cli.print.header=true;
SELECT id, part, quantity FROM encrypt_db4alter.supply WHERE day >= 20110102 AND day < 20110103 AND quantity < 4 ;
ALTER TABLE encrypt_db4alter.supply DROP PARTITION (day = 20110102);
ALTER TABLE encrypt_db4alter.supply DROP PARTITION (day = 20110103);
ALTER TABLE encrypt_db4alter.supply DROP PARTITION (day = 20110104);

SELECT * FROM encrypt_db4alter.supply;

SHOW PARTITIONS encrypt_db4alter.supply;
DROP TABLE encrypt_db4alter.supply;
