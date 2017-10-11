USE db4func;
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
ADD JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
LIST JARS;
CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
CREATE TEMPORARY FUNCTION tmp_qa_lower AS 'com.example.hive.udf.LowerCase';
SHOW FUNCTIONS LIKE '*qa_lower';
DELETE JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
LIST JARS;
