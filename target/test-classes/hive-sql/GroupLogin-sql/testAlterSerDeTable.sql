USE mart_waimai;

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
SHOW CREATE TABLE mart_waimai.dim_ad_cpc_activity_poi;
