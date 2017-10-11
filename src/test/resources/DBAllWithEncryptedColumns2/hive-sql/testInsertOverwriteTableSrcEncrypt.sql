CREATE TABLE encrypt_db4data.table_src (name STRING, ip STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

INSERT INTO encrypt_db4data.table_src VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.cli.print.header=true;

CREATE TABLE IF NOT EXISTS encrypt_db4data.table002 LIKE encrypt_db4data.table_src;
INSERT OVERWRITE TABLE encrypt_db4data.table002 SELECT name, ip FROM encrypt_db4data.table_src WHERE name='meituan';
SELECT * FROM encrypt_db4data.table002;

INSERT OVERWRITE TABLE encrypt_db4data.table002 SELECT * FROM encrypt_db4data.table_src;
SELECT * FROM encrypt_db4data.table002;

SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM encrypt_db4data.table002;

DROP TABLE encrypt_db4data.table_src;
DROP TABLE encrypt_db4data.table002;
