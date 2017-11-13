val test_sql="USE default";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE DATABASE mart_waimai LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/mart_waimai.db' WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE mart_waimai_new LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/mart_waimai_new.db' WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE mart_wmorg LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/mart_wmorg.db' WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE origin_waimai LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/origin_waimai.db' WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="CREATE DATABASE ba_ups LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/ba_ups.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE dim LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/dim.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE dw LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/dw.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE mart_waimai_crm LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/mart_waimai_crm.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE origindb LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/origindb.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE origindb_delta LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/origindb_delta.db'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="CREATE DATABASE origin_dianping LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/origin_dianping.db'";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
