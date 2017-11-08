val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE mart_waimai.tbl2create (col1 TINYINT, col2 SMALLINT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE VIEW mart_waimai.view2create_star AS SELECT * FROM origin_waimai.waimai_cos__wm_employ";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE VIEW mart_waimai.view2create_non_encrypt_columns AS SELECT * FROM origin_waimai.waimai_cos__wm_employ";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE VIEW mart_waimai.view2create_encrypt_columns AS SELECT email, mobile FROM origin_waimai.waimai_cos__wm_employ";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE mart_waimai.tbl2create SET TBLPROPERTIES ('qa comments' = 'test add table properties')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER VIEW mart_waimai.view2create_non_encrypt_columns SET TBLPROPERTIES ('qa comments' = 'test add table properties')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW TBLPROPERTIES mart_waimai.tbl2create";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.view2create_non_encrypt_columns";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW TABLES LIKE '*2create*'";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW CREATE TABLE mart_waimai.tbl2create";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW CREATE TABLE mart_waimai.view2create_non_encrypt_columns";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW TABLES";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.tbl2create";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP VIEW mart_waimai.view2create_star";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP VIEW mart_waimai.view2create_non_encrypt_columns";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP VIEW mart_waimai.view2create_encrypt_columns";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
