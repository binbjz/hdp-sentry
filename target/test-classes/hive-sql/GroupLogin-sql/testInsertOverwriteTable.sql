USE mart_waimai;

INSERT INTO mart_waimai.table001 VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.cli.print.header=true;

INSERT OVERWRITE TABLE mart_waimai.table002 SELECT name, ip FROM mart_waimai.table001 WHERE name='meituan';
SELECT * FROM mart_waimai.table002;

INSERT OVERWRITE TABLE mart_waimai.table002 SELECT * FROM mart_waimai.table001;
SELECT * FROM mart_waimai.table002;

SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM mart_waimai.table002;
