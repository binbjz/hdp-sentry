--encrypt_db4alter.tbl4fileformat=encrypt_hms,encrypt_severity,encrypt_server,encrypt_process_id,encrypt_message
--encrypt_db4alter.tbl4fileformat_external=encrypt_hms,encrypt_severity,encrypt_server,encrypt_process_id,encrypt_message
--CREATE DATABASE encrypt_db4alter;
--DROP DATABASE encrypt_db4alter;

USE encrypt_db4alter;

CREATE TABLE IF NOT EXISTS encrypt_db4alter.tbl4fileformat (encrypt_hms INT, encrypt_severity STRING, encrypt_server STRING, encrypt_process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE encrypt_db4alter.tbl4fileformat ADD PARTITION(year = 2011, month = 1, day = 1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4alter.db/tbl4fileformat/2011/01/01';
DESCRIBE EXTENDED encrypt_db4alter.tbl4fileformat PARTITION (year = 2011, month = 1, day = 1);

ALTER TABLE encrypt_db4alter.tbl4fileformat PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
SHOW PARTITIONS encrypt_db4alter.tbl4fileformat;
DESCRIBE EXTENDED encrypt_db4alter.tbl4fileformat PARTITION (year = 2011, month = 1, day = 1);
ALTER TABLE encrypt_db4alter.tbl4fileformat SET FILEFORMAT SEQUENCEFILE;

SELECT * FROM encrypt_db4alter.tbl4fileformat;

CREATE EXTERNAL TABLE IF NOT EXISTS encrypt_db4alter.tbl4fileformat_external (encrypt_hms INT, encrypt_severity STRING, encrypt_server STRING, encrypt_process_id INT, encrypt_message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE encrypt_db4alter.tbl4fileformat_external ADD PARTITION(year = 2011, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4alter.db/tbl4fileformat_external/2011/01/02';
DESCRIBE EXTENDED encrypt_db4alter.tbl4fileformat_external PARTITION (year = 2011, month = 1, day = 2);

ALTER TABLE encrypt_db4alter.tbl4fileformat_external PARTITION (year = 2011, month = 1, day = 2) SET FILEFORMAT SEQUENCEFILE;
SHOW PARTITIONS encrypt_db4alter.tbl4fileformat_external;
DESCRIBE EXTENDED encrypt_db4alter.tbl4fileformat_external PARTITION (year = 2011, month = 1, day = 2);
ALTER TABLE encrypt_db4alter.tbl4fileformat_external SET FILEFORMAT SEQUENCEFILE;

SELECT * FROM encrypt_db4alter.tbl4fileformat_external;

DROP TABLE encrypt_db4alter.tbl4fileformat;
DROP TABLE encrypt_db4alter.tbl4fileformat_external;
dfs -rm -r /user/hive/warehouse/encrypt_db4alter.db/tbl4fileformat_external;
