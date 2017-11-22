#!/bin/bash
#filename: sentry_flag.sh
#
#The script will check sentry flag status (true|false)
#

flag_priv_type=keytab_auth # keytab_auth|proxy_user_t1
flag_proxy_regex="proxy_user_t1"
resource_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
projectdir="$( cd $resource_dir/../../.. && pwd )"


declare -A sentry_priv sentry_f
sentry_priv[drop_table]="SentryFlagDropTable"
sentry_priv[drop_db]="SentryFlagDropDB"
sentry_priv[alter_table]="SentryFlagAlterTable"

sentry_f[drop_table]="drop_table"
sentry_f[drop_db]="drop_db"
sentry_f[alter_table]="alter_table"


# 1. Check server all with drop table
# Check sentry flag with temp sql
cat <<- EOF > $$_drop_table.sql
CREATE DATABASE IF NOT EXISTS testdroptbl;
USE testdroptbl;
CREATE TABLE tbldrop(id STRING);
DROP TABLE tbldrop;
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
CREATE DATABASE IF NOT EXISTS testaltertbl;
USE testaltertbl;
CREATE TABLE tbl4alter (id INT);
ALTER TABLE tbl4alter RENAME TO tbl4alter2;
EOF

# Clean db env
cat <<- EOF > $$_clean_db_env.sql
DROP DATABASE IF EXISTS testdroptbl CASCADE;
DROP DATABASE IF EXISTS testdropdb CASCADE;
DROP DATABASE IF EXISTS testaltertbl CASCADE;
EOF


# Check sentry flag status
check_sentry_flag_status(){
    # Grant privilege to role
    source $projectdir/src/main/resources/sentry_env.sh setup ${1}

    # Grant user with super privilege
    source $projectdir/src/main/resources/hive_env.sh $flag_priv_type super
    $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f $$_${2}.sql

    # In proxy env, we need to revoke privileges otherwise it will throw exception
    if [[ "$flag_priv_type" = $flag_proxy_regex ]]; then
        source $projectdir/src/main/resources/hive_env.sh clean_proxy_user hive
    fi

    source $projectdir/src/main/resources/sentry_env.sh check ${1} > $$_${2}.txt 2>&1
    result=`grep "${sentry_privileges[$1]}" $$_${2}.txt`

    [[ "$result" = "" ]] && sentry_flag=true || sentry_flag=false
    echo -e "`date +%Y-%m-%d_%H:%M:%S` INFO sentry flag: $sentry_flag\n"

    # Grant user with super privilege and clean db env
    source $projectdir/src/main/resources/hive_env.sh $flag_priv_type super
    $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f $$_clean_db_env.sql

    # In proxy env, we need to revoke privileges otherwise it will throw exception
    if [[ "$flag_priv_type" = $flag_proxy_regex ]]; then
        source $projectdir/src/main/resources/hive_env.sh clean_proxy_user hive
    fi

    # Revoke privileges for role
    source $projectdir/src/main/resources/sentry_env.sh clean ${1} > /dev/null 2>&1

    # Remove temp files
    cd $projectdir && rm -rf $$_${2}.sql $$_${2}.txt
}


echo -e "\n`date +%Y-%m-%d_%H:%M:%S` INFO Checking sentry flag status"
check_sentry_flag_status ${sentry_priv[drop_table]} ${sentry_f[drop_table]}
check_sentry_flag_status ${sentry_priv[drop_db]} ${sentry_f[drop_db]}
check_sentry_flag_status ${sentry_priv[alter_table]} ${sentry_f[alter_table]}


# Remove temp file
cd $projectdir && rm $$_clean_db_env.sql
