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

import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
val fs=FileSystem.get(sc.hadoopConfiguration)

val jsonPath="/user/hive/warehouse/testdb.db/spark_ca_employees_json"
if(fs.exists(new Path(jsonPath)))
  fs.delete(new Path(jsonPath),true)
spark.sql(test_sql).write.format("json").save("/user/hive/warehouse/testdb.db/spark_ca_employees_json");

val parquetPath="/user/hive/warehouse/testdb.db/spark_ca_employees_parquet"
if(fs.exists(new Path(parquetPath)))
  fs.delete(new Path(parquetPath),true)
spark.sql(test_sql).write.format("parquet").save("/user/hive/warehouse/testdb.db/spark_ca_employees_parquet");

val orcPath="/user/hive/warehouse/testdb.db/spark_ca_employees_orc"
if(fs.exists(new Path(orcPath)))
  fs.delete(new Path(orcPath),true)
spark.sql(test_sql).write.format("orc").save("/user/hive/warehouse/testdb.db/spark_ca_employees_orc");

val df_parquet = spark.read.load(parquetPath);
df_parquet.collect.foreach(println);
val df_json = spark.read.format("json").load(jsonPath);
df_json.collect.foreach(println);
val df_orc = spark.read.format("orc").load(orcPath);
df_json.collect.foreach(println);


if(fs.exists(new Path(jsonPath)))
  fs.delete(new Path(jsonPath),true)

if(fs.exists(new Path(parquetPath)))
  fs.delete(new Path(parquetPath),true)

if(fs.exists(new Path(orcPath)))
  fs.delete(new Path(orcPath),true)



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
