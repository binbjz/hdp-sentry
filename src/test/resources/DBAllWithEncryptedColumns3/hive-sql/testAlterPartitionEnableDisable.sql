ALTER TABLE encrypt_db4alter.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
SELECT hms, severity, server, process_id, message FROM encrypt_db4alter.log_messages;
ALTER TABLE encrypt_db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE encrypt_db4alter.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE encrypt_db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE encrypt_db4alter.log_messages PARTITION(year = 2017, month = 8, day = 2) ENABLE OFFLINE;
SELECT hms, severity, server, process_id, message FROM encrypt_db4alter.log_messages;
ALTER TABLE encrypt_db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 2);

ALTER TABLE encrypt_db4alter.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE OFFLINE;
