USE mart_waimai;
ALTER TABLE test_change CHANGE new_col1 new_col1to2 INT COMMENT "put column1 to position 2nd" AFTER new_col2;
ALTER TABLE test_change CHANGE new_col3 new_col3to1 INT COMMENT "put last column to position 1st" FIRST;
DESCRIBE test_change;
