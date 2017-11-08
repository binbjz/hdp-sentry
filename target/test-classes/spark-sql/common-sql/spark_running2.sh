source /opt/meituan/hadoop/bin/hadoop_user_login.sh hadoop-launcher
export HADOOP_JAR_AUTHENTICATION=KERBEROS
export HADOOP_JAR_KERBEROS_KEYTAB_FILE=/etc/hadoop/keytabs/hadoop-launcher.keytab
export HADOOP_JAR_KERBEROS_PRINCIPAL=hadoop-launcher/_HOST@SANKUAI.COM
export HADOOP_PROXY_USER=mt_qa
/opt/meituan/spark-2.1-sentry/bin/spark-shell --master yarn --deploy-mode client --queue root.hadoop-hdp.etltest <<!EOF
val test_sql="SELECT 1";
spark.sql(test_sql).collect().foreach(println);

:q

!EOF