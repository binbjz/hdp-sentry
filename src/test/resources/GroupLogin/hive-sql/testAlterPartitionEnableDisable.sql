USE mart_waimai;

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt = 20110102);
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20110102) ENABLE NO_DROP;
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110102);

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20110102) DISABLE NO_DROP;
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110102);

SHOW PARTITIONS mart_waimai.dim_ad_cpc_activity_poi;
SET hive.cli.print.header=true;

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt = 20110103);
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20110102) ENABLE OFFLINE;
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110103);

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20110103) DISABLE OFFLINE;
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110103);
