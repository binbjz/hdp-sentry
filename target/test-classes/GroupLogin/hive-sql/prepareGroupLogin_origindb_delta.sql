CREATE  TABLE `origindb_delta.waimai_money_exchange__wm_exchange_flow`(
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
