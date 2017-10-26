#!/bin/bash
#filename: run_sentry_tcs.sh
#
#The script will run sentry test, include standard and user+group authorization approach
#/usr/bin/time -f "Time: %U" bash run_sentry_tcs.sh
#

E_BADDIR=65
privil_type=proxy_user  # proxy_user|keytab_auth|proxy_user_group
privil_type_ug=proxy_user_group
projectdir=/opt/meituan/qa_test/sentry-test
libdir=/opt/meituan/qa_test/data_bin
exclude_patt="ServerAll|ServerWrite"
include_patt="DBAllWithEncryptedColumns|DBAllWithEncryptedColumns_2|DBAllWithEncryptedColumns_3|GroupLogin|GroupLogin_2|GroupLogin_3|GroupLogin_4"
include_patt2="GroupLogin"

# Check project directory
if [ ! -d "$projectdir" ]; then
    echo "$projectdir is not a directory."
    exit $E_BADDIR
fi

# Setup super privilege
cd $projectdir
source $projectdir/src/main/resources/sentry_env.sh setup SuperPrivil

# Check sentry flag
source $projectdir/src/main/resources/sentry_flag.sh

# Run sentry test for standard authorization approach
sentry_tcs="ServerAll ServerAlter ServerCreate ServerDrop ServerInsert ServerSelect ServerWrite DBAll DBAlter DBCreate DBDrop DBInsert DBSelect DBWrite TableAll TableAlter TableCreate TableDrop TableInsert TableSelect TableWrite DBAllWithEncryptedColumns DBAllWithEncryptedColumns_2 DBAllWithEncryptedColumns_3 GroupLogin GroupLogin_2 GroupLogin_3 GroupLogin_4"

for tc in $sentry_tcs; do
    # It will be used to set multiple permissions for the same test case
    export case_name=$tc

    # Check grant privilege for proxy user, keytab or proxy user+group
    if echo "$tc" | egrep -qi "$include_patt2"; then
        sentry_sh=sentry_grp_env.sh
    else
        sentry_sh=sentry_env.sh
    fi

    # Exclude the test case that does not contain preppare sql
    source $projectdir/src/main/resources/$sentry_sh setup ${tc}
    if ! echo "$tc" | egrep -qi "'$exclude_patt'"; then
        # Grant role super privilege
        source $projectdir/src/main/resources/hive_env.sh $privil_type super

        if echo "$tc" | egrep -qi "'$include_patt'"; then
            tc_tmp=`awk -F'_' '{print $1}' <<< $tc`
            $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f $projectdir/src/test/resources/${tc_tmp}/hive-sql/prepare${tc_tmp}.sql
        else
            $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f $projectdir/src/test/resources/${tc}/hive-sql/prepare${tc}.sql
        fi
    fi

    # Grant role normal privilege
    if echo "$tc" | egrep -qi "'$include_patt2'"; then
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

    # Exclude the test case that does not contain post sql
    if ! echo "$tc" | egrep -qi "'$exclude_patt'"; then
        source $projectdir/src/main/resources/hive_env.sh $privil_type super

        if echo "$tc" | egrep -qi "'$include_patt'"; then
            $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f $projectdir/src/test/resources/${tc_tmp}/hive-sql/post${tc_tmp}.sql
        else
            $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f $projectdir/src/test/resources/${tc}/hive-sql/post${tc}.sql
        fi
    fi

    if [[ $privil_type = "proxy_user" ]]; then
        source $projectdir/src/main/resources/hive_env.sh clean_proxy_user hive
    fi
    source $projectdir/src/main/resources/$sentry_sh clean ${tc}
done

# Cleanup super privilege
source $projectdir/src/main/resources/sentry_env.sh clean SuperPrivil
