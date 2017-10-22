#!/bin/bash
#filename: run_sentry_tcs.sh
#
#/usr/bin/time -f "Time: %U" bash run_sentry_tcs.sh
#

E_BADDIR=65
privil_type=proxy_user
exclude_tc="ServerAll|ServerWrite"
projectdir=/opt/meituan/qa_test/sentry-test
libdir=/opt/meituan/qa_test/data_bin

if [ ! -d "$projectdir" ]; then
    echo "$projectdir is not a directory."
    exit $E_BADDIR
fi

cd $projectdir
source $projectdir/src/main/resources/sentry_env.sh setup SuperPrivil

sentry_tcs="ServerAll ServerAlter ServerCreate ServerDrop ServerInsert ServerSelect ServerWrite DBAll DBAlter DBCreate DBDrop DBInsert DBSelect DBWrite TableAll TableAlter TableCreate TableDrop TableInsert TableSelect TableWrite"

for tc in $sentry_tcs; do
    source $projectdir/src/main/resources/sentry_env.sh setup ${tc}
    if ! echo "$tc" | egrep -qi "'$exclude_tc'"; then
        source $projectdir/src/main/resources/hive_env.sh $privil_type super
        $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f $projectdir/src/test/resources/${tc}/hive-sql/prepare${tc}.sql
    fi

    source $projectdir/src/main/resources/hive_env.sh $privil_type normal
    java -Djava.ext.dirs=${libdir} -cp ${projectdir}/target/classes:${projectdir}/target/test-classes org.junit.runner.JUnitCore ${tc}

    if ! echo "$tc" | egrep -qi "'$exclude_tc'"; then
        source $projectdir/src/main/resources/hive_env.sh $privil_type super
        $HIVE_HOME/bin/hive --hiveconf hive.cli.errors.ignore=true -f $projectdir/src/test/resources/${tc}/hive-sql/post${tc}.sql
    fi

    if [[ $privil_type = "proxy_user" ]]; then
        source $projectdir/src/main/resources/hive_env.sh clean_proxy_user hive
    fi
    source $projectdir/src/main/resources/sentry_env.sh clean ${tc}
done

source $projectdir/src/main/resources/sentry_env.sh clean SuperPrivil
