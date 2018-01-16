//encrypt_db4data.sessionization_step_one_origins_tgt_encrypted=encrypt_ssoo_user_id,encrypt_ssoo_pageview_id
//CREATE DATABASE encrypt_db4data;
//DROP DATABASE encrypt_db4data;

val test_sql="USE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE encrypt_db4data.session_test (
  st_user_id STRING
 ,st_pageview_id STRING
 ,st_page_url STRING
 ,st_referrer_url STRING
 ,st_timestamp DOUBLE)""";
spark.sql(test_sql).collect().foreach(println);
val test_sql="INSERT INTO encrypt_db4data.session_test VALUES ('user001', 'pageview001', 'www.baidu.com', 'www.baidu.com/reference_url', 10001430), ('user002', 'pageview002', 'www.meituan.com', 'www.meituan.com/reference_url', 10001930)";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SET hive.cli.print.header=true";
spark.sql(test_sql).collect().foreach(println);

val test_sql="""CREATE TABLE encrypt_db4data.sessionization_step_one_origins_tgt_encrypted
AS
SELECT c.c_user_id as encrypt_ssoo_user_id
      ,c.c_pageview_id as encrypt_ssoo_pageview_id
      ,c.c_timestamp as encrypt_ssoo_timestamp
FROM (SELECT a.a_user_id as c_user_id
            ,a.a_pageview_id as c_pageview_id
            ,a.a_timestamp as c_timestamp
            ,SUM(IF(a.a_timestamp + 1800 >= b.b_timestamp AND a.a_timestamp < b.b_timestamp,1,0)) AS c_nonorigin_flags
      FROM (SELECT st_user_id as a_user_id
                  ,st_pageview_id as a_pageview_id
                  ,st_timestamp as a_timestamp
           FROM encrypt_db4data.session_test ) a
       JOIN (SELECT st_user_id as b_user_id
                   ,st_timestamp as b_timestamp
             FROM encrypt_db4data.session_test ) b
        ON a.a_user_id = b.b_user_id
      GROUP BY a.a_user_id
              ,a.a_pageview_id
              ,a.a_timestamp) c""";
spark.sql(test_sql).collect().foreach(println);

val test_sql="SELECT COUNT(*) FROM encrypt_db4data.sessionization_step_one_origins_tgt_encrypted";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DESCRIBE encrypt_db4data.sessionization_step_one_origins_tgt_encrypted";
spark.sql(test_sql).collect().foreach(println);

val test_sql="DROP TABLE encrypt_db4data.session_test";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DROP TABLE encrypt_db4data.sessionization_step_one_origins_tgt_encrypted";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
