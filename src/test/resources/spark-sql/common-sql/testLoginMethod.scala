val test_sql="USE test_login_db";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE TABLE test_login_db.tbl4login (name STRING)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="INSERT INTO test_login_db.tbl4login VALUES ('test login')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM test_login_db.tbl4login";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE test_login_db.tbl4login";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP DATABASE test_login_db CASCADE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE test_login_db";
spark.sql(test_sql).collect().foreach(println);


val test_sql="USE test_login_db_tbl";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO test_login_db_tbl.test_tbl VALUES ('test login2', 20)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM test_login_db_tbl.test_tbl";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE test_login_db_tbl.test_tbl";
spark.sql(test_sql).collect().foreach(println);
val test_sql="""CREATE TABLE test_login_db_tbl.test_tbl (
 name STRING
,salary FLOAT ) """;
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
