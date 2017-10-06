DROP DATABASE IF EXISTS test_db2 CASCADE;
CREATE DATABASE test_db2;
CREATE TABLE test_db2.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';

set FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE test_db2.collecttest;

SELECT str, concat_ws( ',' , collect_set(cast(countVal AS STRING))) as val FROM test_db2.collecttest GROUP BY str;

SELECT str, count(*) as val FROM test_db2.collecttest GROUP BY str;
SELECT count(*) FROM test_db2.collecttest;

DROP DATABASE test_db2 CASCADE;