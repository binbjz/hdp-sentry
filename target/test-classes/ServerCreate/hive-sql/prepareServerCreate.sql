CREATE TABLE test_msck (id INT, val STRING) PARTITIONED BY(month INT);

CREATE TABLE tbl4show (col1 STRING);
CREATE VIEW view4show AS SELECT col1 FROM tbl4show;
CREATE TABLE teacher (name STRING);
INSERT INTO teacher VALUES ('TEACHER QA');

CREATE TABLE tbl4addfile(who string);
LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/who.txt' OVERWRITE INTO TABLE tbl4addfile;