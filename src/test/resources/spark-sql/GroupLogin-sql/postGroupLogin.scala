val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE ba_ups.mt_dp_uid_mapping_new";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE ba_ups CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE dim.ndm_user";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE dim.collecttest";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE dim CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE dw.dim_employee";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE dw CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai.cis_mappoi_in_aor";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.dim_ad_cpc_activity_poi";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.partition_table001";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.partition_table002";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.table001";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.table002";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai.collecttest";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.test_replace_columns";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai.test_rename";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai.test_enable_disable1";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.test_enable_disable2";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai.test_change";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai.test_add_columns";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai.log_messages";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.log_messages_external";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai.employees_import_export";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.src_employees_import_export";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai.src_employees_insert_overwrite";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.employees_insert_overwrite";
spark.sql(test_sql).collect().foreach(println);

val test_sql = "DROP TABLE mart_waimai.src_test_insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai.tbl4udf";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai.tbl4sample";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai.spark_case_employee";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.spark_case_employee_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.spark_query_employee";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.spark_query_employee_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.spark_insert_employee";
spark.sql(test_sql).collect().foreach(println);

var test_sql="DROP TABLE mart_waimai.spark_df_parquet";
spark.sql(test_sql).collect().foreach(println);
var test_sql="DROP TABLE mart_waimai.spark_df_json";
spark.sql(test_sql).collect().foreach(println);
var test_sql="DROP TABLE mart_waimai.spark_df_orc";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai.spark_merge_schema_true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.spark_merge_schema_false";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP DATABASE mart_waimai CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_wmorg.employ_encrypted";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE mart_wmorg CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP VIEW origin_waimai.waimai_cos__wm_employ";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP VIEW origin_waimai.waimai_safe_order";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE origin_waimai CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE origindb.gis__admin_division";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE origindb.waimai_order_shard__wm";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE origindb CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE origindb_delta.waimai_money_exchange__wm_exchange_flow";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE origindb_delta CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE origin_dianping.dpmid_ugcreview_basereview";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE origin_dianping CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE mart_waimai_crm.topic_dt_check_list__poiaor_aortype_audit";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE mart_waimai_crm CASCADE";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
