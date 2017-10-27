--DROP DATABASE IF EXISTS db4data CASCADE;
--CREATE DATABASE db4data;
--CREATE TABLE db4data.table001 (name STRING, ip STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";
--CREATE TABLE IF NOT EXISTS db4data.table002 LIKE db4data.table001;

--DROP TABLE db4data.table001;
--DROP TABLE db4data.table002;
--DROP DATABASE db4data;

USE db4data;

INSERT INTO db4data.table001 VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.cli.print.header=true;

INSERT OVERWRITE TABLE db4data.table002 SELECT name, ip FROM db4data.table001 WHERE name='meituan';
SELECT * FROM db4data.table002;

INSERT OVERWRITE TABLE db4data.table002 SELECT * FROM db4data.table001;
SELECT * FROM db4data.table002;

SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM db4data.table002;
