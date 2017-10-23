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
 'rawDataSize'='-1');
