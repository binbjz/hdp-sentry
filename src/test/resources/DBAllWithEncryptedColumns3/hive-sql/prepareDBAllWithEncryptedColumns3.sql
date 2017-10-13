CREATE DATABASE encrypt_db4data;
CREATE DATABASE encrypt_db4alter;
CREATE DATABASE encrypt_db4props;
CREATE DATABASE encrypt_db4msck;

CREATE TABLE IF NOT EXISTS encrypt_db4alter.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE encrypt_db4alter.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE encrypt_db4alter.log_messages ADD PARTITION (year = 2017, month = 8, day = 2);


CREATE TABLE encrypt_db4data.employees (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

CREATE TABLE encrypt_db4data.staged_employees (
 name STRING
,salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

ALTER TABLE encrypt_db4data.staged_employees ADD PARTITION (country = 'US', state = 'CA');

