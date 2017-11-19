USE testdb;

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt'
INTO TABLE testdb.load_data_local_into_table;

SELECT * FROM testdb.load_data_local_into_table;
