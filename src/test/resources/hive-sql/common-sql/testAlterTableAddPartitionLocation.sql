USE testdb;

ALTER TABLE testdb.tbl4fileformat ADD PARTITION (year = 2022, month = 1, day = 1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4fileformat/2022/01/01';
SHOW PARTITIONS testdb.tbl4fileformat;
DESCRIBE EXTENDED testdb.tbl4fileformat PARTITION (year = 2022, month = 1, day = 1);

ALTER TABLE testdb.tbl4fileformat_external ADD PARTITION (year = 2022, month = 1, day = 1) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/testdb.db/tbl4fileformat_external/2022/01/01';
SHOW PARTITIONS testdb.tbl4fileformat_external;
DESCRIBE EXTENDED testdb.tbl4fileformat_external PARTITION (year = 2022, month = 1, day = 1);
