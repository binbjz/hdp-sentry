--encrypt_db4data.partition_table_tgt=name
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

USE encrypt_db4data;
CREATE TABLE encrypt_db4data.partition_table001 (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

INSERT INTO encrypt_db4data.partition_table001 PARTITION (dt='20150617', ht='00') VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.cli.print.header=true;

CREATE TABLE IF NOT EXISTS encrypt_db4data.partition_table_tgt LIKE encrypt_db4data.partition_table001;
INSERT OVERWRITE TABLE encrypt_db4data.partition_table_tgt PARTITION (dt='20150617', ht='00') SELECT name, ip FROM encrypt_db4data.partition_table001 WHERE dt='20150617' and ht='00' AND name='meituan';
SELECT COUNT(*) row_count FROM encrypt_db4data.partition_table_tgt;
SELECT * FROM encrypt_db4data.partition_table_tgt;

INSERT OVERWRITE TABLE encrypt_db4data.partition_table_tgt PARTITION (dt, ht) SELECT * FROM encrypt_db4data.partition_table001 WHERE dt='20150617' AND name='baidu';
SELECT COUNT(*) row_count FROM encrypt_db4data.partition_table_tgt;
SELECT * FROM encrypt_db4data.partition_table_tgt;

INSERT OVERWRITE TABLE encrypt_db4data.partition_table_tgt PARTITION (dt='20150617', ht) SELECT name, ip, ht FROM encrypt_db4data.partition_table001 WHERE dt='20150617' and ht='00' AND name='alibaba';
SELECT COUNT(*) row_count FROM encrypt_db4data.partition_table_tgt;
SELECT * FROM encrypt_db4data.partition_table_tgt;

DROP TABLE encrypt_db4data.partition_table001;
DROP TABLE encrypt_db4data.partition_table_tgt;
