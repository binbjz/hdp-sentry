INSERT INTO testDB.partition_table001 PARTITION (dt='20150617', ht='00') VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.cli.print.header=true;

INSERT OVERWRITE TABLE testDB.partition_table002 PARTITION (dt='20150617', ht='00') SELECT name, ip FROM testDB.partition_table001 WHERE dt='20150617' and ht='00' AND name='meituan';
SELECT * FROM testDB.partition_table002;
INSERT OVERWRITE TABLE testDB.partition_table002 PARTITION (dt, ht) SELECT * FROM testDB.partition_table001 WHERE dt='20150617' AND name='baidu';
SELECT * FROM testDB.partition_table002;
INSERT OVERWRITE TABLE testDB.partition_table002 PARTITION (dt='20150617', ht) SELECT name, ip, ht FROM testDB.partition_table001 WHERE dt='20150617' and ht='00' AND name='alibaba';
SELECT * FROM testDB.partition_table002;
