CREATE  TABLE `dim.ndm_user`(
 `userid` int COMMENT '用户ID',
 `cityid` smallint COMMENT '城市ID',
 `username` string COMMENT '用户昵称',
 `email` string COMMENT '验证后的主邮箱',
 `mobile` bigint COMMENT '验证后的主手机号',
 `regdate` string COMMENT '注册日期',
 `isemailverified` tinyint COMMENT '是否认证Email',
 `ismobilesignup` tinyint COMMENT '是否来自手机注册',
 `ismobileverified` tinyint COMMENT '是否认证手机',
 `isappuser` tinyint COMMENT '是否连接过第三方平台',
 `acctattr` int COMMENT '用户账户属性值')
COMMENT '用户维度表'
ROW FORMAT SERDE
 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
 'field.delim'='\t',
 'line.delim'='\n',
 'serialization.format'='\t')
STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
 'viewfs://hadoop-meituan-test/user/hive/warehouse/dim.db/ndm_user'
TBLPROPERTIES (
 'numFiles'='163',
 'last_modified_by'='hadoop-data',
 'last_modified_time'='1477023477',
 'transient_lastDdlTime'='1508259333',
 'COLUMN_STATS_ACCURATE'='false',
 'totalSize'='65292873192',
 'numRows'='-1',
 'rawDataSize'='-1');

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
INSERT INTO dim.ndm_user( userid, cityid, username, email, mobile, regdate, isemailverified, ismobilesignup, ismobileverified, isappuser, acctattr)
VALUES (1001, 1001, 'user_nick_name', 'super_star@mt.com', 17323477766,'2016-06-06', 1, 1, 1, 1, 1);

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

CREATE TABLE dim.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE dim.collecttest;
