USE default;

DESCRIBE DATABASE EXTENDED mart_waimai;
ALTER DATABASE mart_waimai SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa');
DESCRIBE DATABASE EXTENDED mart_waimai;

DESCRIBE DATABASE EXTENDED dim;
ALTER DATABASE dim SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa');
DESCRIBE DATABASE EXTENDED dim;
