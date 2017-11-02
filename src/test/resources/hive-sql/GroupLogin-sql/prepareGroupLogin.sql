-- CREATE DATABASE -----------------------------------
CREATE DATABASE ba_ups;
CREATE DATABASE dim;
CREATE DATABASE dw;
CREATE DATABASE mart_waimai;
CREATE DATABASE mart_waimai_crm;
CREATE DATABASE mart_wmorg;
CREATE DATABASE origin_waimai;
CREATE DATABASE origindb;
CREATE DATABASE origindb_delta;
CREATE DATABASE origin_dianping;

-- DATABASE : mart_wmorg -----------------------------------
CREATE  TABLE mart_wmorg.employ_encrypted (
 `uid` bigint COMMENT '',
 `mis_id` string COMMENT '',
 `name` string COMMENT '',
 `email` string COMMENT '',
 `mobile` string COMMENT '加密的号码',
 `pos_id` bigint COMMENT '',
 `wm_pos_name` string COMMENT '(DM / CM / BDM / BD)',
 `pos_name` string COMMENT '岗位名',
 `city_id` bigint COMMENT '行政城市ID',
 `org_id` bigint COMMENT ' 所在的组织ID',
 `wm_org_city_id` bigint COMMENT '外卖城市ID (总部员工设为0)',
 `leader_uid` bigint COMMENT '直接汇报人UID',
 `ctime` bigint COMMENT '',
 `utime` bigint COMMENT '',
 `valid` bigint COMMENT '是否有效，0无效，1有效',
 `role` bigint COMMENT '七个角色取其一，1:蜂窝负责人,2:联络点负责人,3:外卖城市负责人,4:区域负责人,5:总部, 0:其他(无任何权限外卖BD)，-1:无任何权限的非外卖部门的BD；表示权限所依赖的角色，如果已有角色，大角色覆盖小角色',
 `res_ids` string COMMENT '负责资源ID的集合，对应着上面的角色，比如1为蜂窝ID的集合，2为联络点ID的集合；0和5为空',
 `hq_types` string COMMENT '总部类型，0=非总部，1=总部',
 `_update_timestamp` string COMMENT '更新时间')
COMMENT 'M端雇员信息'
ROW FORMAT SERDE
 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
STORED AS INPUTFORMAT
 'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
 'viewfs://hadoop-meituan-test/user/hive/warehouse/mart_wmorg.db/employ_encrypted'
TBLPROPERTIES (
 'numFiles'='1',
 'COLUMN_STATS_ACCURATE'='false',
 'transient_lastDdlTime'='1508690208',
 'numRows'='-1',
 'totalSize'='14713840',
 'rawDataSize'='-1');

-- DATABASE : origindb -----------------------------------
CREATE  TABLE origindb.gis__admin_division (
 `id` bigint COMMENT '自增主键',
 `chinese_name` string COMMENT '中文简称',
 `chinese_full_name` string COMMENT '原语种简称',
 `original_name` string COMMENT '原语种简称',
 `original_full_name` string COMMENT '原语种全称',
 `english_name` string COMMENT '英语名称',
 `english_full_name` string COMMENT '英语全称',
 `language_code` string COMMENT '原语种编码',
 `ad_code` string COMMENT '行政区编码',
 `id_path` string COMMENT '',
 `level` bigint COMMENT '层级（非空）',
 `parent_id` bigint COMMENT '上级行政区ID (根节点的该字段为0)',
 `is_leaf` int COMMENT '是否是叶子节点（0：否，1：是 ）',
 `status` int COMMENT '是否可用 0-已删除 1-可用 ',
 `create_time` string COMMENT '创建时间',
 `creator` bigint COMMENT '创建人id',
 `update_time` string COMMENT '更新时间',
 `updater` bigint COMMENT '更新人id',
 `source` bigint COMMENT '数据来源 0-工作台新建 1-OSM导入',
 `data_type` int COMMENT '数据类型 0-正式数据 1-测试数据（如冥王星）',
 `area_code` string COMMENT '电话区号',
 `chinese_name_pinyin` string COMMENT '中文名称拼音',
 `chinese_name_pinyin_abbr` string COMMENT '中文拼音缩写',
 `chinese_full_name_pinyin` string COMMENT '中文全称拼音',
 `chinese_full_name_pinyin_abbr` string COMMENT '中文全称拼音缩写',
 `_update_timestamp` string COMMENT '更新时间')
COMMENT '行政区信息表'
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
 'viewfs://hadoop-meituan-test/user/hive/warehouse/origindb.db/gis__admin_division'
