val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

/* testCreateAlterDropTableViewUnderDefaultDB */

val test_sql="DESCRIBE tbl4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW CREATE TABLE tbl4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW CREATE TABLE view4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES LIKE '*4drop*'";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER VIEW tbl4drop SET TBLPROPERTIES ('test_table_properties' = 'qa_setting_this_value')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER VIEW view4drop SET TBLPROPERTIES ('test_view_properties' = 'qa_setting_this_value')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES tbl4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES view4drop";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE TABLE tbl4create (col1 TINYINT, col2 SMALLINT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE EXTERNAL TABLE tbl4create_external (col1 TINYINT, col2 SMALLINT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE tbl4create_no_privilege (col1 TINYINT, col2 SMALLINT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE ctas AS SELECT * FROM testdb.tbl4drop";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE VIEW view4create AS SELECT col1, col2 FROM view4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE VIEW view4create_no_privilege AS SELECT col1, col2 FROM view4drop";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM tbl4drop_no_r";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM view4drop_no_r";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP VIEW view4create";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE tbl4create";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP VIEW view4create_no_privilege";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE tbl4create_no_privilege";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP VIEW view4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE tbl4drop";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE tbl4create_external";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE ctas";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW TABLES LIKE '*drop*'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES LIKE '*create*'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES LIKE '*ctas'";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
