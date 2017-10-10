CREATE TABLE test_db.table001 (name STRING, ip STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

INSERT INTO test_db.table001 VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.cli.print.header=true;

CREATE TABLE IF NOT EXISTS test_db.table002 LIKE test_db.table001;
INSERT OVERWRITE TABLE test_db.table002 SELECT name, ip FROM test_db.table001 WHERE name='meituan';
SELECT * FROM test_db.table002;

INSERT OVERWRITE TABLE test_db.table002 SELECT * FROM test_db.table001;
SELECT * FROM test_db.table002;

SELECT ROW_NUMBER() OVER(PARTITION BY ip DESC) ID, name, ip FROM test_db.table002;

DROP TABLE test_db.table001;
DROP TABLE test_db.table002;
