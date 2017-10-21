--DROP DATABASE testdb;

ALTER DATABASE testdb SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa');
DESCRIBE DATABASE EXTENDED testdb;
