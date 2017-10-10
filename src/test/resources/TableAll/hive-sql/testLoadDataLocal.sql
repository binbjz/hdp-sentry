set FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

CREATE TABLE testDB.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/afile.txt' INTO TABLE testDB.collecttest;

SELECT str, concat_ws( ',' , collect_set(cast(countVal AS STRING))) FROM testDB.collecttest GROUP BY str;
SELECT str, count(*) as val FROM testDB.collecttest GROUP BY str;
SELECT count(*) FROM testDB.collecttest;

DROP TABLE testDB.collecttest;
