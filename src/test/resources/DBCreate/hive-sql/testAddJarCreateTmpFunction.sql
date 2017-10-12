SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
ADD JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
LIST JARS;
CREATE TEMPORARY FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
DELETE JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
LIST JARS;
SHOW FUNCTIONS LIKE '*qa_lower';
