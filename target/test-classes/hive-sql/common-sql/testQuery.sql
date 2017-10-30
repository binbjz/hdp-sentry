USE testdb;

SET hive.cli.print.header=true;
-- test collect
SELECT str, concat_ws( ',' , collect_set(cast(countVal AS STRING))) FROM testdb.tbl4query GROUP BY str;
SELECT str, count(*) as val FROM testdb.tbl4query GROUP BY str;
SELECT count(*) FROM testdb.tbl4query;
SELECT 1;
