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