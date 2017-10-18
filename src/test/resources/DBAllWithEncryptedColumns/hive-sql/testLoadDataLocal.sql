--encrypt_db4data.collecttest=str,countVal
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

USE encrypt_db4data;

CREATE TABLE encrypt_db4data.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE encrypt_db4data.collecttest;

SELECT str, concat_ws( ',' , collect_set(cast(countVal AS STRING))) FROM encrypt_db4data.collecttest GROUP BY str;
SELECT str, count(*) as val FROM encrypt_db4data.collecttest GROUP BY str;
SELECT count(*) FROM encrypt_db4data.collecttest;

dfs -cat /user/hive/warehouse/encrypt_db4data.db/collecttest/test_file.txt;
dfs -copyToLocal /user/hive/warehouse/encrypt_db4data.db/collecttest/test_file.txt /tmp;
!cat /tmp/test_file.txt;
!rm /tmp/test_file.txt;
DROP TABLE encrypt_db4data.collecttest;
