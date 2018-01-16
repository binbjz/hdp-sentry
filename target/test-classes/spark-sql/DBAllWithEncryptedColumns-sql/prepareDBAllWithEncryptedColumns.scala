val test_sql = "CREATE DATABASE encrypt_db4alter LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4alter.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE DATABASE encrypt_db4data LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4data.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE DATABASE encrypt_db4drop_cascade LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4drop_cascade.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE DATABASE encrypt_db4msck LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4msck.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE DATABASE encrypt_db4func LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4func.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE DATABASE encrypt_db4props LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4props.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE DATABASE encrypt_db4tbl LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_db4tbl.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql = "CREATE DATABASE encrypt_spark_testdb LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/encrypt_spark_testdb.db'";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
