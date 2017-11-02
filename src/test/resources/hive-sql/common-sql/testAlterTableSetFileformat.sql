USE testdb;

ALTER TABLE testdb.tbl4fileformat PARTITION (year=2012, month=1, day=1) SET FILEFORMAT SEQUENCEFILE;
DESCRIBE EXTENDED testdb.tbl4fileformat PARTITION (year=2012, month=1, day=1);
ALTER TABLE testdb.tbl4fileformat SET FILEFORMAT SEQUENCEFILE;
DESCRIBE EXTENDED testdb.tbl4fileformat;

ALTER TABLE testdb.tbl4fileformat_external PARTITION (year=2012, month=1, day=1) SET FILEFORMAT SEQUENCEFILE;
DESCRIBE EXTENDED testdb.tbl4fileformat_external PARTITION (year=2012, month=1, day=1);
ALTER TABLE testdb.tbl4fileformat_external SET FILEFORMAT SEQUENCEFILE;
DESCRIBE EXTENDED testdb.tbl4fileformat_external;
