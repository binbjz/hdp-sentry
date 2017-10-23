CREATE  TABLE `mart_wmorg.employ_encrypted`(
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
 'viewfs://hadoop-meituan/nn11/warehouse/mart_wmorg.db/employ_encrypted'
TBLPROPERTIES (
 'numFiles'='1',
 'COLUMN_STATS_ACCURATE'='false',
 'transient_lastDdlTime'='1508690208',
 'numRows'='-1',
 'totalSize'='14713840',
 'rawDataSize'='-1');
