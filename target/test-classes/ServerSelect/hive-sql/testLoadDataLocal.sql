SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${env:FILEPATH}/test_file.txt' INTO TABLE testdb.collecttest;

SELECT str, concat_ws( ',' , collect(cast(countVal AS STRING))) FROM testdb.collecttest GROUP BY str;
<<<<<<< HEAD

SELECT str, count(*) as val FROM testdb.collecttest GROUP BY str;

=======
SELECT str, count(*) as val FROM testdb.collecttest GROUP BY str;
>>>>>>> b0450854b2f7ed1c2e1b2c8651afe9e2db333a37
SELECT count(*) FROM testdb.collecttest;
