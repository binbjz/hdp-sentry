USE mart_waimai;

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20110122) ENABLE NO_DROP;
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110122);

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20110122) DISABLE NO_DROP;
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110122);

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20110123) ENABLE OFFLINE;
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110123);

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20110123) DISABLE OFFLINE;
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110123);
