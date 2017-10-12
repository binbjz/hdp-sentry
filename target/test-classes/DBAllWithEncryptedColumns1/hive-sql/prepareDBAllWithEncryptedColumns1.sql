CREATE DATABASE encrypt_db4drop_cascade WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE TABLE encrypt_db4drop_cascade.encrypt_tbl1 (col1 TINYINT, col2 SMALLINT, encrypt_column STRING);
INSERT INTO encrypt_db4drop_cascade.encrypt_tbl1 VALUES (100, 100, 'it is a secret');
INSERT INTO encrypt_db4drop_cascade.encrypt_tbl1 VALUES (127, 200, 'never tell');
CREATE VIEW encrypt_db4drop_cascade.encrypt_view1 AS SELECT col1, col2, encrypt_column FROM encrypt_db4drop_cascade.encrypt_tbl1;
CREATE TABLE encrypt_db4drop_cascade.encrypt_tbl2 (col1 TINYINT, encrypt_column1 DOUBLE, encrypt_column2 STRING);
INSERT INTO encrypt_db4drop_cascade.encrypt_tbl2 VALUES (101, 101.12, 'Look at the stars Look how they shine for you'), (201, 201.12, 'So, then, I took my turn Oh, what a thing to ve done');
-- INSERT INTO encrypt_db4drop_cascade.encrypt_tbl2 VALUES (101, 101.12, '美团网，是2010年3月4日成立的团购网站。美团网有着吃喝玩乐全都有的宣传口号。总部位于北京市朝阳区望京东路6号。'), (201, 201.12, '北京美团网精选北京美食餐厅,酒店预订,电影票,旅游景点,外卖订餐,北京团购信息,您可查询商家评价店铺信息。北京生活,下载美团官方APP ,吃喝玩乐1折起。');

CREATE VIEW encrypt_db4drop_cascade.encrypt_view2 AS SELECT col1, encrypt_column1, encrypt_column2 FROM encrypt_db4drop_cascade.encrypt_tbl2;
CREATE DATABASE encrypt_db4tbl WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
CREATE TABLE encrypt_db4tbl.tbl4show (col1 TINYINT, encrypt_column SMALLINT);
INSERT INTO encrypt_db4tbl.tbl4show VALUES (1, 100), (2, 200);
CREATE VIEW encrypt_db4tbl.view4show AS SELECT col1, col2 FROM encrypt_db4tbl.tbl4show;
CREATE DATABASE encrypt_db4data;
CREATE DATABASE encrypt_db4alter WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');