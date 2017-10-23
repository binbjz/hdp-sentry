CREATE  TABLE `mart_waimai.dim_act_type`(
 `act_type_id` int COMMENT '活动类型id',
 `act_type_name` string COMMENT '活动类型名称',
 `act_category_id` int COMMENT '活动类型大类id',
 `act_category_name` string COMMENT '活动类型大类名称',
 `root_act_id` int COMMENT '',
 `root_act_name` string COMMENT '全部')
COMMENT '活动类型'
ROW FORMAT SERDE
 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
WITH SERDEPROPERTIES (
 'field.delim'='\t',
 'line.delim'='\n',
 'serialization.format'='\t')
STORED AS INPUTFORMAT
 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
LOCATION
 'viewfs://hadoop-meituan/nn23/warehouse/mart_waimai.db/dim_act_type'
TBLPROPERTIES (
 'numFiles'='1',
 'last_modified_by'='hadoop-waimai',
 'last_modified_time'='1484289639',
 'transient_lastDdlTime'='1501348539',
 'COLUMN_STATS_ACCURATE'='false',
 'totalSize'='1010',
 'numRows'='-1',
 'rawDataSize'='-1');

CREATE  TABLE `mart_waimai.dim_ad_cpc_activity_poi`(
 `ad_activity_key` string COMMENT '维度代理键',
 `ad_activity_id` bigint COMMENT '活动id',
 `ad_activity_type` int COMMENT '活动类型代码',
 `poi_id` int COMMENT '活动目标门店')
COMMENT 'CPC广告城市目标商家数'
PARTITIONED BY (
 `dt` string COMMENT '状态归属时间：etl每日保存上日券状态没有终结的券的信息')
ROW FORMAT SERDE
 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
WITH SERDEPROPERTIES (
 'field.delim'='\t',
 'line.delim'='\n',
 'serialization.format'='\t')
STORED AS INPUTFORMAT
 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
LOCATION
 'viewfs://hadoop-meituan/nn23/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi'
TBLPROPERTIES (
 'transient_lastDdlTime'='1482166667');

CREATE  TABLE `mart_waimai.dim_ad_cpc_activity`(
 `ad_activity_key` string COMMENT '维度代理键',
 `ad_activity_id` bigint COMMENT '活动id',
 `ad_activity_name` string COMMENT '活动名称',
 `ad_activity_type` int COMMENT '活动类型代码',
 `ad_activity_type_name` string COMMENT '活动类型',
 `ad_activity_status` int COMMENT '活动状态代码 1：上线 2：下线',
 `ad_activity_status_name` string COMMENT '活动状态',
 `direction` int COMMENT '商家定向 1：城市 2：具体门店',
 `city_id` int COMMENT '城市定向ID，direction值如果为1，则该值为城市定向所指定的城市，direction为2时，该值应为0，无业务含义',
 `send_status` int COMMENT '发券状态：发券状态 1：已发 0：未发 .该字段在充赠活动置空，在运营活动固定为0.仅在补贴活动中有标记性含义',
 `start_time` bigint COMMENT '活动开始时间',
 `end_time` bigint COMMENT '活动结束时间',
 `start_dt` int COMMENT '活动开始日期',
 `end_dt` int COMMENT '活动结束日期')
COMMENT 'CPC广告券活动维度表'
PARTITIONED BY (
 `dt` string)
ROW FORMAT SERDE
 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
WITH SERDEPROPERTIES (
 'field.delim'='\t',
 'line.delim'='\n',
 'serialization.format'='\t')
STORED AS INPUTFORMAT
 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
LOCATION
 'viewfs://hadoop-meituan/nn23/warehouse/mart_waimai.db/dim_ad_cpc_activity'
TBLPROPERTIES (
 'last_modified_by'='hadoop-waimai',
 'last_modified_time'='1484568134',
 'transient_lastDdlTime'='1484568134');

CREATE  TABLE `mart_waimai.dim_aor_ord_price_level_his`(
 `client` int COMMENT '1:C端维度  2：B端维度',
 `aor_id` int COMMENT '蜂窝id',
 `aor_type` tinyint COMMENT '蜂窝类型 1校园 2白领 ',
 `price_level` int COMMENT '原价分段级别：1->[0,10),2->[10,15),3->[15,20),4->[20,25),5->[25,30),6->[30,35),7->[35,40),8->[40,45),9->[45,50),10->[50,60),11->[60,70),12->[70,80),13->[80,90),14->[90,100),15->[100,150),16->[150,200),17:>=200',
 `order_num` int COMMENT '订单量')
COMMENT '蜂窝级别原价交易额分段订单量'
PARTITIONED BY (
 `mo` string COMMENT '月号',
 `wk` string COMMENT '自然周',
 `dt` string COMMENT 'dt')
ROW FORMAT SERDE
 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
 'field.delim'='\t',
 'line.delim'='\n',
 'serialization.format'='\t')
STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
 'viewfs://hadoop-meituan/nn23/warehouse/mart_waimai.db/dim_aor_ord_price_level_his'
TBLPROPERTIES (
 'last_modified_by'='hadoop-waimai',
 'last_modified_time'='1488572832',
 'transient_lastDdlTime'='1488572832');

CREATE  TABLE `mart_waimai.cis_mappoi_in_aor`(
 `poi_id` string,
 `aor_id` int,
 `city_id` int)
PARTITIONED BY (
 `dt` string)
ROW FORMAT SERDE
 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
 'viewfs://hadoop-meituan/nn23/warehouse/mart_waimai.db/cis_mappoi_in_aor'
TBLPROPERTIES (
 'transient_lastDdlTime'='1437472165');

CREATE  TABLE `mart_waimai.cis_mappoi_in_sp_area`(
 `poi_id` string,
 `wm_poi_id` int)
PARTITIONED BY (
 `dt` string)
ROW FORMAT SERDE
 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
 'viewfs://hadoop-meituan/nn23/warehouse/mart_waimai.db/cis_mappoi_in_sp_area'
TBLPROPERTIES (
 'transient_lastDdlTime'='1437070163');

CREATE TABLE mart_waimai.table001 (name STRING, ip STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

CREATE TABLE IF NOT EXISTS mart_waimai.table002 LIKE testdb.table001;

CREATE TABLE mart_waimai.partition_table001 (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

CREATE TABLE IF NOT EXISTS mart_waimai.partition_table002 LIKE testdb.partition_table001;

