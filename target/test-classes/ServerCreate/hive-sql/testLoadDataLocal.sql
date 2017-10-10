CREATE TABLE testDB.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';
LOAD DATA LOCAL INPATH '${env:FILEPATH}/afile.txt' INTO TABLE testDB.collecttest;

SELECT str, concat_ws( ',' , collect(cast(countVal AS STRING))) FROM testDB.collecttest GROUP BY str;

DROP TABLE testDB.collecttest;
