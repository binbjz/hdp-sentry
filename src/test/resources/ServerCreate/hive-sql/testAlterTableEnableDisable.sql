CREATE TABLE IF NOT EXISTS testdb.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE testdb.log_messages ENABLE NO_DROP;
DROP testdb.log_messages;
ALTER TABLE testdb.log_messages DISABLE NO_DROP;
DROP testdb.log_messages;

ALTER TABLE testdb.log_messages ENABLE OFFLINE;
DROP testdb.log_messages;
ALTER TABLE testdb.log_messages DISABLE OFFLINE;
DROP testdb.log_messages;
