USE testdb;

ALTER TABLE tbl4change CHANGE col1 col1to2 INT COMMENT "put column1 to position 2nd" AFTER col2;
ALTER TABLE tbl4change CHANGE col3 col3to1 INT COMMENT "put last column to position 1st" FIRST;
DESCRIBE tbl4change;
