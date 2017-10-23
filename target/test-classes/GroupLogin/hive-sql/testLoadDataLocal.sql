USE mart_waimai;

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

CREATE TABLE collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE collecttest;

SELECT str, concat_ws( ',' , collect(cast(countVal AS STRING))) FROM collecttest GROUP BY str;

SELECT str, count(*) as val FROM collecttest GROUP BY str;

SELECT count(*) FROM collecttest;

DROP TABLE collecttest;


USE dim;
SELECT str, concat_ws( ',' , collect(cast(countVal AS STRING))) FROM collecttest GROUP BY str;

SELECT str, count(*) as val FROM collecttest GROUP BY str;

SELECT count(*) FROM collecttest;
