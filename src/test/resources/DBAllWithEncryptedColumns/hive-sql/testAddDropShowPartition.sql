--encrypt_db4alter.supply=encrypt_id,encrypt_part,encrypt_quantity
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;
CREATE TABLE encrypt_db4alter.supply (encrypt_id INT, encrypt_part STRING, encrypt_quantity INT)  PARTITIONED BY (day INT);
ALTER TABLE encrypt_db4alter.supply ADD PARTITION (day = 20110102);
ALTER TABLE encrypt_db4alter.supply ADD PARTITION (day = 20110103);
SHOW PARTITIONS encrypt_db4alter.supply;
SET hive.cli.print.header=true;

INSERT INTO encrypt_db4alter.supply PARTITION (day = 20110102) VALUES (1,'100',1),(2,'200',2);

SELECT encrypt_id, encrypt_part, encrypt_quantity FROM encrypt_db4alter.supply WHERE day >= 20110102 AND day < 20110103 AND encrypt_quantity < 4 ;
SELECT * FROM encrypt_db4alter.supply;

ALTER TABLE encrypt_db4alter.supply DROP PARTITION (day = 20110102);
ALTER TABLE encrypt_db4alter.supply DROP PARTITION (day = 20110103);

SHOW PARTITIONS encrypt_db4alter.supply;
DROP TABLE encrypt_db4alter.supply;
