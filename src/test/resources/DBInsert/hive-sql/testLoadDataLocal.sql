--Precondition:
CREATE DATABASE db4load;
CREATE TABLE db4load.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';

--Execution:
--export FILEPATH=/opt/meituan/qa_test/testfile
--LOAD DATA LOCAL INPATH '${env:FILEPATH}/test_file.txt' INTO TABLE db4load.collecttest;
set FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE db4load.collecttest;
SELECT str, concat_ws( ',' , collect_set(cast(countVal AS STRING))) as val FROM db4load.collecttest GROUP BY str;
SELECT str, count(*) as val FROM db4load.collecttest GROUP BY str;
SELECT count(*) FROM db4load.collecttest;

--Cleanup
DROP DATABASE db4load CASCADE;