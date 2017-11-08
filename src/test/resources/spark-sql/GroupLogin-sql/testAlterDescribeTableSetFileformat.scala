USE mart_waimai;

DESCRIBE EXTENDED mart_waimai.log_messages PARTITION (year = 2011, month = 1, day = 1);
ALTER TABLE mart_waimai.log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
DESCRIBE EXTENDED mart_waimai.log_messages PARTITION (year = 2011, month = 1, day = 1);

DESCRIBE EXTENDED mart_waimai.log_messages_external;
ALTER TABLE mart_waimai.log_messages_external SET FILEFORMAT SEQUENCEFILE;
DESCRIBE EXTENDED mart_waimai.log_messages_external;

dfs -rm -r /user/hive/warehouse/mart_waimai.db/log_messages_external;

val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

System.exit(0)
