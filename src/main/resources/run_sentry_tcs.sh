#!/bin/bash
#filename: run_sentry_tcs.sh
#
#The script will run sentry test
#/usr/bin/time -f "Time: %U" bash run_sentry_tcs.sh
#

E_BADDIR=65
privil_type=proxy_user
projectdir=/opt/meituan/qa_test/sentry-test
libdir=/opt/meituan/qa_test/data_bin
exclude_tc="ServerAll|ServerWrite"
exclude_tc2="DBAllWithEncryptedColumns|DBAllWithEncryptedColumns_2|DBAllWithEncryptedColumns_3|GroupLogin|GroupLogin_2|GroupLogin_3|GroupLogin_4"

# Check project directory
if [ ! -d "$projectdir" ]; then
    echo "$projectdir is not a directory."
    exit $E_BADDIR
fi

cd $projectdir
#source $projectdir/src/main/resources/sentry_env.sh setup SuperPrivil

# Check sentry flag
source $projectdir/src/main/resources/sentry_flag.sh

# Run sentry test
sentry_tcs="ServerAlter"
#sentry_tcs="DBAllWithEncryptedColumns DBAllWithEncryptedColumns_2 DBAllWithEncryptedColumns_3"
#sentry_tcs="ServerAll ServerAlter ServerCreate ServerDrop ServerInsert ServerSelect ServerWrite DBAll DBAlter DBCreate DBDrop DBInsert DBSelect DBWrite TableAll TableAlter TableCreate TableDrop TableInsert TableSelect TableWrite DBAllWithEncryptedColumns DBAllWithEncryptedColumns_2 DBAllWithEncryptedColumns_3 GroupLogin GroupLogin_2 GroupLogin_3 GroupLogin_4"

for tc in $sentry_tcs; do
    # It will be used to set multiple permissions for the same test case
    export case_name=$tc

    # Exclude the test case that does not contain preppare sql
    source $projectdir/src/main/resources/sentry_env.sh setup ${tc}
    if ! echo "$tc" | egrep -qi "'$exclude_tc'"; then
        # Grant role super privilege
        source $projectdir/src/main/resources/hive_env.sh $privil_type super
        $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f $projectdir/src/test/resources/${tc}/hive-sql/prepare${tc}.sql
    fi

    # Grant role normal privilege
    source $projectdir/src/main/resources/hive_env.sh $privil_type normal

    # Use the same test case to run multiple permissions
    if echo "$tc" | egrep -qi "'$exclude_tc2'"; then
        tc_tmp=`awk -F'_' '{print $1}' <<< $tc`
        java -Djava.ext.dirs=${libdir} -cp ${projectdir}/target/classes:${projectdir}/target/test-classes org.junit.runner.JUnitCore ${tc_tmp}
    else
        java -Djava.ext.dirs=${libdir} -cp ${projectdir}/target/classes:${projectdir}/target/test-classes org.junit.runner.JUnitCore ${tc}
    fi

    # Exclude the test case that does not contain post sql
    if ! echo "$tc" | egrep -qi "'$exclude_tc'"; then
        source $projectdir/src/main/resources/hive_env.sh $privil_type super
        $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f $projectdir/src/test/resources/${tc}/hive-sql/post${tc}.sql
    fi

    if [[ $privil_type = "proxy_user" ]]; then
        source $projectdir/src/main/resources/hive_env.sh clean_proxy_user hive
    fi
    source $projectdir/src/main/resources/sentry_env.sh clean ${tc}
done

# Cleanup super privilege
source $projectdir/src/main/resources/sentry_env.sh clean SuperPrivil
