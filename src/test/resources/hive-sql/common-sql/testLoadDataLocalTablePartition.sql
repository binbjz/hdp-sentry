USE testdb;

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE testdb.load_data_local_into_partition
PARTITION (country = 'US', state = 'CA');

SELECT * FROM testdb.load_data_local_into_partition;
