USE testdb;

INSERT INTO testdb.src_insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='00') VALUES ('alibaba', '10.0.0.3');
--existing partition
INSERT INTO testdb.src_insert_overwrite_tbl_partition PARTITION (dt='20150617', ht='01') VALUES ('alibaba', '10.0.0.3');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.cli.print.header=true;

SELECT name, ip FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='00' AND name='alibaba';
SELECT name, ip FROM testdb.src_insert_overwrite_tbl_partition WHERE dt='20150617' and ht='01' AND name='alibaba';
