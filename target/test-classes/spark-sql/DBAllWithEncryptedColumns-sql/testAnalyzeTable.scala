//encrypt_db4data.encrypt_test_analyze=encrypt_salary
//CREATE DATABASE encrypt_db4data;
//DROP DATABASE encrypt_db4data;

USE encrypt_db4data;
CREATE TABLE encrypt_db4data.encrypt_test_analyze (
 name STRING
 ,encrypt_salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;
spark.sql(test_sql).collect().foreach(println);

ALTER TABLE encrypt_db4data.encrypt_test_analyze ADD PARTITION (country = 'US', state = 'CA');
spark.sql(test_sql).collect().foreach(println);
ALTER TABLE encrypt_db4data.encrypt_test_analyze ADD PARTITION (country = 'US', state = 'OR');
spark.sql(test_sql).collect().foreach(println);
ALTER TABLE encrypt_db4data.encrypt_test_analyze ADD PARTITION (country = 'US', state = 'IL');
spark.sql(test_sql).collect().foreach(println);

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
spark.sql(test_sql).collect().foreach(println);
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE encrypt_db4data.encrypt_test_analyze
PARTITION (country = 'US', state = 'CA');
spark.sql(test_sql).collect().foreach(println);

SET hive.cli.print.header=true;
spark.sql(test_sql).collect().foreach(println);

ANALYZE TABLE encrypt_db4data.encrypt_test_analyze COMPUTE STATISTICS FOR COLUMNS name, encrypt_salary;
spark.sql(test_sql).collect().foreach(println);
-- 只搜集分区
  ANALYZE TABLE encrypt_db4data.encrypt_test_analyze PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
spark.sql(test_sql).collect().foreach(println);
-- 如果执行,则同时搜集分区间OR/CA/IL
ANALYZE TABLE encrypt_db4data.encrypt_test_analyze PARTITION (country = 'US', state)  COMPUTE STATISTICS;
spark.sql(test_sql).collect().foreach(println);
-- 如果执行 搜集所有分区
ANALYZE TABLE encrypt_db4data.encrypt_test_analyze PARTITION (country, state) COMPUTE STATISTICS;
spark.sql(test_sql).collect().foreach(println);
-- 查看分区的统计信息
  DESCRIBE EXTENDED encrypt_db4data.encrypt_test_analyze;
DESCRIBE EXTENDED encrypt_db4data.encrypt_test_analyze PARTITION (country = 'US', state = 'CA');
spark.sql(test_sql).collect().foreach(println);

dfs -rm /user/hive/warehouse/encrypt_db4data.db/encrypt_test_analyze/country=US/state=CA/california-employees.csv;

DROP TABLE encrypt_db4data.encrypt_test_analyze;
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
