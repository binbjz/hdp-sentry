USE mart_waimai;

DESCRIBE EXTENDED mart_waimai.log_messages PARTITION (year = 2011, month = 1, day = 1);
ALTER TABLE mart_waimai.log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
DESCRIBE EXTENDED mart_waimai.log_messages PARTITION (year = 2011, month = 1, day = 1);

DESCRIBE EXTENDED mart_waimai.log_messages_external;
ALTER TABLE mart_waimai.log_messages_external SET FILEFORMAT SEQUENCEFILE;
DESCRIBE EXTENDED mart_waimai.log_messages_external;

dfs -rm -r /user/hive/warehouse/mart_waimai.db/log_messages_external;
