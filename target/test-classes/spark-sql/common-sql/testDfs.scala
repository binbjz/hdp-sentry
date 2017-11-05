USE default;

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
!cp ${hiveconf:FILEPATH}/california-employees.csv ${hiveconf:FILEPATH}/california-employees.csv_new;
dfs -moveFromLocal ${hiveconf:FILEPATH}/california-employees.csv_new  /tmp;
dfs -count /tmp/california-employees.csv_new;
dfs -cat /tmp/california-employees.csv_new;
dfs -copyToLocal /tmp/california-employees.csv_new /tmp;
dfs -rm /tmp/california-employees.csv_new;
!rm /tmp/california-employees.csv_new;



val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

