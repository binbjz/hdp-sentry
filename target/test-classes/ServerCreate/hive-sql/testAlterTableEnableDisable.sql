CREATE TABLE IF NOT EXISTS testDB.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE testDB.log_messages ENABLE NO_DROP;
DROP testDB.log_messages;
ALTER TABLE testDB.log_messages DISABLE NO_DROP;
DROP testDB.log_messages;

ALTER TABLE testDB.log_messages ENABLE OFFLINE;
DROP testDB.log_messages;
ALTER TABLE testDB.log_messages DISABLE OFFLINE;
DROP testDB.log_messages;
