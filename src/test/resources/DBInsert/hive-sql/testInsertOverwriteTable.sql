USE db4overwrite;
INSERT INTO db4overwrite.table001 VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');
SET hive.cli.print.header=true;

INSERT OVERWRITE TABLE db4overwrite.table002 SELECT name, ip FROM db4overwrite.table001 WHERE name='meituan';
SELECT * FROM db4overwrite.table002;

INSERT OVERWRITE TABLE db4overwrite.table002 SELECT * FROM db4overwrite.table001;
SELECT * FROM db4overwrite.table002;

SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM db4overwrite.table002;
