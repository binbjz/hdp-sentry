CREATE  TABLE `origindb.gis__admin_division`(
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

 CREATE  TABLE `origindb.waimai_order_shard__wm`(
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
