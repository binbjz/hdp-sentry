INSERT INTO test_db.table001 VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.cli.print.header=true;

INSERT OVERWRITE TABLE test_db.table002 SELECT name, ip FROM test_db.table001 WHERE name='meituan';
SELECT * FROM test_db.table002;

INSERT OVERWRITE TABLE test_db.table002 SELECT * FROM test_db.table001;
SELECT * FROM test_db.table002;

SELECT ROW_NUMBER() OVER(PARTITION BY ip DESC) ID, name, ip FROM test_db.table002;
