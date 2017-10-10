SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${env:FILEPATH}/test_file.txt' INTO TABLE testDB.collecttest;

SELECT str, concat_ws( ',' , collect(cast(countVal AS STRING))) FROM testDB.collecttest GROUP BY str;
SELECT str, count(*) as val FROM testDB.collecttest GROUP BY str;
SELECT count(*) FROM testDB.collecttest;
