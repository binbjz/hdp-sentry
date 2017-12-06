#!/bin/bash
#filename: sentry_dispatcher.sh
#
#The script will run sentry, hive and spark test. including keytab, proxy user and group authorization approach
#/usr/bin/time -f "Time: %U" bash sentry_dispatcher.sh
#

# Set env parm
E_BADDIR=65
proxy_regex="^proxy_user_t1$|^proxy_user_t2_(1|2)$"

# Set privilege type
privil_type=proxy_user_t2_2  # proxy_user_t1|proxy_user_t2_(1|2)|keytab_auth
privil_type_ug=proxy_user_group2 # proxy_user_group1|proxy_user_group2


resource_dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
project_dir="$( cd ${resource_dir}/../../.. && pwd )"
log_base=${project_dir}/src/test/log


# Temporary env for dependent libraries
libdir=/opt/meituan/qa_test/data_bin/test-lib/


##============
# Set hive env. If run hive sql please comment spark env statements
: <<COMMENTBLOCK
hive_12=hive-1.2

HIVE_HOME=`readlink -f /opt/meituan/${hive_12}`
cmd_exec="${HIVE_HOME}/bin/hive --hiveconf hive.cli.errors.ignore=true -f"
sql_src=hive-sql
file_suffix=sql
COMMENTBLOCK

# Set spark env. If run spark sql please comment hive env statements.
spark_21=spark-2.1
spark_22=spark-2.2

SPARK_HOME=`readlink -f /opt/meituan/${spark_22}`
cmd_exec="${SPARK_HOME}/bin/spark-shell --master yarn --deploy-mode client --queue root.hadoop-hdp.etltest --jars $project_dir/src/test/resources/source-data/hive_qa_udf.jar -i"
sql_src=spark-sql
file_suffix=scala
##============


# Formatting privilege info
priv_formatter(){
    case "$1" in
        g)  opt=Granting; shift ;;
        r)  opt=Revoking; shift ;;
        c)  opt=Checking; shift ;;
        *)  echo "Please specify valid info \"g\", \"r\" or \"c\""
            exit $BAD_PARAMS ;;
    esac

    echo -e "\n`date +%Y-%m-%d_%H:%M:%S.%N` INFO $opt $@ privileges"
}


# Set sql source path
common_sql_src=$project_dir/src/test/resources/$sql_src/common-sql
encryptColumn_sql_src=$project_dir/src/test/resources/$sql_src/DBAllWithEncryptedColumns-sql
groupLogin_sql_src=$project_dir/src/test/resources/$sql_src/GroupLogin-sql

# Set regex for multiple permissions
include_patt="DBAllWithEncryptedColumns|DBAllWithEncryptedColumns_2|DBAllWithEncryptedColumns_3|GroupLogin|GroupLogin_2|GroupLogin_3"
include_patt2="DBAllWithEncryptedColumns"
include_patt3="GroupLogin"


# Check project directory
if [ ! -d "$project_dir" ]; then
    echo "$project_dir does not exist."
    exit $E_BADDIR
fi


# Grant role with super privilege
cd $project_dir
source $project_dir/src/main/resources/sentry_super_env.sh setup SuperPrivil

# Check sentry flag
source $project_dir/src/main/resources/sentry_flag.sh

# Run sentry test for standard authorization approach
sentry_tcs="ServerAll ServerAlter ServerCreate ServerDrop ServerInsert ServerSelect ServerWrite DBAll DBAlter DBCreate DBDrop DBInsert DBSelect DBWrite TableAll TableAlter TableCreate TableDrop TableInsert TableSelect TableWrite DBAllWithEncryptedColumns DBAllWithEncryptedColumns_2 DBAllWithEncryptedColumns_3 GroupLogin GroupLogin_2 GroupLogin_3"

for tc in $sentry_tcs; do
    # It will be used to set multiple permissions for the same test case
    # e.g. DBAllWithEncryptedColumns, GroupLogin
    export case_name=$tc

    # Define privilege type for proxy user, keytab or proxy user+group
    if echo "$tc" | egrep -qi "$include_patt3"; then
        sentry_sh=sentry_grp_env.sh
    else
        sentry_sh=sentry_env.sh
    fi

    # Grant role with normal privilege
    source $project_dir/src/main/resources/$sentry_sh setup ${tc}

    # Grant user with super privilege
    source $project_dir/src/main/resources/hive_env.sh $privil_type super

    # Execute prepare sql
    echo -e "\n`date +%Y-%m-%d_%H:%M:%S` INFO Running Prepare SQL"
    if echo "$tc" | egrep -qi "$include_patt2"; then
        tc_tmp=`awk -F'_' '{print $1}' <<< $tc`
        $cmd_exec ${encryptColumn_sql_src}/prepare${tc_tmp}.${file_suffix}
    elif echo "$tc" | egrep -qi "$include_patt3"; then
        tc_tmp=`awk -F'_' '{print $1}' <<< $tc`
        $cmd_exec ${groupLogin_sql_src}/prepare${tc_tmp}.${file_suffix}
    else
        $cmd_exec ${common_sql_src}/prepareAll.${file_suffix}
    fi

    # Grant user with group privilege while running in group test
    if echo "$tc" | egrep -qi "'$include_patt3'"; then
        source $project_dir/src/main/resources/hive_env.sh $privil_type_ug normal
    else
        source $project_dir/src/main/resources/hive_env.sh $privil_type normal
    fi

    # Use the same test case to run multiple permissions
    if echo "$tc" | egrep -qi "'$include_patt'"; then
        java -Djava.ext.dirs=${libdir} -Dlog.base=${log_base} -cp ${project_dir}/target/classes:${project_dir}/target/test-classes org.junit.runner.JUnitCore ${tc_tmp}
    else
        java -Djava.ext.dirs=${libdir} -Dlog.base=${log_base} -cp ${project_dir}/target/classes:${project_dir}/target/test-classes org.junit.runner.JUnitCore ${tc}
    fi

    # Grant user with super privilege
    source $project_dir/src/main/resources/hive_env.sh $privil_type super

    # Execute post sql
    echo -e "\n`date +%Y-%m-%d_%H:%M:%S` INFO Running Post SQL"
    if echo "$tc" | egrep -qi "$include_patt2"; then
        tc_tmp=`awk -F'_' '{print $1}' <<< $tc`
        $cmd_exec ${encryptColumn_sql_src}/post${tc_tmp}.${file_suffix}
    elif echo "$tc" | egrep -qi "$include_patt3"; then
        tc_tmp=`awk -F'_' '{print $1}' <<< $tc`
        $cmd_exec ${groupLogin_sql_src}/post${tc_tmp}.${file_suffix}
    else
        $cmd_exec ${common_sql_src}/postAll.${file_suffix}
    fi


    # In proxy env, we need to unset proxy env otherwise it will throw exception
    if [[ "$privil_type" =~ $proxy_regex ]] || [[ ${tc/${include_patt3}/} != ${tc} ]]; then
        source $project_dir/src/main/resources/hive_env.sh clean_proxy_user hive
    fi

    # Revoke role with normal privilege
    source $project_dir/src/main/resources/$sentry_sh clean ${tc}
done

# Revoke role with super privilege
source $project_dir/src/main/resources/sentry_super_env.sh clean SuperPrivil
