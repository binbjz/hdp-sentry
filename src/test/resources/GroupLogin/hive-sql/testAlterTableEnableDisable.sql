USE mart_waimai;

CREATE TABLE IF NOT EXISTS mart_waimai.test_enable_disable1 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE TABLE IF NOT EXISTS mart_waimai.test_enable_disable2 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE mart_waimai.test_enable_disable1 ENABLE NO_DROP;
DROP TABLE mart_waimai.test_enable_disable1;
ALTER TABLE mart_waimai.test_enable_disable1 DISABLE NO_DROP;
DROP TABLE mart_waimai.test_enable_disable1;

ALTER TABLE mart_waimai.test_enable_disable2 ENABLE OFFLINE;
DROP TABLE mart_waimai.test_enable_disable2;
ALTER TABLE mart_waimai.test_enable_disable2 DISABLE OFFLINE;
DROP TABLE mart_waimai.test_enable_disable2;
