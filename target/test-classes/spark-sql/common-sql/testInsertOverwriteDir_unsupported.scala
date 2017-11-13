val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

import org.apache.hadoop.fs.FileSystem
import org.apache.hadoop.fs.Path
val fs=FileSystem.get(sc.hadoopConfiguration)

if(fs.exists(new Path("/tmp/ca_employees")))
  fs.delete(new Path("/tmp/ca_employees"),true)

/* INSERT OVERWRITE LOCAL DIRECTORY
 * INSERT OVERWRITE DIRECTORY
 * DOES NOT SUPPORT */
var test_sql="""INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM testdb.test_insert_overwrite_dir se WHERE se.country = 'US' and se.state = 'CA'""";
spark.sql(test_sql).collect().foreach(println);

if(fs.exists(new Path("/tmp/ca_employees")))
  fs.delete(new Path("/tmp/ca_employees"),true)


if(fs.exists(new Path("/tmp/union.out")))
  fs.delete(new Path("/tmp/union.out"),true)

var test_sql="""FROM (
SELECT emp.name, emp.salary FROM testdb.test_insert_overwrite_dir emp WHERE emp.salary < 6000
UNION ALL
SELECT emp.name, emp.salary FROM testdb.test_insert_overwrite_dir emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*""";

spark.sql(test_sql).collect().foreach(println);

if(fs.exists(new Path("/tmp/union.out")))
  fs.delete(new Path("/tmp/union.out"),true)

System.exit(0);
