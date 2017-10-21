CREATE  TABLE `mart_waimai_crm.topic_dt_check_list__poiaor_aortype_audit`(
 `aor_id` int COMMENT '蜂窝id',
 `aor_type` int COMMENT '蜂窝类型',
 `food_check_num` int COMMENT '菜品覆盖考核总商家数',
 `food_qualified_num` int COMMENT '菜品覆盖合格商家数')
COMMENT '蜂窝图片覆盖率日考核列表——用于绩效图片覆盖率考核'
PARTITIONED BY (
 `dt` string)
ROW FORMAT SERDE
 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
 'field.delim'='\t',
 'serialization.format'='\t')
STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
 'viewfs://hadoop-meituan/nn01/warehouse/mart_waimai_crm.db/topic_dt_check_list__poiaor_aortype_audit'
TBLPROPERTIES (
 'last_modified_by'='hadoop-waimaiaudit',
 'last_modified_time'='1505294937',
 'transient_lastDdlTime'='1505294944');


CREATE  TABLE `mart_waimai_crm.topic_dt_aor__b_order_amount_audit`(
 `aor_id` int COMMENT '外卖商家id',
 `spd_orig_amt` double COMMENT '专送原价交易额(special original amount)',
 `nspd_orig_amt` double COMMENT '非专送原价交易额(non-special original amount)',
 `orig_amt` double COMMENT '原价交易额(original amount)',
 `spd_actl_amt` double COMMENT '专送实付交易额(special actual amount)',
 `nspd_actl_amt` double COMMENT '非专送实付交易额(non-special actual amount)',
 `actl_amt` double COMMENT '实付交易额(actual amount)',
 `spd_ord_num` int COMMENT '专送订单量(special order number)',
 `nspd_ord_num` int COMMENT '非专送订单量(non-special order number)',
 `ord_num` int COMMENT '订单量(order number)')
COMMENT '商家月维度交易额模块'
PARTITIONED BY (
 `dt` string)
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
 'viewfs://hadoop-meituan/nn01/warehouse/mart_waimai_crm.db/topic_dt_aor__b_order_amount_audit'
TBLPROPERTIES (
 'last_modified_by'='hadoop-waimaiuser',
 'last_modified_time'='1482992564',
 'transient_lastDdlTime'='1482992564')











hive> show create table ba_ups.mt_dp_uid_mapping_new;
OK
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
hive> show create table dw.dim_employee;
OK
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