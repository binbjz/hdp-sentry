USE testdb;

INSERT INTO testdb.src_insert_overwrite_tbl VALUES ('alibaba', '10.0.0.3');
SET hive.cli.print.header=true;
SELECT * FROM testdb.src_insert_overwrite_tbl WHERE name = 'alibaba';
