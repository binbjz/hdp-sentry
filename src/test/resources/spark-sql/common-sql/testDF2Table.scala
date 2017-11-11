val sqlContext = new org.apache.spark.sql.SQLContext(sc)
import sqlContext.implicits._

val test_sql="DROP TABLE IF EXISTS testdb.spark_case_employee";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE IF EXISTS testdb.spark_case_employee_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE IF EXISTS testdb.spark_query_employee";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE IF EXISTS testdb.spark_query_employee_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE IF EXISTS testdb.spark_insert_employee";
spark.sql(test_sql).collect().foreach(println);


/* case to DF saveAsTable and insertInto table */
case class Employee(name: String, age: Int, province: String)
val employee = sc.parallelize(Employee("zhangsan", 31, "beijing")::Employee("wangwu" , 28, "hubei")::Employee("lisi", 44, "tianjin")::Employee("liping", 23, "guangdong")::Nil).toDF()
employee.write.saveAsTable("testdb.spark_case_employee")
employee.write.insertInto("testdb.spark_case_employee")

val test_sql="SELECT * FROM testdb.spark_case_employee ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);
val test_sql="TRUNCATE TABLE testdb.spark_case_employee";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.spark_case_employee ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);

/* case to DF with partition saveAsTable and insertInto table */
employee.write.partitionBy("province").saveAsTable("testdb.spark_case_employee_partition")
employee.write.insertInto("testdb.spark_case_employee_partition")

val test_sql="SELECT * FROM testdb.spark_case_employee_partition ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);
val test_sql="TRUNCATE TABLE testdb.spark_case_employee_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.spark_case_employee_partition ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);


/* temp table saveAsTable and insertInto table */
employee.registerTempTable("employee")
val query = sqlContext.sql("select name, age from (select * from employee where province = 'beijing') a where a.age >= 20 and a.age < 40")
query.write.saveAsTable("testdb.spark_query_employee")
query.write.insertInto("testdb.spark_query_employee")

val test_sql="SELECT * FROM testdb.spark_query_employee ORDER BY name, age";
spark.sql(test_sql).collect().foreach(println);


/* temp table with partition saveAsTable and insertInto table */
query.write.partitionBy("age").saveAsTable("testdb.spark_query_employee_partition")
query.write.insertInto("testdb.spark_query_employee_partition")

val test_sql="SELECT * FROM testdb.spark_query_employee_partition ORDER BY name, age";
spark.sql(test_sql).collect().foreach(println);


/* insert into table from temp table */
val test_sql ="""CREATE TABLE testdb.spark_insert_employee (name STRING, age INT, province STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/spark_insert_employee'""";
spark.sql(test_sql).collect().foreach(println);
val query = sqlContext.sql("insert into testdb.spark_insert_employee select name, age, province from (select * from employee where province = 'beijing') a where a.age >= 20 and a.age < 40")

val test_sql="SELECT * FROM testdb.spark_insert_employee ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);
val test_sql="TRUNCATE TABLE testdb.spark_insert_employee";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM testdb.spark_insert_employee ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
