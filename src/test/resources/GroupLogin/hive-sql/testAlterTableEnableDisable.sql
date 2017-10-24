USE mart_waimai;

ALTER TABLE mart_waimai.test_enable_disable1 ENABLE NO_DROP;
DROP TABLE mart_waimai.test_enable_disable1;
ALTER TABLE mart_waimai.test_enable_disable1 DISABLE NO_DROP;
DROP TABLE mart_waimai.test_enable_disable1;

ALTER TABLE mart_waimai.test_enable_disable2 ENABLE OFFLINE;
DROP TABLE mart_waimai.test_enable_disable2;
ALTER TABLE mart_waimai.test_enable_disable2 DISABLE OFFLINE;
DROP TABLE mart_waimai.test_enable_disable2;
