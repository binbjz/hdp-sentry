DROP TABLE ba_ups.mt_dp_uid_mapping_new;
DROP DATABASE ba_ups CASCADE;

DROP TABLE dim.ndm_user;
DROP TABLE dim.collecttest;
DROP DATABASE dim CASCADE;

DROP TABLE dw.dim_employee;
DROP DATABASE dw CASCADE;

DROP TABLE mart_waimai.cis_mappoi_in_aor;
DROP TABLE mart_waimai.dim_ad_cpc_activity;
DROP TABLE mart_waimai.dim_ad_cpc_activity_poi;
DROP TABLE mart_waimai.partition_table001;
DROP TABLE mart_waimai.partition_table002;
DROP TABLE mart_waimai.table001;
DROP TABLE mart_waimai.table002;

DROP TABLE mart_waimai.collecttest;
DROP TABLE mart_waimai.test_replace_columns;

DROP TABLE mart_waimai.test_rename;

DROP TABLE mart_waimai.test_enable_disable1;
DROP TABLE mart_waimai.test_enable_disable2;

DROP TABLE mart_waimai.test_change;

DROP TABLE mart_waimai.test_add_columns;

DROP TABLE mart_waimai.log_messages;
DROP TABLE mart_waimai.log_messages_external;

DROP TABLE mart_waimai.employees_import_export;
DROP TABLE mart_waimai.src_employees_import_export;

DROP TABLE mart_waimai.src_employees_insert_overwrite;
DROP TABLE mart_waimai.employees_inser

DROP DATABASE mart_waimai CASCADE;

DROP TABLE mart_wmorg.employ_encrypted;
DROP DATABASE mart_wmorg CASCADE;

DROP VIEW origin_waimai.waimai_cos__wm_employ;
DROP VIEW origin_waimai.waimai_safe_order;
DROP DATABASE origin_waimai CASCADE;

DROP TABLE origindb.gis__admin_division;
DROP TABLE origindb.waimai_order_shard__wm;
DROP DATABASE origindb CASCADE;

DROP TABLE origindb_delta.waimai_money_exchange__wm_exchange_flow;
DROP DATABASE origindb_delta CASCADE;

DROP TABLE origin_dianping.dpmid_ugcreview_basereview;
DROP DATABASE origin_dianping CASCADE;

DROP TABLE mart_waimai_crm.topic_dt_check_list__poiaor_aortype_audit;
DROP DATABASE mart_waimai_crm CASCADE;
