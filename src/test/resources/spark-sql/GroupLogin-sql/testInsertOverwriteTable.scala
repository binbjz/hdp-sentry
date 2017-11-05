val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT INTO mart_waimai.table001 VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3')";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE mart_waimai.table002 SELECT name, ip FROM mart_waimai.table001 WHERE name='meituan'";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM mart_waimai.table002";
spark.sql(test_sql).collect().foreach(println);

val test_sql="INSERT OVERWRITE TABLE mart_waimai.table002 SELECT * FROM mart_waimai.table001";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT * FROM mart_waimai.table002";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM mart_waimai.table002";
spark.sql(test_sql).collect().foreach(println);

:q
