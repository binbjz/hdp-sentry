//encrypt_db4data.test_clusteredby=encrypt_salary,encrypt_address
//CREATE DATABASE encrypt_db4data;
//DROP DATABASE encrypt_db4data;

val test_sql="USE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE encrypt_db4data.test_clusteredby (
 name STRING
,encrypt_salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,encrypt_address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data";
spark.sql(test_sql).collect().foreach(println);
val test_sql="""LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv' INTO TABLE encrypt_db4data.test_clusteredby PARTITION (country = 'US', state = 'CA')""";
spark.sql(test_sql).collect().foreach(println);

//dfs -cat /user/hive/warehouse/encrypt_db4data.db/test_clusteredby/country=US/state=CA/california-employees.csv;

val test_sql="SHOW PARTITIONS encrypt_db4data.test_clusteredby";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4data.test_clusteredby TOUCH";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE encrypt_db4data.test_clusteredby TOUCH PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE encrypt_db4data.test_clusteredby CLUSTERED BY (name, encrypt_address) SORTED BY (encrypt_salary) INTO 48 BUCKETS";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE encrypt_db4data.test_clusteredby";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
