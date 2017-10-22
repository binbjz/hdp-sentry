USE db4func;

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
ADD JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
LIST JARS;
CREATE TEMPORARY FUNCTION tmp_qa_lower AS 'com.example.hive.udf.LowerCase';
CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
INSERT INTO teacher VALUES ('TEACHER QA');
SELECT tmp_qa_lower(name) as name FROM teacher;
SELECT qa_lower(name) as name FROM teacher;
SHOW FUNCTIONS LIKE '*qa_lower';
DELETE JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
DROP FUNCTION qa_lower;
SHOW FUNCTIONS LIKE '*qa_lower';
