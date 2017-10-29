USE testdb;

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.cli.print.header=true;

INSERT OVERWRITE TABLE testdb.insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='00') SELECT name, ip FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='00' AND name='meituan';
SELECT * FROM testdb.insert_overwrite_tbl_partition;

INSERT OVERWRITE TABLE testdb.insert_overwrite_tbl_partition PARTITION (dt, ht) SELECT * FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' AND name='baidu';
SELECT * FROM testdb.insert_overwrite_tbl_partition;

INSERT OVERWRITE TABLE testdb.insert_overwrite_tbl_partition PARTITION (dt='20150617', ht) SELECT name, ip, ht FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='00';
SELECT * FROM testdb.insert_overwrite_tbl_partition;
