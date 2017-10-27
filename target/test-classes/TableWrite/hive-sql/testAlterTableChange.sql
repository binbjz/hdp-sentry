USE testdb;
ALTER TABLE tbl4change CHANGE new_col1 new_col1to2 INT COMMENT "put column1 to position 2nd" AFTER new_col2;
ALTER TABLE tbl4change CHANGE new_col3 new_col3to1 INT COMMENT "put last column to position 1st" FIRST;
DESCRIBE tbl4change;
