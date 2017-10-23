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
 'viewfs://hadoop-meituan/nn01/warehouse/origindb.db/gis__admin_division'
TBLPROPERTIES (
 'numFiles'='1',
 'COLUMN_STATS_ACCURATE'='false',
 'transient_lastDdlTime'='1508257734',
 'numRows'='-1',
 'totalSize'='841911',
 'rawDataSize'='-1');

SELECT DISTINCT dp.*
FROM SENTRY_GROUP g
INNER JOIN SENTRY_ROLE_GROUP_MAP rg ON g.GROUP_ID=rg.GROUP_ID
INNER JOIN SENTRY_ROLE r ON r.ROLE_ID=rg.ROLE_ID
INNER JOIN SENTRY_ROLE_DB_PRIVILEGE_MAP rdp ON r.ROLE_ID=rdp.ROLE_ID
INNER JOIN SENTRY_DB_PRIVILEGE dp ON dp.DB_PRIVILEGE_ID=rdp.DB_PRIVILEGE_ID
INNER JOIN SENTRY_ROLE_USER_MAP ru ON r.ROLE_ID=ru.ROLE_ID
INNER JOIN SENTRY_USER u ON u.USER_ID=ru.USER_ID
WHERE r.ROLE_NAME='dep-waimai'
and TABLE_NAME='waimai_order_shard__wm'
and
AND u.USER_NAME='litao19'SELECT DISTINCT dp.*
FROM SENTRY_GROUP g
INNER JOIN SENTRY_ROLE_GROUP_MAP rg ON g.GROUP_ID=rg.GROUP_ID
INNER JOIN SENTRY_ROLE r ON r.ROLE_ID=rg.ROLE_ID
INNER JOIN SENTRY_ROLE_DB_PRIVILEGE_MAP rdp ON r.ROLE_ID=rdp.ROLE_ID
INNER JOIN SENTRY_DB_PRIVILEGE dp ON dp.DB_PRIVILEGE_ID=rdp.DB_PRIVILEGE_ID
INNER JOIN SENTRY_ROLE_USER_MAP ru ON r.ROLE_ID=ru.ROLE_ID
INNER JOIN SENTRY_USER u ON u.USER_ID=ru.USER_ID
WHERE r.ROLE_NAME='dep-waimai'
and TABLE_NAME='waimai_order_shard__wm'
AND u.USER_NAME='litao19'
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
 'viewfs://hadoop-meituan/nn01/warehouse/origindb.db/waimai_order_shard__wm'
TBLPROPERTIES (
 'numFiles'='999',
 'last_modified_by'='hadoop-ods',
 'last_modified_time'='1479454323',
 'transient_lastDdlTime'='1508704660',
 'COLUMN_STATS_ACCURATE'='false',
 'totalSize'='4765984356901',
 'numRows'='-1',
 'rawDataSize'='-1');
