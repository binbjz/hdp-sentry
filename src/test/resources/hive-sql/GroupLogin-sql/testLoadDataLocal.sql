USE mart_waimai;

--SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;

--LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE collecttest;
LOAD DATA LOCAL INPATH '${env:FILEPATH}/test_file.txt' INTO TABLE collecttest;

SELECT str, concat_ws( ',' , collect(cast(countVal AS STRING))) FROM collecttest GROUP BY str;

SELECT str, count(*) as val FROM collecttest GROUP BY str;

SELECT count(*) FROM collecttest;

USE dim;
SELECT str, concat_ws( ',' , collect(cast(countVal AS STRING))) FROM collecttest GROUP BY str;

SELECT str, count(*) as val FROM collecttest GROUP BY str;

SELECT count(*) FROM collecttest;
