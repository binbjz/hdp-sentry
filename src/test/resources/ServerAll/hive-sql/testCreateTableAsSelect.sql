DROP DATABASE IF EXISTS db4data CASCADE;
CREATE DATABASE db4data;
CREATE TABLE db4data.session_test (
   st_user_id STRING
  ,st_pageview_id STRING
  ,st_page_url STRING
  ,st_referrer_url STRING
  ,st_timestamp DOUBLE);

INSERT INTO db4data.session_test VALUES ('user001','page_no1','www.mt.com','www.mt.com/referrer_url', '1506682968'), ('user002','page_no2','www.mt.com','www.mt.com/referrer_url', '1506683968');

CREATE TABLE db4data.sessionization_step_one_origins AS
SELECT c.c_user_id as ssoo_user_id
      ,c.c_pageview_id as ssoo_pageview_id
      ,c.c_timestamp as ssoo_timestamp
FROM (SELECT a.a_user_id as c_user_id
            ,a.a_pageview_id as c_pageview_id
            ,a.a_timestamp as c_timestamp
            ,SUM(IF(a.a_timestamp + 1800 >= b.b_timestamp AND a.a_timestamp < b.b_timestamp,1,0)) AS c_nonorigin_flags
      FROM (SELECT st_user_id as a_user_id
                  ,st_pageview_id as a_pageview_id
                  ,st_timestamp as a_timestamp
            FROM db4data.session_test ) a
         JOIN (SELECT st_user_id as b_user_id
                     ,st_timestamp as b_timestamp
               FROM db4data.session_test ) b
           ON a.a_user_id = b.b_user_id
      GROUP BY a.a_user_id
              ,a.a_pageview_id
              ,a.a_timestamp) c;

SET hive.cli.print.header=true;
SELECT * FROM db4data.sessionization_step_one_origins;

DESCRIBE db4data.sessionization_step_one_origins;

DROP DATABASE db4data CASCADE;