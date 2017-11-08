val test_sql="USE testdb";
spark.sql(test_sql).collect().foreach(println);

/*alter table change*/

val test_sql="ALTER TABLE tbl4change CHANGE col1 col1to2 INT COMMENT \"put column1 to position 2nd\" AFTER col2";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE tbl4change CHANGE col3 col3to1 INT COMMENT \"put last column to position 1st\" FIRST";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE tbl4change";
spark.sql(test_sql).collect().foreach(println);


/*alter table rename*/

val test_sql="ALTER TABLE tbl4rename SET TBLPROPERTIES ('notes' = 'Test for set tblproperties')";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES tbl4rename";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE tbl4rename RENAME TO tbl4rename_new";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TABLES LIKE 'tbl4rename*'";
spark.sql(test_sql).collect().foreach(println);

/*alter table analyze*/

val test_sql="ALTER TABLE tbl4analyze TOUCH";
spark.sql(test_sql).collect().foreach(println);

/*alter table set fileformat*/

val test_sql="ALTER TABLE testdb.tbl4fileformat PARTITION (year=2012, month=1, day=1) SET FILEFORMAT SEQUENCEFILE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.tbl4fileformat PARTITION (year=2012, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4fileformat SET FILEFORMAT SEQUENCEFILE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.tbl4fileformat";
spark.sql(test_sql).collect().foreach(println);

val test_sql="ALTER TABLE testdb.tbl4fileformat_external PARTITION (year=2012, month=1, day=1) SET FILEFORMAT SEQUENCEFILE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.tbl4fileformat_external PARTITION (year=2012, month=1, day=1)";
spark.sql(test_sql).collect().foreach(println);
val test_sql="ALTER TABLE testdb.tbl4fileformat_external SET FILEFORMAT SEQUENCEFILE";
spark.sql(test_sql).collect().foreach(println);
val test_sql="DESCRIBE EXTENDED testdb.tbl4fileformat_external";
spark.sql(test_sql).collect().foreach(println);


/* test AlterTableClusteredBySortedBy */

val test_sql="ALTER TABLE testdb.tbl4analyze CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
