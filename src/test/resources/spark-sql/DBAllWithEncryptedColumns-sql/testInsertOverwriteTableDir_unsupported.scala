//encrypt_db4data.encrypt_employees=encrypt_name,encrypt_salary
//encrypt_db4data.encrypt_tgt_employees=encrypt_name,encrypt_salary
//CREATE DATABASE encrypt_db4data;
//DROP DATABASE encrypt_db4data;

val test_sql="USE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE encrypt_db4data.encrypt_employees (
 encrypt_name STRING
,encrypt_salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);


val test_sql="""CREATE TABLE encrypt_db4data.encrypt_tgt_employees (
 encrypt_name STRING
,encrypt_salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE""";
spark.sql(test_sql).collect().foreach(println);


val test_sql="SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data";
spark.sql(test_sql).collect().foreach(println);
val test_sql="""LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE encrypt_db4data.encrypt_employees PARTITION (country = 'US', state = 'CA')""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE encrypt_db4data.encrypt_tgt_employees ADD PARTITION (country = 'US', state = 'OR')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE encrypt_db4data.encrypt_tgt_employees ADD PARTITION (country = 'US', state = 'IL')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE encrypt_db4data.encrypt_tgt_employees ADD PARTITION (country = 'US', state = 'CA')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.exec.dynamic.partition.mode=nonstrict";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.exec.dynamic.partition=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""FROM encrypt_db4data.encrypt_employees se
INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country, state)
SELECT * """;
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_db4data.encrypt_tgt_employees";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'CA')
SELECT encrypt_name, encrypt_salary, subordinates, deductions, address FROM encrypt_db4data.encrypt_employees se WHERE se.country = 'US' AND se.state = 'CA'""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM encrypt_db4data.encrypt_tgt_employees";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT COUNT(*) FROM encrypt_db4data.encrypt_tgt_employees";
spark.sql(test_sql).collect().foreach(println);

val test_sql="TRUNCATE TABLE encrypt_db4data.encrypt_tgt_employees";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.exec.dynamic.partition=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.vectorized.execution.enabled = true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.vectorized.execution.reduce.enabled = true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state) SELECT se.encrypt_name, se.encrypt_salary, se.subordinates, se.deductions, se.address, se.state FROM encrypt_db4data.encrypt_employees se WHERE se.country = 'US'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_db4data.encrypt_employees";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM encrypt_db4data.encrypt_employees se WHERE se.country = 'US' and se.state = 'CA'""";
spark.sql(test_sql).collect().foreach(println);

!ls -l /tmp/ca_employees;
!ls -rm -r /tmp/ca_employees;

val test_sql="""FROM (
SELECT emp.encrypt_name, emp.encrypt_salary FROM encrypt_db4data.encrypt_employees emp WHERE emp.encrypt_salary < 6000
UNION ALL
SELECT emp.encrypt_name, emp.encrypt_salary FROM encrypt_db4data.encrypt_employees emp WHERE emp.encrypt_salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*""";
spark.sql(test_sql).collect().foreach(println);

dfs -cat /tmp/union.out/*;
dfs -rm -r /tmp/union.out ;

val test_sql="DROP TABLE encrypt_db4data.encrypt_tgt_employees";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE encrypt_db4data.encrypt_employees";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
