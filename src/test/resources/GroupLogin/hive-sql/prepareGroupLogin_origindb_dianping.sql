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
