#!/bin/bash
#filename: sentry_flag.sh
#
#The script will check sentry flag and run sentry test
#

privil_type=proxy_user
sentry_f=SentryFlag
projectdir=/opt/meituan/qa_test/sentry-test

# 1. Check server all with table select
# Check sentry flag with temp sql
cat <<- EOF > $$.sql
CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
CREATE TABLE test_sentry_flag(id STRING);
DROP TABLE test_sentry_flag;
EOF

# Check sentry flag status
for sf in $sentry_f; do
    source $projectdir/src/main/resources/sentry_env.sh setup ${sf}
    source $projectdir/src/main/resources/hive_env.sh $privil_type super
    $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f $$.sql

    source $projectdir/src/main/resources/sentry_env.sh check ${sf} > $$.txt 2>&1
    result=`grep "${sentry_privileges[SentryFlag]}" $$.txt`
    [[ -n $result ]] && sentry_flag=flase || sentry_flag=true
    echo -e "\n`date +%Y-%m-%d_%H:%M:%S` INFO sentry flag:" $sentry_flag

    if [[ $privil_type = "proxy_user" ]]; then
        source $projectdir/src/main/resources/hive_env.sh clean_proxy_user hive
    fi

    source $projectdir/src/main/resources/sentry_env.sh clean ${sf} > /dev/null 2>&1
done

# Clean sentry flag temp env
rm -rf $$.sql $$.txt
