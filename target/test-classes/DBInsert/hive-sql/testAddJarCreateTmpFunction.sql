--Precondition:
CREATE DATABASE db4func;
USE db4func;
CREATE TABLE teacher (name STRING);

--Execution:
ADD JAR /opt/meituan/qa_test/testfile/hive_qa_udf.jar;
LIST JARS;
CREATE TEMPORARY FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
INSERT INTO teacher VALUES ('TEACHER QA');
SELECT qa_lower(name) as name FROM teacher;
SHOW FUNCTIONS LIKE 'qa_lower';
DELETE JAR /opt/meituan/qa_test/testfile/hive_qa_udf.jar;

--Cleanup:
DROP TABLE teacher;
DROP DATABASE db4func;