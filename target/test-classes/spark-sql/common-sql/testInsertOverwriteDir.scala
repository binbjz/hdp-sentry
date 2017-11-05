val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

SET hive.exec.dynamic.partition=true;
spark.sql(test_sql).collect().foreach(println);
SET hive.vectorized.execution.enabled = true;
spark.sql(test_sql).collect().foreach(println);
SET hive.vectorized.execution.reduce.enabled = true;
spark.sql(test_sql).collect().foreach(println);

INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM testdb.test_insert_overwrite_dir se WHERE se.country = 'US' and se.state = 'CA';
spark.sql(test_sql).collect().foreach(println);
!ls -l /tmp/ca_employees;
!rm -r /tmp/ca_employees;

FROM (
SELECT emp.name, emp.salary FROM testdb.test_insert_overwrite_dir emp WHERE emp.salary < 6000
UNION ALL
SELECT emp.name, emp.salary FROM testdb.test_insert_overwrite_dir emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;

spark.sql(test_sql).collect().foreach(println);
dfs -cat /tmp/union.out/*;
dfs -rm -r /tmp/union.out;



val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

