SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${env:FILEPATH}/test_file.txt' INTO TABLE test_db.collecttest;

SELECT str, concat_ws( ',' , collect(cast(countVal AS STRING))) FROM test_db.collecttest GROUP BY str;
SELECT str, count(*) as val FROM test_db.collecttest GROUP BY str;
SELECT count(*) FROM test_db.collecttest;
