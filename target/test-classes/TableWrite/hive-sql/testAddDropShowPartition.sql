--DROP TABLE testdb.test_partition;
--server=server1->db=test_db->table=test_partition->action=alter
--server=server1->db=test_db->table=test_partition->action=create
--server=server1->db=test_db->table=test_partition->action=insert


--Execution:
ALTER TABLE testdb.test_partition ADD PARTITION (day = 20110102);
ALTER TABLE testdb.test_partition ADD PARTITION (day = 20110103);
SHOW PARTITIONS testdb.test_partition;
SET hive.cli.print.header=true;
SELECT id, part, quantity FROM testdb.test_partition WHERE day >= 20110102 AND day < 20110103 AND quantity < 4 ;
ALTER TABLE testdb.test_partition DROP PARTITION (day = 20110102);
ALTER TABLE testdb.test_partition DROP PARTITION (day = 20110103);
SHOW PARTITIONS testdb.test_partition;
DROP TABLE testdb.test_partition;
