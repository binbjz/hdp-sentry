val sqlContext = new org.apache.spark.sql.SQLContext(sc)
import sqlContext.implicits._


/* case to DF saveAsTable and insertInto table */
case class Employee(name: String, age: Int, province: String)
val employee = sc.parallelize(Employee("zhangsan", 31, "beijing")::Employee("wangwu" , 28, "hubei")::Employee("lisi", 44, "tianjin")::Employee("liping", 23, "guangdong")::Nil).toDF()
employee.write.mode(SaveMode.Overwrite).saveAsTable("mart_waimai.spark_case_employee")
employee.write.insertInto("mart_waimai.spark_case_employee")

val test_sql="SELECT * FROM mart_waimai.spark_case_employee ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);
val test_sql="TRUNCATE TABLE mart_waimai.spark_case_employee";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM mart_waimai.spark_case_employee ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);

/* case to DF with partition saveAsTable and insertInto table */
employee.write.mode(SaveMode.Overwrite).partitionBy("province").saveAsTable("mart_waimai.spark_case_employee_partition")
employee.write.insertInto("mart_waimai.spark_case_employee_partition")

val test_sql="SELECT * FROM mart_waimai.spark_case_employee_partition ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);
val test_sql="TRUNCATE TABLE mart_waimai.spark_case_employee_partition";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM mart_waimai.spark_case_employee_partition ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);


/* temp table saveAsTable and insertInto table */
employee.registerTempTable("employee")
val query = sqlContext.sql("SELECT name, age FROM (SELECT * FROM employee WHERE province = 'beijing') a WHERE a.age >= 20 AND a.age < 40")
query.write.mode(SaveMode.Overwrite).saveAsTable("mart_waimai.spark_query_employee")
query.write.insertInto("mart_waimai.spark_query_employee")

val test_sql="SELECT * FROM mart_waimai.spark_query_employee ORDER BY name, age";
spark.sql(test_sql).collect().foreach(println);


/* temp table with partition saveAsTable and insertInto table */
query.write.mode(SaveMode.Overwrite).partitionBy("age").saveAsTable("mart_waimai.spark_query_employee_partition")
query.write.insertInto("mart_waimai.spark_query_employee_partition")

val test_sql="SELECT * FROM mart_waimai.spark_query_employee_partition ORDER BY name, age";
spark.sql(test_sql).collect().foreach(println);


/* insert into table from temp table */
val query = sqlContext.sql("INSERT INTO mart_waimai.spark_insert_employee SELECT name, age, province FROM (SELECT * FROM employee WHERE province = 'beijing') a WHERE a.age >= 20 AND a.age < 40")

val test_sql="SELECT * FROM mart_waimai.spark_insert_employee ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);
val test_sql="TRUNCATE TABLE mart_waimai.spark_insert_employee";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM mart_waimai.spark_insert_employee ORDER BY name, age, province";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
