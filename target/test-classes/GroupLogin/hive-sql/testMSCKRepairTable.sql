USE mart_waimai;

-- 创建两个分区目录
dfs -mkdir /user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi/dt = 20170102;
dfs -mkdir /user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi/dt = 20170103;
-- 使用MSCK修复分区
MSCK REPAIR TABLE mart_waimai.dim_ad_cpc_activity_poi;
-- 再次查看，发现已经成功更新元信息
SHOW PARTITIONS mart_waimai.dim_ad_cpc_activity_poi;
dfs -ls -R /user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi/dt = 20170102;
dfs -ls -R /user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi/dt = 20170103;

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20170102);
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20170103);
