val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

/* testCreateAlterDropTableView */

val test_sql="DESCRIBE testdb.tbl4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW CREATE TABLE testdb.tbl4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW CREATE TABLE testdb.view4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES LIKE '*4drop*'";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4drop SET TBLPROPERTIES ('test_table_properties' = 'qa_setting_this_value')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER VIEW testdb.view4drop SET TBLPROPERTIES ('test_view_properties' = 'qa_setting_this_value')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES testdb.tbl4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES testdb.view4drop";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE TABLE testdb.tbl4create (col1 TINYINT, col2 SMALLINT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE EXTERNAL TABLE testdb.tbl4create_external (col1 TINYINT, col2 SMALLINT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE testdb.tbl4create_no_privilege (col1 TINYINT, col2 SMALLINT)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE TABLE testdb.ctas AS SELECT * FROM testdb.tbl4drop";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE VIEW testdb.view4create AS SELECT col1, col2 FROM testdb.view4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE VIEW testdb.view4create_no_privilege AS SELECT col1, col2 FROM testdb.view4drop";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM testdb.tbl4drop_no_r";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.view4drop_no_r";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP VIEW testdb.view4create";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4create";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP VIEW testdb.view4create_no_privilege";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4create_no_privilege";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP VIEW testdb.view4drop";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.tbl4drop";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE testdb.tbl4create_external";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE testdb.ctas";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW TABLES LIKE '*drop*'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES LIKE '*create*'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES LIKE '*ctas'";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
