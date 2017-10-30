USE mart_waimai;

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt = 20110102);
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt = 20110103);
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt = 20110104);
SHOW PARTITIONS mart_waimai.dim_ad_cpc_activity_poi;

SET hive.cli.print.header=true;
SELECT ad_activity_key, ad_activity_id, ad_activity_type, poi_id FROM mart_waimai.dim_ad_cpc_activity_poi WHERE dt >= 20110102 AND day < dt AND ad_activity_type != 0;
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110102);
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110103);
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20110104);
SHOW PARTITIONS mart_waimai.dim_ad_cpc_activity_poi;
