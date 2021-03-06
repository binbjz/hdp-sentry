USE testdb;

INSERT INTO testdb.sessionization_step_one_origins
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
           FROM testdb.session_test ) a
       JOIN (SELECT st_user_id as b_user_id
                   ,st_timestamp as b_timestamp
             FROM testdb.session_test ) b
        ON a.a_user_id = b.b_user_id
      GROUP BY a.a_user_id
              ,a.a_pageview_id
              ,a.a_timestamp) c;

SELECT * FROM testdb.sessionization_step_one_origins;




INSERT INTO testdb.insert_overwrite_tbl SELECT name, ip FROM testdb.src_insert_overwrite_tbl WHERE name='meituan';
SELECT * FROM testdb.insert_overwrite_tbl;

INSERT INTO testdb.insert_overwrite_tbl SELECT * FROM testdb.src_insert_overwrite_tbl;
SELECT * FROM testdb.insert_overwrite_tbl;

SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM testdb.src_insert_overwrite_tbl;
