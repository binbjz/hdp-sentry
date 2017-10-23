USE dim;
SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
ADD JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;
LIST JARS;
CREATE TEMPORARY FUNCTION tmp_qa_lower AS 'com.example.hive.udf.LowerCase';
CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
SELECT tmp_qa_lower(username) as username FROM dim.ndm_user;
SELECT qa_lower(username) as username FROM dim.ndm_user;
SHOW FUNCTIONS LIKE '*qa_lower';
DROP FUNCTION qa_lower;
SHOW FUNCTIONS LIKE '*qa_lower';
DELETE JAR ${hiveconf:FILEPATH}/hive_qa_udf.jar;

/*
 用户维度表
 userid 用户ID
 cityid   城市ID
 username   用户昵称
 email  验证后的主邮箱
 mobile   验证后的主手机号
 regdate   注册日期
 isemailverified  是否认证Email
 ismobilesignup   是否来自手机注册
 ismobileverified 是否认证手机
 isappuser  是否连接过第三方平台
 acctattr 用户账户属性值*/
--INSERT INTO dim.ndm_user( userid, cityid, username, email, mobile, regdate, isemailverified, ismobilesignup, ismobileverified, isappuser, acctattr)
--VALUES (1001, 1001, 'user_nick_name', 'super_star@mt.com', 17323477766,'2016-06-06', 1, 1, 1, 1, 1);
