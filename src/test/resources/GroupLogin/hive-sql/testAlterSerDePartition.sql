USE mart_waimai;
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt = 20190104);
DESCRIBE EXTENDED mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20190104);

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20190104) SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
DESCRIBE EXTENDED mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20190104);
