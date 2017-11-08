val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE dim";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE  TABLE dim.ndm_user_ctas
AS
SELECT
  userid --用户ID
 ,cityid --城市ID
 ,username --用户昵称
 ,email --验证后的主邮箱
 ,mobile --验证后的主手机号
 ,regdate --注册日期
 ,isemailverified --是否认证Email
 ,ismobilesignup --是否来自手机注册
 ,ismobileverified --是否认证手机
 ,isappuser --是否连接过第三方平台
 ,acctattr --用户账户属性值
FROM dim.ndm_user""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM dim.ndm_user_ctas";
spark.sql(test_sql).collect().foreach(println);

val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="""CREATE  TABLE mart_waimai.ndm_user_ctas
AS
SELECT
  userid --用户ID
 ,cityid --城市ID
 ,username --用户昵称
 ,email --验证后的主邮箱
 ,mobile --验证后的主手机号
 ,regdate --注册日期
 ,isemailverified --是否认证Email
 ,ismobilesignup --是否来自手机注册
 ,ismobileverified --是否认证手机
 ,isappuser --是否连接过第三方平台
 ,acctattr --用户账户属性值
FROM dim.ndm_user""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT * FROM mart_waimai.ndm_user_ctas";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE dim.ndm_user_ctas";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE mart_waimai.ndm_user_ctas";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