TBLPROPERTIES (
 'numFiles'='1',
 'COLUMN_STATS_ACCURATE'='false',
 'transient_lastDdlTime'='1508257734',
 'numRows'='-1',
 'totalSize'='841911',
 'rawDataSize'='-1');

 CREATE  TABLE origindb.waimai_order_shard__wm (
 `id` bigint COMMENT 'ID',
 `wm_order_id_hash` string COMMENT 'orderid的hash值',
 `wm_order_id_view` bigint COMMENT '订单的展示id',
 `wm_poi_order_dayseq` bigint COMMENT '门店当天订单序号',
 `wm_poi_id` bigint COMMENT '外卖门店主键id',
 `poi_id` bigint COMMENT '门店id',
 `city_id` bigint COMMENT '城市id',
 `shipping_fee` double COMMENT '配送费',
 `source_order_code` string COMMENT '配送商订单CODE',
 `order_time` bigint COMMENT '下单时间',
 `estimate_arrival_time` bigint COMMENT '预计到达时间',
 `user_id` bigint COMMENT '用户id',
 `recipient_name` string COMMENT '收件人姓名',
 `recipient_phone` string COMMENT '收件人电话',
 `recipient_address` string COMMENT '收件人地址',
 `total` double COMMENT '总价',
 `caution` string COMMENT '忌口',
 `remark` string COMMENT '备注',
 `ctime` bigint COMMENT '创建时间',
 `utime` bigint COMMENT '更新时间',
 `cur_version` bigint COMMENT '订单当前版本号',
 `shipper_phone` string COMMENT '送餐员电话',
 `status` bigint COMMENT '订单状态 1.订单提交 2.已推单 3.正在下单 4.订单已确认 5.正在分配 6.配送中 7.配送完成 8.订单已完成 9.订单已取消',
 `valid` bigint COMMENT '有效性 0. 删除 1.有效',
 `poi_name` string COMMENT '门店名称',
 `call_center` string COMMENT '呼叫中心电话',
 `order_source` bigint COMMENT '订单来源: 1、android下单，2、ios下单，3、web下单，4、I版',
 `discount_id` string COMMENT '享受的优惠id',
 `discount_remark` string COMMENT '享受优惠的备注',
 `original_price` double COMMENT '原价',
 `is_shipping_fee` bigint COMMENT '是否免配送费',
 `free_shipping_fee` double COMMENT '免掉的配送金额',
 `donation` string COMMENT '赠品的描述',
 `discount_fee` double COMMENT '优惠的金额',
 `is_donation` bigint COMMENT '是否有赠品 0 没有 1 有',
 `is_discount_fee` bigint COMMENT '是否有折扣 0 没有 1 有',
 `deal_uid` bigint COMMENT '订单处理人uid',
 `deal_uname` string COMMENT '订单处理人名称',
 `deal_time` bigint COMMENT '订单处理时间',
 `deal_utype` bigint COMMENT '订单处理类型 0呼叫中心 1第三方平台 2商家自助',
 `distribute_type` bigint COMMENT '订单分发类型 1:呼叫中心,2:商家短信,3:商家PC,4:商家APP 5:第三方生活半径 6:第三方趣活 7:open平台 8:商家无线打印机',
 `distribute_warn` string COMMENT '订单分发告警，形如：0,1,2,3 或 1,2,3 等 0:(客服已审核),1:(非白名单用户),2:(可疑用户),3:(大金额订单)',
 `is_comment` bigint COMMENT '0未评论1已评论',
 `push_token` string COMMENT '订单状态消息推送token',
 `longitude` bigint COMMENT '下单位置',
 `latitude` bigint COMMENT '下单位置',
 `courier_name` string COMMENT '配送员姓名',
 `courier_phone` string COMMENT '配送员手机',
 `source_id` bigint COMMENT '订单店铺配送商',
 `fst5coupon_reduce` double COMMENT 'fst5coupon活动首减金额',
 `fst5coupon_coupon` double COMMENT 'fst5coupon活动优惠券金额',
 `fst5coupon_id` bigint COMMENT 'fst5coupon活动ID',
 `suspect_status` bigint COMMENT '可疑订单：0正常 1可疑 2确认刷单',
 `is_pre_order` bigint COMMENT '预定订单 0否 1是',
 `begin_deal_time` bigint COMMENT '预下单时商家预计开始处理订单的时间',
 `is_pass_sms_verify` int COMMENT '该订单是否通过短信验证，0：非通过；1：通过',
 `delivery_btime` bigint COMMENT '配送开始时间',
 `delivery_etime` bigint COMMENT '配送结束时间',
 `pay_status` int COMMENT '支付状态：1：待付款；2、付款中；3、付款成功；4、付款失败；5、申请退款；6、确认退款；7、拒绝退款；8、退款成功',
 `pay_utime` bigint COMMENT '支付状态更新时间',
 `wm_order_pay_type` int COMMENT '订单支付类型：1：货到付款；2：在线支付',
 `wm_anonymous_id` string COMMENT '',
 `uuid` string COMMENT '用户唯一标识',
 `first_order` int COMMENT '首购订单标识',
 `has_been_invoiced` bigint COMMENT '订单是否开了发票：0,没有开发票；1，开了发票',
 `invoice_title` string COMMENT '订单的发票抬头信息',
 `wm_building_id` bigint COMMENT '楼宇id',
 `actual_pay_type` int COMMENT '实际付款方式，1：货到付款 2：在线支付',
 `order_user_type` int COMMENT '订单用户类型，1：普通用户订餐；2：企业用户订餐',
 `logistics_code` string COMMENT '',
 `logistics_status` bigint COMMENT '配送状态,0、默认值；1、已推送给配送方；10、已抢单；20 已取餐；40 已送达；100 已取消',
 `common_ext` string COMMENT '公共扩展字段',
 `binded_phone` string COMMENT '绑定手机号',
 `user_visible` int COMMENT '订单是否对用户可见，0不可见，1可见',
 `day` bigint COMMENT '推单时间对应的日期，格式如：20160224',
 `day_seq` bigint COMMENT '门店对应日期的推单序号。由1开始增长',
 `push_time` bigint COMMENT '推单对应unix时间点',
 `category` bigint COMMENT '订单类标识：默认0-外卖',
 `config_id` bigint COMMENT '订单流程配置id',
 `apply_part_refund` int COMMENT '订单是否有申请部分退款，0-没有申请，1-有申请',
 `_update_timestamp` string COMMENT '更新时间')
