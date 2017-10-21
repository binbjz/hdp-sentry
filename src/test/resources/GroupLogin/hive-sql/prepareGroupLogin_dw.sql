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
 `ad_activity_type` int COMMENT '活动类型代码
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
 'transient_lastDdlTime'='1482166667')
Time taken: 0.19 seconds, Fetched: 22 row(s)
OK
CREATE  TABLE `mart_waimai.dim_ad_cpc_activity`(
 `ad_activity_key` string COMMENT '维度代理键',
 `ad_activity_id` bigint COMMENT '活动id',
 `ad_activity_name` string COMMENT '活动名称',
 `ad_activity_type` int COMMENT '活动类型代码
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
 'transient_lastDdlTime'='1484568134')


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
 'transient_lastDdlTime'='1437472165')
Time taken: 0.156 seconds, Fetched: 16 row(s)
OK
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
 'transient_lastDdlTime'='1437070163')
















CREATE  TABLE `ba_ups.mt_dp_uid_mapping_new`(
 `mt_uid` bigint COMMENT '美团userid',
 `dp_uid` bigint COMMENT '点评userid',
 `mobile` bigint COMMENT '对应手机号')
COMMENT '通过手机号关联的美团点评uid映射表'
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
 'viewfs://hadoop-meituan/nn07/warehouse/ba_ups.db/mt_dp_uid_mapping_new'
TBLPROPERTIES (
 'numFiles'='100',
 'last_modified_by'='hadoop-proj-ups',
 'last_modified_time'='1484033177',
 'transient_lastDdlTime'='1508260134',
 'COLUMN_STATS_ACCURATE'='false',
 'totalSize'='15686459084',
 'numRows'='-1',
 'rawDataSize'='-1')
Time taken: 0.523 seconds, Fetched: 26 row(s)
hive> show create table dim.ndm_user;
OK
CREATE  TABLE `dim.ndm_user`(
 `userid` int COMMENT '用户ID',
 `cityid` smallint COMMENT '城市ID',
 `username` string COMMENT '用户昵称',
 `email` string COMMENT '验证后的主邮箱',
 `mobile` bigint COMMENT '验证后的主手机号',
 `regdate` string COMMENT '注册日期',
 `isemailverified` tinyint COMMENT '是否认证Email',
 `ismobilesignup` tinyint COMMENT '是否来自手机注册',
 `ismobileverified` tinyint COMMENT '是否认证手机',
 `isappuser` tinyint COMMENT '是否连接过第三方平台',
 `acctattr` int COMMENT '用户账户属性值')
COMMENT '用户维度表'
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
 'viewfs://hadoop-meituan/nn01/warehouse/dim.db/ndm_user'
TBLPROPERTIES (
 'numFiles'='163',
 'last_modified_by'='hadoop-data',
 'last_modified_time'='1477023477',
 'transient_lastDdlTime'='1508259333',
 'COLUMN_STATS_ACCURATE'='false',
 'totalSize'='65292873192',
 'numRows'='-1',
 'rawDataSize'='-1')
Time taken: 0.129 seconds, Fetched: 34 row(s)

CREATE  TABLE `dw.dim_employee`(
 `employee_id` bigint COMMENT '员工第一次入职时给员工分配的ID，离职后再次入职保持不变',
 `employee_name` string COMMENT '员工的中文名',
 `mis_name` string COMMENT '员工的mis账号名',
 `gender` bigint COMMENT '员工性别，0：未知；1：男；2：女',
 `birthday` string COMMENT '员工的生日，格式为yyyy-MM-dd',
 `entry_date` string COMMENT '员工的入职时间，格式为yyyy-MM-dd',
 `left_date` string COMMENT '员工的离职时间，格式为yyyy-MM-dd',
 `position_id` bigint COMMENT '员工的职位id',
 `position_begin_date` string COMMENT '岗位开始时间',
 `position_end_date` string COMMENT '岗位结束时间',
 `job_id` string COMMENT '员工的工号',
 `job_status` bigint COMMENT '员工的在职状态, 0:未知,1:在职,2:离职,3:停薪留职,4:应聘',
 `job_status_name` string COMMENT '工的在职状态名称',
 `is_deleted` bigint COMMENT '记录是否被删除',
 `org_id` bigint COMMENT '员工所在的组织节点id',
 `org_name` string COMMENT '员工所在的组织节点名称',
 `org_leader_id` bigint COMMENT '组织节点的leader的员工id',
 `superior_id` bigint COMMENT '员工直接上级的员工id',
 `dep_id` bigint COMMENT '员工所在部门id',
 `dep_name` string COMMENT '员工所在部门名称',
 `internal_email` string COMMENT '员工的email',
 `mobile_phone_no` string COMMENT '员工的手机号',
 `org_unit_id` bigint COMMENT '员工所在的到店餐饮的管理单元',
 `tenant_id` bigint COMMENT '租户ID(1.新美大员工 2.猫眼员工 2001.天子星 5001.Demo)但',
 `effect_begin_date` string COMMENT '开链时间，如20100101',
 `is_enabled` string COMMENT '是否最新',
 `effect_end_date` string COMMENT '关联时间，如20151231')
