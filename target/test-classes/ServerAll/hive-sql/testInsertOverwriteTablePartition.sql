DROP DATABASE IF EXISTS db4partition CASCADE;
CREATE DATABASE db4partition;
CREATE TABLE db4partition.partition_table001 (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

INSERT INTO db4partition.partition_table001 PARTITION (dt='20150617', ht='00') VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.cli.print.header=true;

CREATE TABLE IF NOT EXISTS db4partition.partition_table002 LIKE db4partition.partition_table001;

INSERT OVERWRITE TABLE db4partition.partition_table002 PARTITION (dt='20150617', ht='00') SELECT name, ip FROM db4partition.partition_table001 WHERE dt='20150617' and ht='00' AND name='meituan';
SELECT * FROM db4partition.partition_table002;

INSERT OVERWRITE TABLE db4partition.partition_table002 PARTITION (dt, ht) SELECT * FROM db4partition.partition_table001 WHERE dt='20150617' AND name='baidu';
SELECT * FROM db4partition.partition_table002;

INSERT OVERWRITE TABLE db4partition.partition_table002 PARTITION (dt='20150617', ht) SELECT name, ip, ht FROM db4partition.partition_table001 WHERE dt='20150617' and ht='00' AND name='alibaba';
SELECT * FROM db4partition.partition_table002;

DROP TABLE db4partition.partition_table001;
DROP TABLE db4partition.partition_table002;
DROP DATABASE db4partition;