COMMENT ''
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
 'viewfs://hadoop-meituan-test/user/hive/warehouse/origindb.db/waimai_order_shard__wm'
TBLPROPERTIES (
 'numFiles'='999',
 'last_modified_by'='hadoop-ods',
 'last_modified_time'='1479454323',
 'transient_lastDdlTime'='1508704660',
 'COLUMN_STATS_ACCURATE'='false',
 'totalSize'='4765984356901',
 'numRows'='-1',
 'rawDataSize'='-1');

-- DATABASE : origin_waimai -----------------------------------
CREATE VIEW origin_waimai.waimai_cos__wm_employ AS SELECT employ_encrypted.uid,
      `employ_encrypted`.`mis_id`,
      `employ_encrypted`.`name`,
      `employ_encrypted`.`email`,
      `employ_encrypted`.`mobile`,
      `employ_encrypted`.`pos_id`,
      `employ_encrypted`.`wm_pos_name`,   -- (DM / CM / BDM / BD)
      `employ_encrypted`.`pos_name`,
      `employ_encrypted`.`city_id`,
      `employ_encrypted`.`org_id`,
      `employ_encrypted`.`wm_org_city_id`,
      `employ_encrypted`.`leader_uid`,
      `employ_encrypted`.`ctime`,
      `employ_encrypted`.`utime`,
      `employ_encrypted`.`valid`,
      `employ_encrypted`.`role`,
      `employ_encrypted`.`res_ids`,
      `employ_encrypted`.`hq_types`,
      `employ_encrypted`.`_update_timestamp`
 FROM `mart_wmorg`.`employ_encrypted`;

CREATE VIEW origin_waimai.waimai_safe_order AS SELECT
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
from `origindb`.`waimai_order_shard__wm`;

-- DATABASE : origindb_delta -----------------------------------
CREATE  TABLE  origindb_delta.waimai_money_exchange__wm_exchange_flow (
 `id` bigint COMMENT '自增主键',
 `parent_id` bigint COMMENT 'wm_exchange表id',
 `partner_id` bigint COMMENT '商家id',
 `partner_type` int COMMENT '商家类型',
 `biz_no` string COMMENT '业务唯一id',
 `biz_type` bigint COMMENT '业务类型',
 `account_type` int COMMENT '账户类型',
 `account_id` bigint COMMENT '账户id',
 `direction` int COMMENT '支付方向（1，正向；-1，逆向）',
 `amount` bigint COMMENT '金额（单位：分）',
 `balance` bigint COMMENT '余额（单位：分）',
 `status` int COMMENT '状态',
 `comment` string COMMENT '备注字段',
 `success_id` bigint COMMENT '账户系统中该流水id',
 `success_time` bigint COMMENT '入账时间',
 `ctime` bigint COMMENT '创建时间',
 `utime` bigint COMMENT '最后修改时间',
 `_update_timestamp` string COMMENT '更新时间')
