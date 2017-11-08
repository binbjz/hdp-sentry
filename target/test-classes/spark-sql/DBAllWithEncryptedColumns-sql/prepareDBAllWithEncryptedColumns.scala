val test_sql="CREATE DATABASE encrypt_db4alter";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE encrypt_db4drop_cascade";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE encrypt_db4msck";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE encrypt_db4func";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE encrypt_db4props";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE encrypt_db4tbl";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
