#!/bin/bash
#filename: sentry_flag.sh
#
#The script will check sentry flag status (true|false)
#

privil_type=proxy_user
resource_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
projectdir="$( cd $resource_dir/../../.. && pwd )"

declare -A sentry_priv sentry_f
sentry_priv[drop_table]="SentryFlagDropTable"
sentry_priv[drop_db]="SentryFlagDropDB"
sentry_priv[alter_table]="SentryFlagAlterTable"
sentry_priv[alter_table2]="SentryFlagAlterTable2"

sentry_f[drop_table]="drop_table"
sentry_f[drop_db]="drop_db"
sentry_f[alter_table]="alter_table"

# 1. Check server all with drop table
# Check sentry flag with temp sql
cat <<- EOF > $$_drop_table.sql
CREATE DATABASE IF NOT EXISTS testdroptbl;
USE testdroptbl;
CREATE TABLE test_sentry_flag(id STRING);
DROP TABLE test_sentry_flag;
EOF

# 2. Check server all with drop db
# Check sentry flag with temp sql
cat <<- EOF > $$_drop_db.sql
CREATE DATABASE IF NOT EXISTS testdropdb;
USE testdropdb;
DROP DATABASE testdropdb;
EOF

# 3. Check server all with alter db
# Check sentry flag with temp sql
cat <<- EOF > $$_alter_table.sql
CREATE DATABASE IF NOT EXISTS testalter;
USE testalter;
CREATE TABLE tbl4alter (id INT);
ALTER TABLE tbl4alter RENAME TO tbl4alter2;
EOF

# Check sentry flag status
check_sentry_flag_status(){
    source $projectdir/src/main/resources/sentry_env.sh setup ${1}
    source $projectdir/src/main/resources/hive_env.sh $privil_type super
    $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f $$_${2}.sql

    if [[ $privil_type = "proxy_user" ]]; then
        source $projectdir/src/main/resources/hive_env.sh clean_proxy_user hive
    fi

    if [[ -n "$3" ]] && [[ "$3" == "SentryFlagAlterTable2" ]]; then
        source $projectdir/src/main/resources/sentry_env.sh check ${3} > $$_${2}.txt 2>&1
        result=`grep "${sentry_privileges[$3]}" $$_${2}.txt`
    else
        source $projectdir/src/main/resources/sentry_env.sh check ${1} > $$_${2}.txt 2>&1
        result=`grep "${sentry_privileges[$1]}" $$_${2}.txt`
    fi

    [[ -n $result ]] && sentry_flag=flase || sentry_flag=true
    echo -e "`date +%Y-%m-%d_%H:%M:%S` INFO sentry flag: $sentry_flag\n"

    source $projectdir/src/main/resources/sentry_env.sh clean ${1} > /dev/null 2>&1
    # Clean sentry flag temp env
    cd $projectdir && rm -rf $$_${2}.sql $$_${2}.txt
}

check_sentry_flag_status ${sentry_priv[drop_table]} ${sentry_f[drop_table]}
check_sentry_flag_status ${sentry_priv[drop_db]} ${sentry_f[drop_db]}
check_sentry_flag_status ${sentry_priv[alter_table]} ${sentry_f[alter_table]} ${sentry_priv[alter_table2]}
