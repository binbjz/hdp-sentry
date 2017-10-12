CREATE TABLE testdb.table001 (name STRING, ip STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

INSERT INTO testdb.table001 VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.cli.print.header=true;

CREATE TABLE IF NOT EXISTS testdb.table002 LIKE testdb.table001;
INSERT OVERWRITE TABLE testdb.table002 SELECT name, ip FROM testdb.table001 WHERE name='meituan';
SELECT * FROM testdb.table002;

INSERT OVERWRITE TABLE testdb.table002 SELECT * FROM testdb.table001;
SELECT * FROM testdb.table002;

SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM testdb.table002;

DROP TABLE testdb.table001;
DROP TABLE testdb.table002;
