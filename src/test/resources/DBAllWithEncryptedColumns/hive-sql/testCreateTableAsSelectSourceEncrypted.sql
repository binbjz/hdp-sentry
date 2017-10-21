--encrypt_db4data.session_src_encrypted=encrypt_user_id,encrypt_pageview_id,encrypt_page_url,encrypt_referrer_url,encrypt_timestamp
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

USE encrypt_db4data;
CREATE TABLE encrypt_db4data.session_src_encrypted (
  encrypt_user_id STRING
 ,encrypt_pageview_id STRING
 ,encrypt_page_url STRING
 ,encrypt_referrer_url STRING
 ,encrypt_timestamp DOUBLE);
INSERT INTO encrypt_db4data.session_src_encrypted VALUES ('user001', 'pageview001', 'www.baidu.com', 'www.baidu.com/reference_url', 10001430), ('user002', 'pageview002', 'www.meituan.com', 'www.meituan.com/reference_url', 10001930);

SET hive.cli.print.header=true;

CREATE TABLE encrypt_db4data.sessionization_step_one_origins
AS SELECT * FROM encrypt_db4data.session_src_encrypted;

DROP TABLE encrypt_db4data.session_src_encrypted;
