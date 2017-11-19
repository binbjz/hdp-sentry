//encrypt_db4data.encrypt_employees=encrypt_name,encrypt_salary
//encrypt_db4data.encrypt_tgt_employees=encrypt_name,encrypt_salary
//CREATE DATABASE encrypt_db4data;
//DROP DATABASE encrypt_db4data;

USE encrypt_db4data;

CREATE TABLE encrypt_db4data.encrypt_employees (
 encrypt_name STRING
,encrypt_salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;


CREATE TABLE encrypt_db4data.encrypt_tgt_employees (
 encrypt_name STRING
,encrypt_salary FLOAT
,subordinates ARRAY<STRING>
,deductions MAP<STRING, FLOAT>
,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;


SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE encrypt_db4data.encrypt_employees
PARTITION (country = 'US', state = 'CA');

ALTER TABLE encrypt_db4data.encrypt_tgt_employees ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE encrypt_db4data.encrypt_tgt_employees ADD PARTITION (country = 'US', state = 'IL');
ALTER TABLE encrypt_db4data.encrypt_tgt_employees ADD PARTITION (country = 'US', state = 'CA');

SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.exec.dynamic.partition=true;

FROM encrypt_db4data.encrypt_employees se
INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country, state)
SELECT * ;

--FROM encrypt_db4data.encrypt_employees se
--INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'OR')
--SELECT encrypt_name, encrypt_salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
--INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'IL')
--SELECT encrypt_name, encrypt_salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
--INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'CA')
--SELECT encrypt_name, encrypt_salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA';

SET hive.cli.print.header=true;
SELECT * FROM encrypt_db4data.encrypt_tgt_employees;

INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'CA')
SELECT encrypt_name, encrypt_salary, subordinates, deductions, address FROM encrypt_db4data.encrypt_employees se WHERE se.country = 'US' AND se.state = 'CA';

SELECT * FROM encrypt_db4data.encrypt_tgt_employees;
SELECT COUNT(*) FROM encrypt_db4data.encrypt_tgt_employees;

TRUNCATE TABLE encrypt_db4data.encrypt_tgt_employees;

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;
INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state)
SELECT se.encrypt_name, se.encrypt_salary, se.subordinates, se.deductions, se.address, se.state FROM encrypt_db4data.encrypt_employees se WHERE se.country = 'US';
SELECT * FROM encrypt_db4data.encrypt_employees;

INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM encrypt_db4data.encrypt_employees se WHERE se.country = 'US' and se.state = 'CA';
!ls -l /tmp/ca_employees;
!ls -rm -r /tmp/ca_employees;

FROM (
SELECT emp.encrypt_name, emp.encrypt_salary FROM encrypt_db4data.encrypt_employees emp WHERE emp.encrypt_salary < 6000
UNION ALL
SELECT emp.encrypt_name, emp.encrypt_salary FROM encrypt_db4data.encrypt_employees emp WHERE emp.encrypt_salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;

dfs -cat /tmp/union.out/*;
dfs -rm -r /tmp/union.out ;

DROP TABLE encrypt_db4data.encrypt_tgt_employees;
DROP TABLE encrypt_db4data.encrypt_employees;


val test_sql="USE mart_waimai";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW TBLPROPERTIES mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS IN mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SHOW COLUMNS FROM mart_waimai.dim_ad_cpc_activity";
spark.sql(test_sql).collect().foreach(println);

System.exit(0);
