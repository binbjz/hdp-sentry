USE testdb;

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
ADD JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
LIST JARS;
CREATE TEMPORARY FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
CREATE TABLE teacher (name STRING);
INSERT INTO teacher VALUES ('TEACHER QA');
SELECT qa_lower(name) as name FROM teacher;
SHOW FUNCTIONS LIKE '*qa_lower';
DROP TABLE teacher;
DELETE JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;