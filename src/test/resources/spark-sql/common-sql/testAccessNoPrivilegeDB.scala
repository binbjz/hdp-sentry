val test_sql="USE default";
spark.sql(test_sql).show();

val test_sql="SHOW DATABASES LIKE 'unaccessibledb'";
spark.sql(test_sql).show();

:q
