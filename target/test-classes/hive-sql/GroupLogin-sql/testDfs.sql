USE default;

--SET FILEPATH=/opt/meituan/qa_test/sentry-test/src/test/resources/source-data;
--!cp ${hiveconf:FILEPATH}/california-employees.csv ${hiveconf:FILEPATH}/california-employees.csv_new;
!cp ${env:FILEPATH}/california-employees.csv ${env:FILEPATH}/california-employees.csv_new;
--dfs -moveFromLocal ${hiveconf:FILEPATH}/california-employees.csv_new  /tmp;
dfs -moveFromLocal ${env:FILEPATH}/california-employees.csv_new  /tmp;
dfs -count /tmp/california-employees.csv_new;
dfs -cat /tmp/california-employees.csv_new;
dfs -copyToLocal /tmp/california-employees.csv_new /tmp;
dfs -rm /tmp/california-employees.csv_new;
!rm /tmp/california-employees.csv_new;
