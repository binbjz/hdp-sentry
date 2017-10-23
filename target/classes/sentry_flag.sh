#!/bin/bash
#filename: sentry_flag.sh
#
#The script will check sentry flag status (true|false)
#

privil_type=proxy_user
projectdir=/opt/meituan/qa_test/sentry-test

declare -A sentry_priv sentry_f
sentry_priv[table]="SentryFlagTable"
sentry_priv[db]="SentryFlagDB"
sentry_f[table]="table"
sentry_f[db]="db"

# 1. Check server all with table select
# Check sentry flag with temp sql
cat <<- EOF > $$_table.sql
CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
CREATE TABLE test_sentry_flag(id STRING);
DROP TABLE test_sentry_flag;
EOF

# 2. Check server all with db select
# Check sentry flag with temp sql
cat <<- EOF > $$_db.sql
CREATE DATABASE IF NOT EXISTS testdb;
USE testdb;
DROP database testdb;
EOF

# Check sentry flag status
check_sentry_flag_status(){
    source $projectdir/src/main/resources/sentry_env.sh setup ${1}
    source $projectdir/src/main/resources/hive_env.sh $privil_type super
    $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f $$_${2}.sql

    source $projectdir/src/main/resources/sentry_env.sh check ${1} > $$_${2}.txt 2>&1
    result=`grep "${sentry_privileges[SentryFlag]}" $$_${2}.txt`
    [[ -n $result ]] && sentry_flag=flase || sentry_flag=true
    echo -e "`date +%Y-%m-%d_%H:%M:%S` INFO sentry flag: $sentry_flag\n"

    if [[ $privil_type = "proxy_user" ]]; then
        source $projectdir/src/main/resources/hive_env.sh clean_proxy_user hive
    fi

    source $projectdir/src/main/resources/sentry_env.sh clean ${1} > /dev/null 2>&1
    # Clean sentry flag temp env
    rm -rf $$_${2}.sql $$_${2}.txt
}

check_sentry_flag_status ${sentry_priv[table]} ${sentry_f[table]}
check_sentry_flag_status ${sentry_priv[db]} ${sentry_f[db]}
