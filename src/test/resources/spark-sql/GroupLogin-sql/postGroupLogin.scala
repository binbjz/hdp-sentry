DROP TABLE ba_ups.mt_dp_uid_mapping_new;
val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);
DROP DATABASE ba_ups CASCADE;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE dim.ndm_user;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE dim.collecttest;
spark.sql(test_sql).collect().foreach(println);
DROP DATABASE dim CASCADE;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE dw.dim_employee;
spark.sql(test_sql).collect().foreach(println);
DROP DATABASE dw CASCADE;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE mart_waimai.cis_mappoi_in_aor;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE mart_waimai.dim_ad_cpc_activity;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE mart_waimai.dim_ad_cpc_activity_poi;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE mart_waimai.partition_table001;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE mart_waimai.partition_table002;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE mart_waimai.table001;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE mart_waimai.table002;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE mart_waimai.collecttest;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE mart_waimai.test_replace_columns;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE mart_waimai.test_rename;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE mart_waimai.test_enable_disable1;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE mart_waimai.test_enable_disable2;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE mart_waimai.test_change;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE mart_waimai.test_add_columns;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE mart_waimai.log_messages;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE mart_waimai.log_messages_external;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE mart_waimai.employees_import_export;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE mart_waimai.src_employees_import_export;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE mart_waimai.src_employees_insert_overwrite;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE mart_waimai.employees_insert_overwrite;
spark.sql(test_sql).collect().foreach(println);

DROP DATABASE mart_waimai CASCADE;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE mart_wmorg.employ_encrypted;
spark.sql(test_sql).collect().foreach(println);
DROP DATABASE mart_wmorg CASCADE;
spark.sql(test_sql).collect().foreach(println);

DROP VIEW origin_waimai.waimai_cos__wm_employ;
spark.sql(test_sql).collect().foreach(println);
DROP VIEW origin_waimai.waimai_safe_order;
spark.sql(test_sql).collect().foreach(println);
DROP DATABASE origin_waimai CASCADE;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE origindb.gis__admin_division;
spark.sql(test_sql).collect().foreach(println);
DROP TABLE origindb.waimai_order_shard__wm;
spark.sql(test_sql).collect().foreach(println);
DROP DATABASE origindb CASCADE;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE origindb_delta.waimai_money_exchange__wm_exchange_flow;
spark.sql(test_sql).collect().foreach(println);
DROP DATABASE origindb_delta CASCADE;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE origin_dianping.dpmid_ugcreview_basereview;
spark.sql(test_sql).collect().foreach(println);
DROP DATABASE origin_dianping CASCADE;
spark.sql(test_sql).collect().foreach(println);

DROP TABLE mart_waimai_crm.topic_dt_check_list__poiaor_aortype_audit;
spark.sql(test_sql).collect().foreach(println);
DROP DATABASE mart_waimai_crm CASCADE;
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
