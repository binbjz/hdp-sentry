USE mart_waimai;
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt = 20210102);
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt = 20210103);

dfs -ls /user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi/dt=20210102;
dfs -ls /user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi/dt=20210103;
dfs -mkdir -p /user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi_new/dt=20210103;

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20210102) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi/dt=20210103';
--获取table的真实hdfs路径
DESC FORMATTED mart_waimai.dim_ad_cpc_activity_poi;
--获取partition的真实hdfs路径
DESC FORMATTED mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20210102);
DESC FORMATTED mart_waimai.dim_ad_cpc_activity_poi PARTITION (dt = 20210103);
--使用hadoop fs -rmr 命令删除分区的HDFS副本
dfs -rm -r /user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi;
dfs -rm -r /user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi_new;

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20210102);
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi DROP PARTITION (dt = 20210103);
