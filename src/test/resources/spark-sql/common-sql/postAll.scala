val test_sql="DROP DATABASE test_login_db CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE test_login_db_tbl.test_tbl";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE test_login_db_tbl CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE testdb.tbl4rename";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4rename_new";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4replacecolumns";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4analyze";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE testdb.tbl4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.view4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4drop_no_r";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.view4drop_no_r";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE testdb.import_export";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.src_import_export";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE testdb.sessionization_step_one_origins";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.session_test";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE testdb.src_insert_overwrite_tbl";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.insert_overwrite_tb";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_insert_overwrite_dir";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.src_insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.insert_overwrite_tbl_partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE testdb.load_data_local_into_table";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.load_data_local_into_partition";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE testdb.test_msck";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4query";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.employees_props";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE default.tbl4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE default.view4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE default.tbl4drop_no_r";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE default.view4drop_no_r";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE testdb.tbl4addfile";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4jarfile";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4setlocation";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_serde_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_serde";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4addcolumns";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4fileformat";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4fileformat_external";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_enable_disable_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_enable_disable1";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.test_enable_disable2";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE testdb.spark_tbl4udf";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4sample";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE testdb.spark_case_employee";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.spark_case_employee_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.spark_query_employee";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.spark_query_employee_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.spark_insert_employee";
spark.sql(test_sql).collect().foreach(println);

var test_sql="DROP TABLE testdb.spark_df_parquet";
spark.sql(test_sql).collect().foreach(println);
var test_sql="DROP TABLE testdb.spark_df_json";
spark.sql(test_sql).collect().foreach(println);
var test_sql="DROP TABLE testdb.spark_df_orc";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE testdb.spark_merge_schema_true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.spark_merge_schema_false";
spark.sql(test_sql).collect().foreach(println);


val test_sql="DROP TABLE testdb.spark_case_employee2";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.spark_case_employee_partition2";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.spark_query_employee2";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.spark_query_employee_partition2";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP DATABASE testdb CASCADE";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP DATABASE unaccessibledb";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP DATABASE db4create CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE db4create_no_privilege CASCADE";
spark.sql(test_sql).collect().foreach(println);


val test_sql="DROP DATABASE db4drop CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE db4drop_cascade CASCADE";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
