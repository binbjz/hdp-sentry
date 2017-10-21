--DROP TABLE testdb.collecttest;
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

CREATE TABLE testdb.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE testdb.collecttest;

SELECT str, concat_ws( ',' , collect_setcast(countVal AS STRING))) FROM testdb.collecttest GROUP BY str;

SELECT str, count(*) as val FROM testdb.collecttest GROUP BY str;

SELECT count(*) FROM testdb.collecttest;
