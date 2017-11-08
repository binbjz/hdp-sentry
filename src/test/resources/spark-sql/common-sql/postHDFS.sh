/*使用hadoop fs -rmr 命令删除分区的HDFS副本*/
dfs -rm -r /user/hive/warehouse/testdb.db/tbl4setlocation;
dfs -rm -r /user/hive/warehouse/testdb.db/tbl4setlocation_new;

dfs -rm -r /tmp/import_export_partition;
