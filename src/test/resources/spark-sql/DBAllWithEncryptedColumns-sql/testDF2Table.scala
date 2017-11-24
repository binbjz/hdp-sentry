/*
* encrypt_spark_testdb
* spark_case_employee  name
* spark_case_employee_partition age
* spark_query_employee age
* spark_query_employee_partition name
* spark_insert_employee name
*
* */

val sqlContext = new org.apache.spark.sql.SQLContext(sc)
import sqlContext.implicits._
import org.apache.spark.sql.SaveMode


/* case to DF saveAsTable and insertInto table */
case class Employee(name: String, age: Int, province: String)
val employee = sc.parallelize(Employee("zhangsan", 31, "beijing")::Employee("wangwu" , 28, "hubei")::Employee("lisi", 44, "tianjin")::Employee("liping", 23, "guangdong")::Nil).toDF()
employee.write.mode(SaveMode.Overwrite).saveAsTable("encrypt_spark_testdb.spark_case_employee")
employee.write.insertInto("encrypt_spark_testdb.spark_case_employee")

val test_sql="SELECT * FROM encrypt_spark_testdb.spark_case_employee ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);
val test_sql="TRUNCATE TABLE encrypt_spark_testdb.spark_case_employee";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_spark_testdb.spark_case_employee ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);

/* case to DF with partition saveAsTable and insertInto table */
employee.write.mode(SaveMode.Overwrite).partitionBy("province").saveAsTable("encrypt_spark_testdb.spark_case_employee_partition")
employee.write.insertInto("encrypt_spark_testdb.spark_case_employee_partition")
employee.write.mode(SaveMode.Append).partitionBy("province").bucketBy(42, "name").sortBy("age").saveAsTable("encrypt_spark_testdb.spark_case_employee_partition");

val test_sql="SELECT * FROM encrypt_spark_testdb.spark_case_employee_partition ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);
val test_sql="TRUNCATE TABLE encrypt_spark_testdb.spark_case_employee_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_spark_testdb.spark_case_employee_partition ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);


/* temp table saveAsTable and insertInto table */
employee.registerTempTable("employee")
val query = sqlContext.sql("select name, age from (select * from employee where province = 'beijing') a where a.age >= 20 and a.age < 40")
query.write.mode(SaveMode.Overwrite).saveAsTable("encrypt_spark_testdb.spark_query_employee")
query.write.insertInto("encrypt_spark_testdb.spark_query_employee")

val test_sql="SELECT * FROM encrypt_spark_testdb.spark_query_employee ORDER BY name, age";
spark.sql(test_sql).collect().foreach(println);


/* temp table with partition saveAsTable and insertInto table */
query.write.mode(SaveMode.Overwrite).partitionBy("age").saveAsTable("encrypt_spark_testdb.spark_query_employee_partition")
query.write.insertInto("encrypt_spark_testdb.spark_query_employee_partition")

val test_sql="SELECT * FROM encrypt_spark_testdb.spark_query_employee_partition ORDER BY name, age";
spark.sql(test_sql).collect().foreach(println);


/* insert into table from temp table */
val test_sql ="CREATE TABLE encrypt_spark_testdb.spark_insert_employee (name STRING, age INT, province STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'";
spark.sql(test_sql).collect().foreach(println);

val query = sqlContext.sql("insert into encrypt_spark_testdb.spark_insert_employee select name, age, province from (select * from employee where province = 'beijing') a where a.age >= 20 and a.age < 40")

val test_sql="SELECT * FROM encrypt_spark_testdb.spark_insert_employee ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);
val test_sql="TRUNCATE TABLE encrypt_spark_testdb.spark_insert_employee";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM encrypt_spark_testdb.spark_insert_employee ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
