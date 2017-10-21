SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

CREATE TABLE testdb.collecttest (str STRING, countval INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE testdb.collecttest;

SELECT str, concat_ws( ',' , collect_set(cast(countval AS STRING))) FROM testdb.collecttest GROUP BY str;

SELECT str, count(*) as val FROM testdb.collecttest GROUP BY str;

SELECT count(*) FROM testdb.collecttest;

DROP TABLE testdb.collecttest;
