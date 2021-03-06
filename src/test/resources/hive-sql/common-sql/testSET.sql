USE default;

--SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;
SET hive.cli.print.header=true;
SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

--SELECT '${hiveconf:FILEPATH}' filepath;
SELECT '${env:FILEPATH}' filepath;
SELECT '${hiveconf:hive.cli.print.header}' printheader;
SELECT '${hiveconf:hive.exec.dynamic.partition}' partition;
SELECT '${hiveconf:hive.exec.dynamic.partition.mode}' partition_mode;
