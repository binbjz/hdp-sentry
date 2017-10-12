SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE db4load.collecttest;
SELECT str, concat_ws( ',' , collect_set(cast(countVal AS STRING))) as val FROM db4load.collecttest GROUP BY str;
SELECT str, count(*) as val FROM db4load.collecttest GROUP BY str;
SELECT count(*) FROM db4load.collecttest;
