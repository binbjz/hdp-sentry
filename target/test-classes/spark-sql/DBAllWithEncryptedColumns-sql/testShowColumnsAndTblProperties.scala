//encrypt_db4props.employees_props=encrypt_name,encrypt_salary
//CREATE DATABASE encrypt_db4props;
//DROP DATABASE encrypt_db4props;

val test_sql="USE encrypt_db4props";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE IF NOT EXISTS employees_props (
  encrypt_name  STRING COMMENT 'Employee name'
 ,encrypt_salary  FLOAT  COMMENT'Employee salary'
 ,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
 ,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
 ,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
COMMENT 'Description of the table'
PARTITIONED BY (country STRING, state STRING)
LOCATION '/user/hive/warehouse/encrypt_db4props.db/employees_props'
TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties')""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SHOW TBLPROPERTIES encrypt_db4props.employees_props";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN encrypt_db4props.employees_props";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM encrypt_db4props.employees_props";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM encrypt_db4props.employees_props";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT encrypt_name, encrypt_salary, subordinates, deductions, address, country, state FROM encrypt_db4props.employees_props";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE encrypt_db4props.employees_props";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
