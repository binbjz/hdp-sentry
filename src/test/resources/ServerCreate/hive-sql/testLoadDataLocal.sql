CREATE TABLE test_db.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';
LOAD DATA LOCAL INPATH '${env:FILEPATH}/afile.txt' INTO TABLE test_db.collecttest;

SELECT str, concat_ws( ',' , collect(cast(countVal AS STRING))) FROM test_db.collecttest GROUP BY str;

DROP TABLE test_db.collecttest;
