SHOW PARTITIONS db4alter.log_messages;
USE db4alter;
ALTER TABLE db4alter.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE db4alter.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE db4alter.log_messages PARTITION(year = 2017, month = 8, day = 2) ENABLE OFFLINE;
ALTER TABLE db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 2);
ALTER TABLE db4alter.log_messages PARTITION(year = 2017, month = 8, day = 2) DISABLE OFFLINE;
ALTER TABLE db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 2);