COMMENT '员工信息维度表'
ROW FORMAT SERDE
 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT
 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
LOCATION
 'viewfs://hadoop-meituan/nn19/warehouse/dw.db/dim_employee'
TBLPROPERTIES (
 'numFiles'='4',
 'last_modified_by'='hadoop-data',
 'last_modified_time'='1490945480',
 'transient_lastDdlTime'='1508263656',
 'COLUMN_STATS_ACCURATE'='false',
 'totalSize'='18934694',
 'numRows'='-1',
 'rawDataSize'='-1')
Time taken: 0.168 seconds, Fetched: 46 row(s)
hive> show create table origin_dianping.dpmid_ugcreview_basereview;
OK
CREATE  TABLE `origin_dianping.dpmid_ugcreview_basereview`(
 `reviewid` string COMMENT 'from deserializer',
 `userid` string COMMENT 'from deserializer',
 `shopid` bigint COMMENT 'from deserializer',
 `dealid` bigint COMMENT 'from deserializer',
 `biztype` int COMMENT 'from deserializer',
 `bizid` bigint COMMENT 'from deserializer',
 `star` int COMMENT 'from deserializer',
 `reviewbody` string COMMENT 'from deserializer',
 `reviewtags` string COMMENT 'from deserializer',
 `anonymous` int COMMENT 'from deserializer',
 `ip` string COMMENT 'from deserializer',
 `clienttype` int COMMENT 'from deserializer',
 `platform` int COMMENT 'from deserializer',
 `refertype` int COMMENT 'from deserializer',
 `orderid` string COMMENT 'from deserializer',
 `recommendid` string COMMENT 'from deserializer',
 `quality` int COMMENT 'from deserializer',
 `status` int COMMENT 'from deserializer',
 `statuscode` int COMMENT 'from deserializer',
 `addtime` string COMMENT 'from deserializer',
 `modtime` string COMMENT 'from deserializer',
 `updatetime` string COMMENT 'from deserializer',
 `dw_add_ts` string COMMENT 'from deserializer',
 `sourceid` string COMMENT 'from deserializer',
 `mtpoiid` bigint COMMENT 'from deserializer')
ROW FORMAT SERDE
 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
WITH SERDEPROPERTIES (
 'field.delim'='u0005',
 'serialization.format'='u0005')
STORED AS INPUTFORMAT
 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
LOCATION
 'viewfs://hadoop-meituan/nn01/warehouse/origin_dianping.db/dpmid_ugcreview_basereview'
TBLPROPERTIES (
 'numPartitions'='0',
 'numFiles'='32',
 'last_modified_by'='hadoop-data',
 'last_modified_time'='1477481200',
 'transient_lastDdlTime'='1477481200',
 'numRows'='0',
 'totalSize'='72366134400',
 'rawDataSize'='0')
Time taken: 0.145 seconds, Fetched: 46 row(s)
hive> show create table origin_waimai.waimai_cos__wm_employ;
OK
CREATE VIEW `origin_waimai.waimai_cos__wm_employ` AS select `employ_encrypted`.`uid`,
      `employ_encrypted`.`mis_id`,
      `employ_encrypted`.`name`,
      `employ_encrypted`.`email`,
      `employ_encrypted`.`mobile`,   -- ?????
      `employ_encrypted`.`pos_id`,
      `employ_encrypted`.`wm_pos_name`,   -- (DM / CM / BDM / BD)
      `employ_encrypted`.`pos_name`,   -- ???
      `employ_encrypted`.`city_id`,   -- ????ID
      `employ_encrypted`.`org_id`,   --  ?????ID
      `employ_encrypted`.`wm_org_city_id`,   -- ????ID (??????0)
      `employ_encrypted`.`leader_uid`,   -- ?????UID
      `employ_encrypted`.`ctime`,
      `employ_encrypted`.`utime`,
      `employ_encrypted`.`valid`,   -- ?????0???1??
      `employ_encrypted`.`role`,   -- ????????1:?????,2:??????,3:???????,4:?????,5:??, 0:??(???????BD)?-1:????????????BD???????????????????????????
      `employ_encrypted`.`res_ids`,   -- ????ID???????????????1???ID????2????ID????0?5??
      `employ_encrypted`.`hq_types`,   -- ?????0=????1=??
      `employ_encrypted`.`_update_timestamp`   -- ????
 from `mart_wmorg`.`employ_encrypted`
