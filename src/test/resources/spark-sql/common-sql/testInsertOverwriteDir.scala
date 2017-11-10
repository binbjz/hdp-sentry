val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

/* write to HDFS dir */

val test_sql="SET hive.exec.dynamic.partition=true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.vectorized.execution.enabled = true";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SET hive.vectorized.execution.reduce.enabled = true";
spark.sql(test_sql).collect().foreach(println);


var test_sql="SELECT * FROM testdb.test_insert_overwrite_dir se WHERE se.country = 'US' and se.state = 'CA'";
spark.sql(test_sql).write.format("json").save("/tmp/spark_ca_employees_json");
spark.sql(test_sql).write.format("parquet").save("/tmp/spark_ca_employees_parquet");
spark.sql(test_sql).write.format("orc").save("/tmp/spark_ca_employees_orc");

/* testInsertOverwriteDir DOES NOT SUPPORT
var test_sql="""INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM testdb.test_insert_overwrite_dir se WHERE se.country = 'US' and se.state = 'CA'""";
spark.sql(test_sql).collect().foreach(println);
!ls -l /tmp/ca_employees;
!rm -r /tmp/ca_employees;*/

FROM (
SELECT emp.name, emp.salary FROM testdb.test_insert_overwrite_dir emp WHERE emp.salary < 6000
UNION ALL
SELECT emp.name, emp.salary FROM testdb.test_insert_overwrite_dir emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;

spark.sql(test_sql).collect().foreach(println);
//dfs -cat /tmp/union.out/*;
//dfs -rm -r /tmp/union.out;

System.exit(0);
