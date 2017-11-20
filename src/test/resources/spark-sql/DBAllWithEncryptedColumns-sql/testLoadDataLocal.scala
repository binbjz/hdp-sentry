//encrypt_db4data.collecttest=str
//CREATE DATABASE encrypt_db4data;
//DROP DATABASE encrypt_db4data;

USE encrypt_db4data;
spark.sql(test_sql).collect().foreach(println);

CREATE TABLE encrypt_db4data.collecttest (str STRING, countval INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';
spark.sql(test_sql).collect().foreach(println);

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
spark.sql(test_sql).collect().foreach(println);
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/test_file.txt' INTO TABLE encrypt_db4data.collecttest;
spark.sql(test_sql).collect().foreach(println);

SELECT concat_ws( ',' , collect_set(cast(countval AS STRING))) FROM encrypt_db4data.collecttest;
spark.sql(test_sql).collect().foreach(println);
SELECT countval, concat_ws( ',' , collect_set(cast(str AS STRING))) FROM encrypt_db4data.collecttest GROUP BY countval;
spark.sql(test_sql).collect().foreach(println);
SELECT str, count(*) as val FROM encrypt_db4data.collecttest GROUP BY str;
spark.sql(test_sql).collect().foreach(println);
SELECT countval, count(*) as val FROM encrypt_db4data.collecttest GROUP BY countval;
spark.sql(test_sql).collect().foreach(println);
SELECT count(*) FROM encrypt_db4data.collecttest;
spark.sql(test_sql).collect().foreach(println);

dfs -cat /user/hive/warehouse/encrypt_db4data.db/collecttest/test_file.txt;
dfs -copyToLocal /user/hive/warehouse/encrypt_db4data.db/collecttest/test_file.txt /tmp;
!cat /tmp/test_file.txt;
!rm /tmp/test_file.txt;
DROP TABLE encrypt_db4data.collecttest;
spark.sql(test_sql).collect().foreach(println);


val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
