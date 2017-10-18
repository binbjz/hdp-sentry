DROP DATABASE IF EXISTS db4func CASCADE;
CREATE DATABASE db4func;
USE db4func;
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
ADD JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
LIST JARS;
CREATE TEMPORARY FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
SHOW FUNCTIONS LIKE 'qa_lower';
CREATE TABLE teacher (name STRING);
INSERT INTO teacher VALUES ('TEACHER QA');
SELECT qa_lower(name) as name FROM teacher;
LIST JARS;
SHOW FUNCTIONS LIKE '*qa_lower';
DROP TABLE teacher;
DELETE JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;

DROP DATABASE db4func;
