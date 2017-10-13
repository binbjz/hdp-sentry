DROP DATABASE encrypt_db4msck;
DROP DATABASE encrypt_db4props;
DROP DATABASE encrypt_db4data;

ALTER TABLE encrypt_db4alter.log_messages DROP PARTITION (year = 2017, month = 8, day = 2);

DROP DATABASE encrypt_db4alter;
