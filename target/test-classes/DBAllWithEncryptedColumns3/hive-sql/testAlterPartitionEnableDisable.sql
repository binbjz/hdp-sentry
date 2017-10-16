USE encrypt_db4alter;
ALTER TABLE encrypt_db4alter.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE encrypt_db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE encrypt_db4alter.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE encrypt_db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE encrypt_db4alter.log_messages PARTITION(year = 2017, month = 8, day = 2) ENABLE OFFLINE;
ALTER TABLE encrypt_db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 2);

ALTER TABLE encrypt_db4alter.log_messages PARTITION(year = 2017, month = 8, day = 2) DISABLE OFFLINE;
ALTER TABLE encrypt_db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 2);
