--encrypt_db4data.encrypt_employees=encrypt_name,encrypt_salary,encrypt_subordinates,encrypt_deductions,encrypt_address
--encrypt_db4data.encrypt_tgt_employees=encrypt_name,encrypt_salary,encrypt_subordinates,encrypt_deductions,encrypt_address
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;

USE encrypt_db4data;

CREATE TABLE encrypt_db4data.employees1 (
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


CREATE TABLE encrypt_db4data.employees2 (
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

ALTER TABLE encrypt_db4data.employees2 ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE encrypt_db4data.employees2 ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE encrypt_db4data.employees2 ADD PARTITION (country = 'US', state = 'IL');

SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE encrypt_db4data.employees1
PARTITION (country = 'US', state = 'CA');


FROM encrypt_db4data.employees1 se
INSERT OVERWRITE TABLE encrypt_db4data.employees2 PARTITION (country = 'US', state = 'OR')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
INSERT OVERWRITE TABLE encrypt_db4data.employees2 PARTITION (country = 'US', state = 'IL')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
INSERT OVERWRITE TABLE encrypt_db4data.employees2 PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA';

FROM encrypt_db4data.employees1 se
INSERT OVERWRITE TABLE encrypt_db4data.employees2 PARTITION (country, state)
SELECT * ;




ALTER TABLE encrypt_db4data.encrypt_tgt_employees ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE encrypt_db4data.encrypt_tgt_employees ADD PARTITION (country = 'US', state = 'IL');
ALTER TABLE encrypt_db4data.encrypt_tgt_employees ADD PARTITION (country = 'US', state = 'CA');

SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.exec.dynamic.partition=true;

FROM encrypt_db4data.encrypt_employees se
INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country, state)
SELECT * ;


FROM encrypt_db4data.encrypt_employees se
INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'OR')
SELECT encrypt_name, encrypt_salary, encrypt_subordinates, encrypt_deductions, encrypt_address WHERE se.country = 'US' AND se.state = 'OR'
INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'IL')
SELECT encrypt_name, encrypt_salary, encrypt_subordinates, encrypt_deductions, encrypt_address WHERE se.country = 'US' AND se.state = 'IL'
INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'CA')
SELECT encrypt_name, encrypt_salary, encrypt_subordinates, encrypt_deductions, encrypt_address WHERE se.country = 'US' AND se.state = 'CA';



SET hive.cli.print.header=true;
SELECT * FROM encrypt_db4data.encrypt_tgt_employees;

INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'CA')
SELECT encrypt_name, encrypt_salary, encrypt_subordinates, encrypt_deductions, encrypt_address FROM encrypt_db4data.encrypt_employees se WHERE se.country = 'US' AND se.state = 'CA';

SELECT * FROM encrypt_db4data.encrypt_tgt_employees;
SELECT COUNT(*) FROM encrypt_db4data.encrypt_tgt_employees;

TRUNCATE TABLE encrypt_db4data.encrypt_tgt_employees;

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;
INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state)
SELECT se.encrypt_name, se.encrypt_salary, se.encrypt_subordinates, se.encrypt_deductions, se.encrypt_address, se.state FROM encrypt_db4data.encrypt_employees se WHERE se.country = 'US';
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

