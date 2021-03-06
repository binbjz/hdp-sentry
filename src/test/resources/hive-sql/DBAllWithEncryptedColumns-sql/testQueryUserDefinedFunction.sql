--encrypt_db4func.teacher=name
--CREATE DATABASE encrypt_db4func;
--DROP DATABASE encrypt_db4func;

USE encrypt_db4func;

--SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;
--ADD JAR  ${hiveconf:FILEPATH}/hive_qa_udf.jar;
ADD JAR  ${env:FILEPATH}/hive_qa_udf.jar;
LIST JARS;
CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
CREATE TEMPORARY FUNCTION tmp_qa_lower AS 'com.example.hive.udf.LowerCase';
CREATE TABLE teacher (name STRING);
INSERT INTO teacher VALUES ('TEACHER QA');
SELECT * FROM teacher;
SELECT qa_lower(name) as name FROM teacher;
SELECT tmp_qa_lower(name) as name  FROM teacher;
SHOW FUNCTIONS LIKE '*qa_lower';
DROP TABLE teacher;
--DELETE JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
DELETE JAR ${env:FILEPATH}/hive_qa_udf.jar;
