DROP TABLE ba_ups.mt_dp_uid_mapping_new;
DROP DATABASE ba_ups;

DROP TABLE dim.ndm_user;
DROP TABLE dim.collecttest;
DROP DATABASE dim;

DROP TABLE dw.dim_employee;
DROP DATABASE dw;

DROP TABLE mart_waimai.dim_act_type;
DROP TABLE mart_waimai.dim_ad_cpc_activity_poi;
DROP TABLE mart_waimai.dim_ad_cpc_activity;
DROP TABLE mart_waimai.dim_aor_ord_price_level_his;
DROP TABLE mart_waimai.cis_mappoi_in_aor;
DROP TABLE mart_waimai.cis_mappoi_in_sp_area;

DROP TABLE mart_waimai.table001;
DROP TABLE mart_waimai.table002;

DROP TABLE mart_waimai.partition_table001;
DROP TABLE mart_waimai.partition_table002;

DROP DATABASE mart_waimai;

DROP TABLE mart_wmorg.employ_encrypted;
DROP DATABASE mart_wmorg;

DROP VIEW origin_waimai.waimai_cos__wm_employ;
DROP VIEW origin_waimai.waimai_safe_order;
DROP DATABASE origin_waimai;

DROP TABLE origindb.gis__admin_division;
DROP TABLE origindb.waimai_order_shard__wm;
DROP DATABASE origindb;

DROP TABLE origindb_delta.waimai_money_exchange__wm_exchange_flow;
DROP DATABASE origindb_delta;

DROP TABLE origin_dianping.dpmid_ugcreview_basereview;
DROP DATABASE origin_dianping;

DROP TABLE mart_waimai_crm.topic_dt_check_list__poiaor_aortype_audit;
DROP TABLE mart_waimai_crm.topic_dt_aor__b_order_amount_audit;
DROP DATABASE mart_waimai_crm;