Time taken: 0.144 seconds, Fetched: 20 row(s)
hive> show create table origin_waimai.waimai_safe_order;
OK
CREATE VIEW `origin_waimai.waimai_safe_order` AS select

   `waimai_order_shard__wm`.`wm_order_id_hash`,
   `waimai_order_shard__wm`.`wm_order_id_view`,
   `waimai_order_shard__wm`.`wm_poi_order_dayseq`,
   `waimai_order_shard__wm`.`wm_poi_id`,
   `waimai_order_shard__wm`.`poi_id`,
   `waimai_order_shard__wm`.`city_id`,
   `waimai_order_shard__wm`.`shipping_fee`,
   `waimai_order_shard__wm`.`source_order_code`,
   `waimai_order_shard__wm`.`order_time`,
   `waimai_order_shard__wm`.`estimate_arrival_time`,
   `waimai_order_shard__wm`.`user_id`,
   '' as `recipient_name`,
   '' as `recipient_phone`,
   '' as `recipient_address`,
   `waimai_order_shard__wm`.`total`,
   `waimai_order_shard__wm`.`caution`,
   `waimai_order_shard__wm`.`remark`,
   `waimai_order_shard__wm`.`ctime`,
   `waimai_order_shard__wm`.`utime`,
   `waimai_order_shard__wm`.`cur_version`,
   `waimai_order_shard__wm`.`shipper_phone`,
   `waimai_order_shard__wm`.`status`,
   `waimai_order_shard__wm`.`valid`,
   `waimai_order_shard__wm`.`poi_name`,
   `waimai_order_shard__wm`.`call_center`,
   `waimai_order_shard__wm`.`order_source`,
   `waimai_order_shard__wm`.`discount_id`,
   `waimai_order_shard__wm`.`discount_remark`,
   `waimai_order_shard__wm`.`original_price`,
   `waimai_order_shard__wm`.`is_shipping_fee`,
   `waimai_order_shard__wm`.`free_shipping_fee`,
   `waimai_order_shard__wm`.`donation`,
   `waimai_order_shard__wm`.`discount_fee`,
   `waimai_order_shard__wm`.`is_donation`,
   `waimai_order_shard__wm`.`is_discount_fee`,
   `waimai_order_shard__wm`.`deal_uid`,
   `waimai_order_shard__wm`.`deal_uname`,
   `waimai_order_shard__wm`.`deal_time`,
   `waimai_order_shard__wm`.`deal_utype`,
   `waimai_order_shard__wm`.`distribute_type`,
   `waimai_order_shard__wm`.`distribute_warn`,
   `waimai_order_shard__wm`.`is_comment`,
   `waimai_order_shard__wm`.`push_token`,
   `waimai_order_shard__wm`.`longitude`,
   `waimai_order_shard__wm`.`latitude`,
   `waimai_order_shard__wm`.`courier_name`,
   `waimai_order_shard__wm`.`courier_phone`,
   `waimai_order_shard__wm`.`source_id`,
   `waimai_order_shard__wm`.`fst5coupon_reduce`,
   `waimai_order_shard__wm`.`fst5coupon_coupon`,
   `waimai_order_shard__wm`.`fst5coupon_id`,
   `waimai_order_shard__wm`.`suspect_status`,
   `waimai_order_shard__wm`.`is_pre_order`,
   `waimai_order_shard__wm`.`begin_deal_time`,
   `waimai_order_shard__wm`.`is_pass_sms_verify`,
   `waimai_order_shard__wm`.`delivery_btime`,
   `waimai_order_shard__wm`.`delivery_etime`,
   `waimai_order_shard__wm`.`pay_status`,
   `waimai_order_shard__wm`.`pay_utime`,
   `waimai_order_shard__wm`.`wm_order_pay_type`,
   `waimai_order_shard__wm`.`wm_anonymous_id`,
   `waimai_order_shard__wm`.`uuid`,
   `waimai_order_shard__wm`.`first_order`,
   `waimai_order_shard__wm`.`has_been_invoiced`,
   `waimai_order_shard__wm`.`invoice_title`,
   `waimai_order_shard__wm`.`wm_building_id`,
   `waimai_order_shard__wm`.`actual_pay_type`,
   `waimai_order_shard__wm`.`order_user_type`,
   `waimai_order_shard__wm`.`logistics_code`,
   `waimai_order_shard__wm`.`logistics_status`,
   regexp_replace(`waimai_order_shard__wm`.`common_ext`,'(?<="address":\\{"f1").*(?="f3")',':"","f2":"",') as `common_ext`,
   '' as `binded_phone`,
   `waimai_order_shard__wm`.`user_visible`,
   `waimai_order_shard__wm`.`day`,
   `waimai_order_shard__wm`.`day_seq`,
   `waimai_order_shard__wm`.`push_time`,
   `waimai_order_shard__wm`.`category`,
   `waimai_order_shard__wm`.`config_id`,
   `waimai_order_shard__wm`.`apply_part_refund`
from `origindb`.`waimai_order_shard__wm`
Time taken: 0.152 seconds, Fetched: 82 row(s)