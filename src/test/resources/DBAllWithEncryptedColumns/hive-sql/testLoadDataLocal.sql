CREATE TABLE encrypt_db4data.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE encrypt_db4data.collecttest;


SELECT str, concat_ws( ',' , collect(cast(countVal AS STRING))) FROM encrypt_db4data.collecttest GROUP BY str;
eleven 11,10
twelve 12,1
SELECT str, count(*) as val FROM encrypt_db4data.collecttest GROUP BY str;
SELECT count(*) FROM encrypt_db4data.collecttest;

dfs -cat /user/warehouse/hive/encrypt_db4data.db/collecttest/test_file.txt
dfs -copyToLocal /user/warehouse/hive/encrypt_db4data.db/collecttest/test_file.txt /tmp
!cat /tmp/test_file.txt;
DROP TABLE encrypt_db4data.collecttest;
