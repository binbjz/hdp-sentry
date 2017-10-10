ADD JAR /opt/meituan/qa_test/testfile/hive_qa_udf.jar;
LIST JARS;
CREATE TEMPORARY FUNCTION tmp_qa_lower AS 'com.example.hive.udf.LowerCase';
CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
SHOW FUNCTIONS LIKE '*qa_lower';
DELETE JAR /opt/meituan/qa_test/testfile/hive_qa_udf.jar;
LIST JARS;
