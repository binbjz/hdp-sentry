DROP DATABASE encrypt_db4tbl CASCADE;
DROP DATABASE encrypt_db4data;
DROP DATABASE encrypt_db4alter;

DROP DATABASE encrypt_db4func;

DROP DATABASE encrypt_db4msck;
DROP DATABASE encrypt_db4props;

ALTER TABLE encrypt_db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 2);
