INSERT INTO test_db.partition_table001 PARTITION (dt='20150617', ht='00') VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.cli.print.header=true;

INSERT OVERWRITE TABLE test_db.partition_table002 PARTITION (dt='20150617', ht='00') SELECT name, ip FROM test_db.partition_table001 WHERE dt='20150617' and ht='00' AND name='meituan';
SELECT * FROM test_db.partition_table002;
INSERT OVERWRITE TABLE test_db.partition_table002 PARTITION (dt, ht) SELECT * FROM test_db.partition_table001 WHERE dt='20150617' AND name='baidu';
SELECT * FROM test_db.partition_table002;
INSERT OVERWRITE TABLE test_db.partition_table002 PARTITION (dt='20150617', ht) SELECT name, ip, ht FROM test_db.partition_table001 WHERE dt='20150617' and ht='00' AND name='alibaba';
SELECT * FROM test_db.partition_table002;