COMMENT '充扣记录账户流水表'
PARTITIONED BY (
 `dt` string COMMENT '分区字段')
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
 'viewfs://hadoop-meituan-test/user/hive/warehouse/origindb_delta.db/waimai_money_exchange__wm_exchange_flow'
TBLPROPERTIES (
 'transient_lastDdlTime'='1507688631');

-- DATABASE : origin_dianping -----------------------------------
CREATE  TABLE origin_dianping.dpmid_ugcreview_basereview (
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
 'viewfs://hadoop-meituan-test/user/hive/warehouse/origin_dianping.db/dpmid_ugcreview_basereview'
TBLPROPERTIES (
 'numPartitions'='0',
 'numFiles'='32',
 'last_modified_by'='hadoop-data',
 'last_modified_time'='1477481200',
 'transient_lastDdlTime'='1477481200',
 'numRows'='0',
 'totalSize'='72366134400',
 'rawDataSize'='0');

-- DATABASE : ba_ups -----------------------------------
CREATE  TABLE ba_ups.mt_dp_uid_mapping_new (
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
 'viewfs://hadoop-meituan-test/user/hive/warehouse/ba_ups.db/mt_dp_uid_mapping_new'
TBLPROPERTIES (
 'numFiles'='100',
 'last_modified_by'='hadoop-proj-ups',
 'last_modified_time'='1484033177',
 'transient_lastDdlTime'='1508260134',
 'COLUMN_STATS_ACCURATE'='false',
 'totalSize'='15686459084',
 'numRows'='-1',
 'rawDataSize'='-1');

-- DATABASE : dim -----------------------------------
CREATE  TABLE dim.ndm_user (
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
 'viewfs://hadoop-meituan-test/user/hive/warehouse/dim.db/ndm_user'
TBLPROPERTIES (
 'numFiles'='163',
 'last_modified_by'='hadoop-data',
 'last_modified_time'='1477023477',
 'transient_lastDdlTime'='1508259333',
 'COLUMN_STATS_ACCURATE'='false',
 'totalSize'='65292873192',
 'numRows'='-1',
 'rawDataSize'='-1');

INSERT INTO dim.ndm_user VALUES (1001, 1001, 'user_nick_name', 'super_star@mt.com', 17323477766,'2016-06-06', 1, 1, 1, 1, 1);

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;

CREATE TABLE dim.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE dim.collecttest;

-- DATABASE : dw -----------------------------------
CREATE  TABLE dw.dim_employee(
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
 'viewfs://hadoop-meituan-test/user/hive/warehouse/dw.db/dim_employee'
TBLPROPERTIES (
 'numFiles'='4',
 'last_modified_by'='hadoop-data',
 'last_modified_time'='1490945480',
 'transient_lastDdlTime'='1508263656',
 'COLUMN_STATS_ACCURATE'='false',
 'totalSize'='18934694',
 'numRows'='-1',
 'rawDataSize'='-1');

-- DATABASE : mart_waimai -----------------------------------
CREATE TABLE mart_waimai.test_enable_disable1 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE TABLE mart_waimai.test_enable_disable2 (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE  TABLE mart_waimai.dim_ad_cpc_activity_poi (
 ad_activity_key string COMMENT '维度代理键',
 ad_activity_id bigint COMMENT '活动id',
 ad_activity_type int COMMENT '活动类型代码',
 poi_id int COMMENT '活动目标门店')
COMMENT 'CPC广告城市目标商家数'
PARTITIONED BY (
 dt string COMMENT '状态归属时间：etl每日保存上日券状态没有终结的券的信息')
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
 'viewfs://hadoop-meituan-test/user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity_poi'
TBLPROPERTIES (
 'transient_lastDdlTime'='1482166667');

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt=20110122);
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt=20110123);

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt=20210102);
ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt=20210103);

ALTER TABLE mart_waimai.dim_ad_cpc_activity_poi ADD PARTITION (dt=20190104);

CREATE  TABLE mart_waimai.dim_ad_cpc_activity(
 ad_activity_key string COMMENT '维度代理键',
 ad_activity_id bigint COMMENT '活动id',
 ad_activity_name string COMMENT '活动名称',
 ad_activity_type int COMMENT '活动类型代码',
 ad_activity_type_name string COMMENT '活动类型',
 ad_activity_status int COMMENT '活动状态代码 1：上线 2：下线',
 ad_activity_status_name string COMMENT '活动状态',
 direction int COMMENT '商家定向 1：城市 2：具体门店',
 city_id int COMMENT '城市定向ID，direction值如果为1，则该值为城市定向所指定的城市，direction为2时，该值应为0，无业务含义',
 send_status int COMMENT '发券状态：发券状态 1：已发 0：未发 .该字段在充赠活动置空，在运营活动固定为0.仅在补贴活动中有标记性含义',
 start_time bigint COMMENT '活动开始时间',
 end_time bigint COMMENT '活动结束时间',
 start_dt int COMMENT '活动开始日期',
 end_dt int COMMENT '活动结束日期')
COMMENT 'CPC广告券活动维度表'
PARTITIONED BY (
 dt string)
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
 'viewfs://hadoop-meituan-test/user/hive/warehouse/mart_waimai.db/dim_ad_cpc_activity'
TBLPROPERTIES (
 'last_modified_by'='hadoop-waimai',
 'last_modified_time'='1484568134',
 'transient_lastDdlTime'='1484568134');

CREATE  TABLE mart_waimai.cis_mappoi_in_aor (
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
 'viewfs://hadoop-meituan-test/user/hive/warehouse/mart_waimai.db/cis_mappoi_in_aor'
TBLPROPERTIES (
 'transient_lastDdlTime'='1437472165');

CREATE TABLE mart_waimai.table001 (name STRING, ip STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

CREATE TABLE IF NOT EXISTS mart_waimai.table002 LIKE mart_waimai.table001;

CREATE TABLE mart_waimai.partition_table001 (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

CREATE TABLE mart_waimai.partition_table002 LIKE mart_waimai.partition_table001;

CREATE TABLE mart_waimai.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';

CREATE TABLE mart_waimai.test_replace_columns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

CREATE TABLE mart_waimai.test_rename (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

CREATE TABLE mart_waimai.test_change (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

CREATE TABLE mart_waimai.test_add_columns (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);

CREATE TABLE mart_waimai.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

CREATE EXTERNAL TABLE IF NOT EXISTS mart_waimai.log_messages_external (hms INT, severity STRING, server STRING, process_id INT, message STRING) PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE mart_waimai.log_messages ADD PARTITION(year=2011, month=1, day=1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/mart_waimai.db/log_messages/2011/01/01';
ALTER TABLE mart_waimai.log_messages_external ADD PARTITION(year=2011, month=1, day=2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/mart_waimai.db/log_messages_external/2011/01/02';

CREATE TABLE mart_waimai.employees_import_export (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

CREATE TABLE mart_waimai.src_employees_import_export (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

ALTER TABLE mart_waimai.src_employees_import_export ADD PARTITION (country='US', state='CA');

ALTER TABLE mart_waimai.employees_import_export ADD PARTITION (country='US', state='CA') ;

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE mart_waimai.src_employees_import_export
PARTITION (country='US', state='CA');

CREATE TABLE mart_waimai.src_employees_insert_overwrite (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

ALTER TABLE mart_waimai.src_employees_insert_overwrite ADD PARTITION (country='US', state='CA');
ALTER TABLE mart_waimai.src_employees_insert_overwrite ADD PARTITION (country='US', state='OR');
ALTER TABLE mart_waimai.src_employees_insert_overwrite ADD PARTITION (country='US', state='IL');

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE mart_waimai.src_employees_insert_overwrite
PARTITION (country='US', state='CA');

CREATE TABLE mart_waimai.employees_insert_overwrite (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

-- DATABASE : mart_waimai_crm -----------------------------------
CREATE  TABLE mart_waimai_crm.topic_dt_check_list__poiaor_aortype_audit (
 aor_id int COMMENT '蜂窝id',
 aor_type int COMMENT '蜂窝类型',
 food_check_num int COMMENT '菜品覆盖考核总商家数',
 food_qualified_num int COMMENT '菜品覆盖合格商家数')
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
 'viewfs://hadoop-meituan-test/user/hive/warehouse/mart_waimai_crm.db/topic_dt_check_list__poiaor_aortype_audit'
TBLPROPERTIES (
 'last_modified_by'='hadoop-waimaiaudit',
 'last_modified_time'='1505294937',
 'transient_lastDdlTime'='1505294944');
