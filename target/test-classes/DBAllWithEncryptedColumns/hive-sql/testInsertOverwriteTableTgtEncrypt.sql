CREATE TABLE encrypt_db4data.table001 (name STRING, ip STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

INSERT INTO encrypt_db4data.table001 VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.cli.print.header=true;

CREATE TABLE IF NOT EXISTS encrypt_db4data.table_tgt LIKE encrypt_db4data.table001;
INSERT OVERWRITE TABLE encrypt_db4data.table_tgt SELECT name, ip FROM encrypt_db4data.table001 WHERE name='meituan';
SELECT * FROM encrypt_db4data.table_tgt;

INSERT OVERWRITE TABLE encrypt_db4data.table_tgt SELECT * FROM encrypt_db4data.table001;
SELECT * FROM encrypt_db4data.table_tgt;

SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM encrypt_db4data.table_tgt;

DROP TABLE encrypt_db4data.table001;
DROP TABLE encrypt_db4data.table_tgt;
