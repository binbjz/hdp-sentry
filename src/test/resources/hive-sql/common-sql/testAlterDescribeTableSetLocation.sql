USE testdb;

dfs -mkdir /user/hive/warehouse/testdb.db/tbl4setlocation_new;
--获取table的真实hdfs路径
DESC FORMATTED testdb.tbl4setlocation;
ALTER TABLE testdb.tbl4setlocation SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4setlocation_new';
DESC FORMATTED testdb.tbl4setlocation;
