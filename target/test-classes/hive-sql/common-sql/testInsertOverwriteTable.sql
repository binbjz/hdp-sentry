USE testdb;

SET hive.cli.print.header=true;

INSERT OVERWRITE TABLE testdb.insert_overwrite_tbl SELECT name, ip FROM testdb.src_insert_overwrite_tbl WHERE name='meituan';
SELECT * FROM testdb.insert_overwrite_tbl;

INSERT OVERWRITE TABLE testdb.insert_overwrite_tbl SELECT * FROM testdb.src_insert_overwrite_tbl;
SELECT * FROM testdb.insert_overwrite_tbl;

SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM testdb.src_insert_overwrite_tbl;
