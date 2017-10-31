#!/bin/bash
#filename: sentry_dispatcher.sh
#
#The script will run sentry test, include standard and user+group authorization approach
#/usr/bin/time -f "Time: %U" bash run_sentry_tcs.sh
#


# Set env parm
E_BADDIR=65
privil_type=proxy_user  # proxy_user|keytab_auth
privil_type_ug=proxy_user_group
resource_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
projectdir="$( cd $resource_dir/../../.. && pwd )"

# Temporary env for dependent libraries
libdir=/opt/meituan/qa_test/data_bin

common_sql_src=$projectdir/src/test/resources/hive-sql/common-sql
encryptColumn_sql_src=$projectdir/src/test/resources/hive-sql/DBAllWithEncryptedColumns-sql
groupLogin_sql_src=$projectdir/src/test/resources/hive-sql/GroupLogin-sql

include_patt="DBAllWithEncryptedColumns|DBAllWithEncryptedColumns_2|DBAllWithEncryptedColumns_3|GroupLogin|GroupLogin_2|GroupLogin_3|GroupLogin_4"
include_patt2="DBAllWithEncryptedColumns"
include_patt3="GroupLogin"


# Check project directory
if [ ! -d "$projectdir" ]; then
    echo "$projectdir is not a directory."
    exit $E_BADDIR
fi

# Grant role with super privilege
cd $projectdir
source $projectdir/src/main/resources/sentry_env.sh setup SuperPrivil

# Check sentry flag
source $projectdir/src/main/resources/sentry_flag.sh


# Run sentry test for standard authorization approach
sentry_tcs="ServerAll ServerAlter ServerCreate ServerDrop ServerInsert ServerSelect ServerWrite DBAll DBAlter DBCreate DBDrop DBInsert DBSelect DBWrite TableAll TableAlter TableCreate TableDrop TableInsert TableSelect TableWrite DBAllWithEncryptedColumns DBAllWithEncryptedColumns_2 DBAllWithEncryptedColumns_3 GroupLogin GroupLogin_2 GroupLogin_3 GroupLogin_4"

for tc in $sentry_tcs; do
    # It will be used to set multiple permissions for the same test case
    export case_name=$tc

    # Define privilege type for proxy user, keytab or proxy user+group
    if echo "$tc" | egrep -qi "$include_patt3"; then
        sentry_sh=sentry_grp_env.sh
    else
        sentry_sh=sentry_env.sh
    fi
    
    # Grant role normal privilege
    source $projectdir/src/main/resources/$sentry_sh setup ${tc}

    # Grant user with super privilege
    source $projectdir/src/main/resources/hive_env.sh $privil_type super

    # Execute preppare sql
    if echo "$tc" | egrep -qi "$include_patt2"; then
        tc_tmp=`awk -F'_' '{print $1}' <<< $tc`
        $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f ${encryptColumn_sql_src}/prepare${tc_tmp}.sql
    elif echo "$tc" | egrep -qi "$include_patt3"; then
        tc_tmp=`awk -F'_' '{print $1}' <<< $tc`
        $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f ${groupLogin_sql_src}/prepare${tc_tmp}.sql
    else
        $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f ${common_sql_src}/prepareAll.sql
    fi

    # Grant user with group privilege while running in group test
    if echo "$tc" | egrep -qi "'$include_patt3'"; then
        source $projectdir/src/main/resources/hive_env.sh $privil_type_ug normal
    else
        source $projectdir/src/main/resources/hive_env.sh $privil_type normal
    fi

    # Use the same test case to run multiple permissions 
    if echo "$tc" | egrep -qi "'$include_patt'"; then
        java -Djava.ext.dirs=${libdir} -cp ${projectdir}/target/classes:${projectdir}/target/test-classes org.junit.runner.JUnitCore ${tc_tmp}
    else
        java -Djava.ext.dirs=${libdir} -cp ${projectdir}/target/classes:${projectdir}/target/test-classes org.junit.runner.JUnitCore ${tc}
    fi

    # Grant user with super privilege
    source $projectdir/src/main/resources/hive_env.sh $privil_type super
    # Execute post sql
    if echo "$tc" | egrep -qi "$include_patt2"; then
        tc_tmp=`awk -F'_' '{print $1}' <<< $tc`
        $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f ${encryptColumn_sql_src}/post${tc_tmp}.sql
    elif echo "$tc" | egrep -qi "$include_patt3"; then
        tc_tmp=`awk -F'_' '{print $1}' <<< $tc`
        $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f ${groupLogin_sql_src}/post${tc_tmp}.sql
    else
        $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f ${common_sql_src}/postAll.sql
    fi


    if [[ $privil_type = "proxy_user" ]]; then
        # In proxy env, if we need to revoke privileges otherwise it will throw exception
        source $projectdir/src/main/resources/hive_env.sh clean_proxy_user hive
    fi
    source $projectdir/src/main/resources/$sentry_sh clean ${tc}
done

# Revoke role with super privilege
source $projectdir/src/main/resources/sentry_env.sh clean SuperPrivil