dfs -cat /tmp/union.out/* ;
dfs -rm -r /tmp/union.out ;

DROP TABLE encrypt_db4data.encrypt_tgt_employees;
DROP TABLE encrypt_db4data.encrypt_employees;





hive (encrypt_db4data)> USE encrypt_db4data;
OK
Time taken: 0.199 seconds
hive (encrypt_db4data)>
                      > CREATE TABLE encrypt_db4data.encrypt_employees (
                      >  encrypt_name STRING
                      > ,encrypt_salary FLOAT
                      > ,encrypt_subordinates ARRAY<STRING>
                      > ,encrypt_deductions MAP<STRING, FLOAT>
                      > ,encrypt_address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
                      > ) PARTITIONED BY (country STRING, state STRING)
                      > ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
                      > COLLECTION ITEMS TERMINATED BY '|'
                      > MAP KEYS TERMINATED BY '='
                      > LINES TERMINATED BY '\n' STORED AS TEXTFILE;
OK
Time taken: 0.695 seconds
hive (encrypt_db4data)>
                      > CREATE TABLE encrypt_db4data.encrypt_tgt_employees (
                      >  encrypt_name STRING
                      > ,encrypt_salary FLOAT
                      > ,encrypt_subordinates ARRAY<STRING>
                      > ,encrypt_deductions MAP<STRING, FLOAT>
                      > ,encrypt_address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
                      > ) PARTITIONED BY (country STRING, state STRING)
                      > ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
                      > COLLECTION ITEMS TERMINATED BY '|'
                      > MAP KEYS TERMINATED BY '='
                      > LINES TERMINATED BY '\n' STORED AS TEXTFILE;
OK
Time taken: 0.752 seconds
hive (encrypt_db4data)> ALTER TABLE encrypt_db4data.encrypt_employees ADD PARTITION (country = 'US', state = 'CA');
OK
Time taken: 0.705 seconds
hive (encrypt_db4data)> ALTER TABLE encrypt_db4data.encrypt_employees ADD PARTITION (country = 'US', state = 'OR');
OK
Time taken: 0.757 seconds
hive (encrypt_db4data)> ALTER TABLE encrypt_db4data.encrypt_employees ADD PARTITION (country = 'US', state = 'IL');
OK
Time taken: 0.734 seconds
hive (encrypt_db4data)>
                      > SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/hive-data;
hive (encrypt_db4data)> LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
                      > INTO TABLE encrypt_db4data.encrypt_employees
                      > PARTITION (country = 'US', state = 'CA');
Loading data to table encrypt_db4data.encrypt_employees partition (country=US, state=CA)
OK
Time taken: 3.033 seconds
hive (encrypt_db4data)> SELECT * FROM encrypt_db4data.encrypt_employees;
FAILED: SemanticException Column insufficient privileges to access: <encrypt_db4data>.<encrypt_employees>
hive (encrypt_db4data)> SELECT COUNT(*) FROM encrypt_db4data.encrypt_employees;
Query ID = sankuai_20171019182351_a06a10da-f890-4e06-b7b6-27e2153c9c8f
Total jobs = 1
Launching Job 1 out of 1
Number of reduce tasks determined at compile time: 1
In order to change the average load for a reducer (in bytes):
  set hive.exec.reducers.bytes.per.reducer=<number>
In order to limit the maximum number of reducers:
  set hive.exec.reducers.max=<number>
In order to set a constant number of reducers:
  set mapreduce.job.reduces=<number>
Starting Job = job_1505297521386_1563, Tracking URL = http://gh-data-hdp-qa04.corp.sankuai.com:8088/proxy/application_1505297521386_1563/
Kill Command = /opt/meituan/hadoop-sentry-qa/bin/hadoop job  -kill job_1505297521386_1563
Hadoop job information for Stage-1: number of mappers: 2; number of reducers: 1
2017-10-19 18:24:01,981 Stage-1 map = 0%,  reduce = 0%
2017-10-19 18:24:10,266 Stage-1 map = 100%,  reduce = 0%, Cumulative CPU 6.04 sec
2017-10-19 18:24:16,468 Stage-1 map = 100%,  reduce = 100%, Cumulative CPU 7.89 sec
MapReduce Total cumulative CPU time: 7 seconds 890 msec
Ended Job = job_1505297521386_1563
MapReduce Jobs Launched:
Stage-Stage-1: Map: 2  Reduce: 1   Cumulative CPU: 7.89 sec   HDFS Read: 21259 HDFS Write: 2 SUCCESS
Total MapReduce CPU Time Spent: 7 seconds 890 msec
OK
4
Time taken: 26.985 seconds, Fetched: 1 row(s)
hive (encrypt_db4data)> ALTER TABLE encrypt_db4data.encrypt_tgt_employees ADD PARTITION (country = 'US', state = 'OR');
OK
Time taken: 0.744 seconds
hive (encrypt_db4data)> ALTER TABLE encrypt_db4data.encrypt_tgt_employees ADD PARTITION (country = 'US', state = 'IL');
OK
Time taken: 0.712 seconds
hive (encrypt_db4data)> ALTER TABLE encrypt_db4data.encrypt_tgt_employees ADD PARTITION (country = 'US', state = 'CA');
OK
Time taken: 0.76 seconds
hive (encrypt_db4data)> FROM encrypt_db4data.encrypt_employees se
                      > INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'OR')
                      > SELECT encrypt_name, encrypt_salary, encrypt_subordinates, encrypt_deductions, encrypt_address WHERE se.country = 'US' AND se.state = 'OR'
                      > INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'IL')
                      > SELECT encrypt_name, encrypt_salary, encrypt_subordinates, encrypt_deductions, encrypt_address WHERE se.country = 'US' AND se.state = 'IL'
                      > INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'CA')
                      > SELECT encrypt_name, encrypt_salary, encrypt_subordinates, encrypt_deductions, encrypt_address WHERE se.country = 'US' AND se.state = 'CA';
FAILED: SemanticException [Error 10004]: Line 3:7 Invalid table alias or column reference 'encrypt_name': (possible column names are: encrypted_name_37513_encrypt_name, encrypted_name_7429_encrypt_salary, encrypted_name_24295_encrypt_subordinates, encrypted_name_41859_encrypt_deductions, encrypted_name_96642_encrypt_address, country, state) or Column insufficient privileges to access: encrypt_name
hive (encrypt_db4data)>
                      > FROM encrypt_db4data.encrypt_employees se
                      > INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'OR')
                      > SELECT * WHERE se.country = 'US' AND se.state = 'OR'
                      > ;
FAILED: SemanticException [Error 10044]: Line 2:23 Cannot insert into target table because column number/types are different ''OR'': Table insclause-0 has 5 columns, but query has 7 columns.
hive (encrypt_db4data)> FROM encrypt_db4data.encrypt_employees se
                      > INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country, state)
                      > SELECT * ;
FAILED: SemanticException [Error 10096]: Dynamic partition strict mode requires at least one static partition column. To turn this off set hive.exec.dynamic.partition.mode=nonstrict
hive (encrypt_db4data)> set hive.exec.dynamic.partition.mode=nonstrict;
hive (encrypt_db4data)> FROM encrypt_db4data.encrypt_employees se
                      > INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country, state)
                      > SELECT * ;
FAILED: SemanticException 2:23 Dynamic partition is disabled. Either enable it by setting hive.exec.dynamic.partition=true or specify partition column values. Error encountered near token 'state'
hive (encrypt_db4data)> SET hive.exec.dynamic.partition=true;
hive (encrypt_db4data)> FROM encrypt_db4data.encrypt_employees se
                      > INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country, state)
                      > SELECT * ;
FAILED: SemanticException Column insufficient privileges to access: <encrypt_db4data>.<encrypt_employees>
hive (encrypt_db4data)> FROM encrypt_db4data.encrypt_employees se
                      > INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'OR')
                      > SELECT encrypt_name, encrypt_salary, encrypt_subordinates, encrypt_deductions, encrypt_address WHERE se.country = 'US' AND se.state = 'OR'
                      > INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'IL')
                      > SELECT encrypt_name, encrypt_salary, encrypt_subordinates, encrypt_deductions, encrypt_address WHERE se.country = 'US' AND se.state = 'IL'
                      > INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'CA')
                      > SELECT encrypt_name, encrypt_salary, encrypt_subordinates, encrypt_deductions, encrypt_address WHERE se.country = 'US' AND se.state = 'CA';
FAILED: SemanticException [Error 10004]: Line 3:7 Invalid table alias or column reference 'encrypt_name': (possible column names are: encrypted_name_33918_encrypt_name, encrypted_name_82841_encrypt_salary, encrypted_name_28260_encrypt_subordinates, encrypted_name_18597_encrypt_deductions, encrypted_name_68182_encrypt_address, country, state) or Column insufficient privileges to access: encrypt_name
hive (encrypt_db4data)> SET hive.cli.print.header=true;
hive (encrypt_db4data)> SELECT * FROM encrypt_db4data.encrypt_tgt_employees;
FAILED: SemanticException Column insufficient privileges to access: <encrypt_db4data>.<encrypt_tgt_employees>
hive (encrypt_db4data)> INSERT OVERWRITE TABLE encrypt_db4data.encrypt_tgt_employees PARTITION (country = 'US', state = 'CA')
                      > SELECT encrypt_name, encrypt_salary, encrypt_subordinates, encrypt_deductions, encrypt_address FROM encrypt_db4data.encrypt_employees se WHERE se.country = 'US' AND se.state = 'CA';
FAILED: SemanticException [Error 10004]: Line 2:7 Invalid table alias or column reference 'encrypt_name': (possible column names are: encrypted_name_37416_encrypt_name, encrypted_name_71490_encrypt_salary, encrypted_name_79586_encrypt_subordinates, encrypted_name_41940_encrypt_deductions, encrypted_name_38646_encrypt_address, country, state) or Column insufficient privileges to access: encrypt_name