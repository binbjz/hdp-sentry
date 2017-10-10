CREATE TABLE testDB.table001 (name STRING, ip STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

INSERT INTO testDB.table001 VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.cli.print.header=true;

CREATE TABLE IF NOT EXISTS testDB.table002 LIKE testDB.table001;
INSERT OVERWRITE TABLE testDB.table002 SELECT name, ip FROM testDB.table001 WHERE name='meituan';
SELECT * FROM testDB.table002;

INSERT OVERWRITE TABLE testDB.table002 SELECT * FROM testDB.table001;
SELECT * FROM testDB.table002;

SELECT ROW_NUMBER() OVER(PARTITION BY ip DESC) ID, name, ip FROM testDB.table002;

DROP TABLE testDB.table001;
DROP TABLE testDB.table002;
