--DROP TABLE db4func.teacher;
--DROP DATABASE db4func;

DROP DATABASE IF EXISTS db4func CASCADE;
CREATE DATABASE db4func;
USE db4func;
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
ADD JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
LIST JARS;
CREATE TEMPORARY FUNCTION tmp_qa_lower AS 'com.example.hive.udf.LowerCase';
CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
SHOW FUNCTIONS LIKE 'qa_lower';
CREATE TABLE teacher (name STRING);
INSERT INTO teacher VALUES ('TEACHER QA');
SELECT tmp_qa_lower(name) as name FROM teacher;
SELECT qa_lower(name) as name FROM teacher;
LIST JARS;
SHOW FUNCTIONS LIKE '*qa_lower';
DROP FUNCTION qa_lower;
SHOW FUNCTIONS LIKE '*qa_lower';

DELETE JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
