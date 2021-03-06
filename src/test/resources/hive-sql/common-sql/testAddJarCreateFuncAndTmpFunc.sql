USE testdb;

--SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;
--ADD JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
ADD JAR ${env:FILEPATH}/hive_qa_udf.jar;
LIST JARS;
CREATE TEMPORARY FUNCTION tmp_qa_lower AS 'com.example.hive.udf.LowerCase';
CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
SELECT tmp_qa_lower(name) as name FROM tbl4jarfile;
SELECT qa_lower(name) as name FROM tbl4jarfile;
SHOW FUNCTIONS LIKE '*qa_lower';
DROP FUNCTION qa_lower;
SHOW FUNCTIONS LIKE '*qa_lower';
--DELETE JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
DELETE JAR ${env:FILEPATH}/hive_qa_udf.jar;
LIST JARS;
