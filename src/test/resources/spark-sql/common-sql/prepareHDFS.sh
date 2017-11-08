dfs -mkdir /user/hive/warehouse/testdb.db/tbl4setlocation_new;

dfs -mkdir -p /user/hive/warehouse/testdb.db/tbl4setlocation_new/year=2011/month=1/day=1;

/*创建两个分区目录*/
dfs -mkdir /user/hive/warehouse/testdb.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/testdb.db/test_msck/month=201604;
