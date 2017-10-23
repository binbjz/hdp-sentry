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
 'transient_lastDdlTime'='1482992564');
