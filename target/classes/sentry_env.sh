#!/bin/bash
#filename: sentry_env.sh
#
#The script will define all sentryShell environment variable that it needs
#

# Define param and env
ARGS=2
BAD_PARAMS=65
NOMATCH=126
NOPRI=61
LOGIN_USER=hive
DB_NAME=testdb

export HADOOP_HOME=/opt/meituan/hadoop
export SENTRY_HOME=/opt/meituan/sentry
source /opt/meituan/hadoop/bin/hadoop_user_login.sh $LOGIN_USER


# Check CLI parameter
[ $# -ne $ARGS ] && echo "Usage: `basename $BASH_SOURCE` (setup|clean|check) (privilege)" && exit $BAD_PARAMS

# Select the corresponding privilege
declare -A sentry_privileges

##============
# It will be used to setup and clean privilege with highest privilege
sentry_privileges[SuperPrivil]="server=server1->action=all,server=server1->db=encrypt_db4tbl->table=tbl4show->column=encrypt_column->action=all"

# The following will be used to setup and clean and check privilege for each object
sentry_privileges[ServerAll]="server=server1->action=all"
sentry_privileges[ServerAlter]="server=server1->action=alter"
sentry_privileges[ServerCreate]="server=server1->action=create"
sentry_privileges[ServerDrop]="server=server1->db=db4create->action=drop,server=server1->db=db4drop->action=drop,server=server1->db=db4drop_cascade->action=drop"
sentry_privileges[ServerInsert]="server=server1->action=insert"
sentry_privileges[ServerSelect]="server=server1->action=select"

sentry_privileges[DBAll]="server=server1->db=db4create->action=all,server=server1->db=db4drop->action=all,server=server1->db=db4drop_cascade->action=all,server=server1->db=db4tbl->action=all,server=server1->db=db4alter->action=all,server=server1->db=test_db->action=all"
sentry_privileges[DBCreate]="server=server1->db=db4create->action=create,server=server1->db=db4show->action=create"
sentry_privileges[DBAlter]="server=server1->db=db4create->action=alter,server=server1->db=db4drop->action=alter,server=server1->db=default->action=alter"
sentry_privileges[DBSelect]="server=server1->db=db4tbl->action=select,server=server1->db=db4create->action=select,server=server1->db=db4alter->action=select,server=server1->db=db4drop_cascade->action=select,server=server1->db=db4drop->action=select,server=server1->db=testdb->action=select"
sentry_privileges[DBInsert]="server=server1->db=db4alter->action=insert,server=server1->db=db4alter2->action=insert,server=server1->db=db4load->action=insert,server=server1->db=db4overwrite->action=insert,server=server1->db=db4query->action=insert,server=server1->db=db4func->action=insert,server=server1->db=db4addfile->action=insert,server=server1->db=testdb->action=insert,server=server1->db=db4show->action=insert"

sentry_privileges[TableAll]="server=server1->db=testdb->table=tbl4drop->action=all,server=server1->db=testdb->table=view4drop->action=all,server=server1->db=testdb->table=tbl4alter->action=all,server=server1->db=testdb->table=log_messages->action=all,server=server1->db=testdb->table=log_messages_external->action=all,server=server1->db=testdb->table=log_messages2->action=all,server=server1->db=testdb->table=log_messages2_external->action=all,server=server1->db=testdb->table=supply->action=all,server=server1->db=testdb->table=collecttest->action=all,server=server1->db=testdb->table=session_test->action=all,server=server1->db=testdb->table=sessionization_step_one_origins->action=all,server=server1->db=testdb->table=partition_table001->action=all,server=server1->db=testdb->table=partition_table002->action=all,server=server1->db=testdb->table=table001->action=all,server=server1->db=testdb->table=table002->action=all,server=server1->db=testdb->table=teacher->action=all,server=server1->db=testdb->table=whoyouare->action=all,server=server1->db=testdb->table=test_serde->action=all,server=server1->db=testdb->table=test_partition_serde->action=all,server=server1->db=testdb->table=test_enable_disable->action=all,server=server1->db=testdb->table=test_enable_disable1->action=all,server=server1->db=testdb->table=test_enable_disable2->action=all,server=server1->db=testdb->table=employees->action=all,server=server1->db=testdb->table=employees02->action=all,server=server1->db=testdb->table=staged_employees->action=all,server=server1->db=testdb->table=staged_employees02->action=all,server=server1->db=testdb->table=employees_props->action=all,server=server1->db=testdb->table=test_msck->action=all,server=server1->db=testdb2create->table=testtbl->action=all,,server=server1->db=db4drop_cascade->table=tbl4drop->action=all"
#sentry_privileges[TableAll]="server=server1->db=testdb->table=tbl4drop->action=all
#,server=server1->db=testdb->table=view4drop->action=all
#,server=server1->db=testdb->table=tbl4alter->action=all
#,server=server1->db=testdb->table=log_messages->action=all
#,server=server1->db=testdb->table=log_messages_external->action=all
#,server=server1->db=testdb->table=log_messages2->action=all
#,server=server1->db=testdb->table=log_messages2_external->action=all
#,server=server1->db=testdb->table=supply->action=all
#,server=server1->db=testdb->table=collecttest->action=all
#,server=server1->db=testdb->table=session_test->action=all
#,server=server1->db=testdb->table=sessionization_step_one_origins->action=all
#,server=server1->db=testdb->table=partition_table001->action=all
#,server=server1->db=testdb->table=partition_table002->action=all
#,server=server1->db=testdb->table=table001->action=all
#,server=server1->db=testdb->table=table002->action=all
#,server=server1->db=testdb->table=teacher->action=all
#,server=server1->db=testdb->table=whoyouare->action=all
#,server=server1->db=testdb->table=test_serde->action=all
#,server=server1->db=testdb->table=test_partition_serde->action=all
#,server=server1->db=testdb->table=test_enable_disable->action=all
#,server=server1->db=testdb->table=test_enable_disable1->action=all
#,server=server1->db=testdb->table=test_enable_disable2->action=all
#,server=server1->db=testdb->table=employees->action=all
#,server=server1->db=testdb->table=employees02->action=all
#,server=server1->db=testdb->table=staged_employees->action=all
#,server=server1->db=testdb->table=staged_employees02->action=all
#,server=server1->db=testdb->table=employees_props->action=all
#,server=server1->db=testdb->table=test_msck->action=all
#,server=server1->db=testdb2create->table=testtbl->action=all"

#,server=server1->db=db4drop_cascade->table=tbl4drop->action=all"


sentry_privileges[TableAlter]="server=server1->db=testdb->table=tbl4drop->action=alter,server=server1->db=testdb->table=view4drop->action=alter,server=server1->db=testdb->table=tbl4alter->action=alter,server=server1->db=testdb->table=log_messages->action=alter,server=server1->db=testdb->table=log_messages_external->action=alter,server=server1->db=testdb->table=log_messages2->action=alter,server=server1->db=testdb->table=log_messages2_external->action=alter,server=server1->db=testdb->table=supply->action=alter,server=server1->db=testdb->table=collecttest->action=alter,server=server1->db=testdb->table=session_test->action=alter,server=server1->db=testdb->table=sessionization_step_one_origins->action=alter,server=server1->db=testdb->table=partition_table001->action=alter,server=server1->db=testdb->table=partition_table002->action=alter,server=server1->db=testdb->table=table001->action=alter,server=server1->db=testdb->table=table002->action=alter,server=server1->db=testdb->table=teacher->action=alter,server=server1->db=testdb->table=whoyouare->action=alter,server=server1->db=testdb->table=test_serde->action=alter,server=server1->db=testdb->table=test_partition_serde->action=alter,server=server1->db=testdb->table=test_enable_disable->action=alter,server=server1->db=testdb->table=test_enable_disable1->action=alter,server=server1->db=testdb->table=test_enable_disable2->action=alter,server=server1->db=testdb->table=employees->action=alter,server=server1->db=testdb->table=employees02->action=alter,server=server1->db=testdb->table=staged_employees->action=alter,server=server1->db=testdb->table=staged_employees02->action=alter,server=server1->db=testdb->table=employees_props->action=alter,server=server1->db=testdb->table=test_msck->action=alter,server=server1->db=testdb2create->table=testtbl->action=alter,server=server1->db=db4drop_cascade->table=tbl4drop->action=alter"

#sentry_privileges[TableAlter]="server=server1->db=testdb->table=tbl4drop->action=alter
#,server=server1->db=testdb->table=view4drop->action=alter
#,server=server1->db=testdb->table=tbl4alter->action=alter
#,server=server1->db=testdb->table=log_messages->action=alter
#,server=server1->db=testdb->table=log_messages_external->action=alter
#,server=server1->db=testdb->table=log_messages2->action=alter
#,server=server1->db=testdb->table=log_messages2_external->action=alter
#,server=server1->db=testdb->table=supply->action=alter
#,server=server1->db=testdb->table=collecttest->action=alter
#,server=server1->db=testdb->table=session_test->action=alter
#,server=server1->db=testdb->table=sessionization_step_one_origins->action=alter
#,server=server1->db=testdb->table=partition_table001->action=alter
#,server=server1->db=testdb->table=partition_table002->action=alter
#,server=server1->db=testdb->table=table001->action=alter
#,server=server1->db=testdb->table=table002->action=alter
#,server=server1->db=testdb->table=teacher->action=alter
#,server=server1->db=testdb->table=whoyouare->action=alter
#,server=server1->db=testdb->table=test_serde->action=alter
#,server=server1->db=testdb->table=test_partition_serde->action=alter
#,server=server1->db=testdb->table=test_enable_disable->action=alter
#,server=server1->db=testdb->table=test_enable_disable1->action=alter
#,server=server1->db=testdb->table=test_enable_disable2->action=alter
#,server=server1->db=testdb->table=employees->action=alter
#,server=server1->db=testdb->table=employees02->action=alter
#,server=server1->db=testdb->table=staged_employees->action=alter
#,server=server1->db=testdb->table=staged_employees02->action=alter
#,server=server1->db=testdb->table=employees_props->action=alter
#,server=server1->db=testdb->table=test_msck->action=alter
#,server=server1->db=testdb2create->table=testtbl->action=alter"

#,server=server1->db=db4drop_cascade->table=tbl4drop->action=alter"
#

sentry_privileges[TableCreate]="server=server1->db=testdb->table=tbl4drop->action=create,server=server1->db=testdb->table=view4drop->action=create,server=server1->db=testdb->table=tbl4alter->action=create,server=server1->db=testdb->table=log_messages->action=create,server=server1->db=testdb->table=log_messages_external->action=create,server=server1->db=testdb->table=log_messages2->action=create,server=server1->db=testdb->table=log_messages2_external->action=create,server=server1->db=testdb->table=supply->action=create,server=server1->db=testdb->table=collecttest->action=create,server=server1->db=testdb->table=session_test->action=create,server=server1->db=testdb->table=sessionization_step_one_origins->action=create,server=server1->db=testdb->table=partition_table001->action=create,server=server1->db=testdb->table=partition_table002->action=create,server=server1->db=testdb->table=table001->action=create,server=server1->db=testdb->table=table002->action=create,server=server1->db=testdb->table=teacher->action=create,server=server1->db=testdb->table=whoyouare->action=create,server=server1->db=testdb->table=test_serde->action=create,server=server1->db=testdb->table=test_partition_serde->action=create,server=server1->db=testdb->table=test_enable_disable->action=create,server=server1->db=testdb->table=test_enable_disable1->action=create,server=server1->db=testdb->table=test_enable_disable2->action=create,server=server1->db=testdb->table=employees->action=create,server=server1->db=testdb->table=employees02->action=create,server=server1->db=testdb->table=staged_employees->action=create,server=server1->db=testdb->table=staged_employees02->action=create,server=server1->db=testdb->table=employees_props->action=create,server=server1->db=testdb->table=test_msck->action=create,server=server1->db=testdb2create->table=testtbl->action=create,server=server1->db=db4drop_cascade->table=tbl4drop->action=create"

#sentry_privileges[TableCreate]="server=server1->db=testdb->table=tbl4drop->action=create
#,server=server1->db=testdb->table=view4drop->action=create
#,server=server1->db=testdb->table=tbl4alter->action=create
#,server=server1->db=testdb->table=log_messages->action=create
#,server=server1->db=testdb->table=log_messages_external->action=create
#,server=server1->db=testdb->table=log_messages2->action=create
#,server=server1->db=testdb->table=log_messages2_external->action=create
#,server=server1->db=testdb->table=supply->action=create
#,server=server1->db=testdb->table=collecttest->action=create
#,server=server1->db=testdb->table=session_test->action=create
#,server=server1->db=testdb->table=sessionization_step_one_origins->action=create
#,server=server1->db=testdb->table=partition_table001->action=create
#,server=server1->db=testdb->table=partition_table002->action=create
#,server=server1->db=testdb->table=table001->action=create
#,server=server1->db=testdb->table=table002->action=create
#,server=server1->db=testdb->table=teacher->action=create
#,server=server1->db=testdb->table=whoyouare->action=create
#,server=server1->db=testdb->table=test_serde->action=create
#,server=server1->db=testdb->table=test_partition_serde->action=create
#,server=server1->db=testdb->table=test_enable_disable->action=create
#,server=server1->db=testdb->table=test_enable_disable1->action=create
#,server=server1->db=testdb->table=test_enable_disable2->action=create
#,server=server1->db=testdb->table=employees->action=create
#,server=server1->db=testdb->table=employees02->action=create
#,server=server1->db=testdb->table=staged_employees->action=create
#,server=server1->db=testdb->table=staged_employees02->action=create
#,server=server1->db=testdb->table=employees_props->action=create
#,server=server1->db=testdb->table=test_msck->action=create
#,server=server1->db=testdb2create->table=testtbl->action=create"

#,server=server1->db=db4drop_cascade->table=tbl4drop->action=create"
#

sentry_privileges[TableSelect]="server=server1->db=testdb->table=tbl4drop->action=select,server=server1->db=testdb->table=view4drop->action=select,server=server1->db=testdb->table=tbl4alter->action=select,server=server1->db=testdb->table=log_messages->action=select,server=server1->db=testdb->table=log_messages_external->action=select,server=server1->db=testdb->table=log_messages2->action=select,server=server1->db=testdb->table=log_messages2_external->action=select,server=server1->db=testdb->table=supply->action=select,server=server1->db=testdb->table=collecttest->action=select,server=server1->db=testdb->table=session_test->action=select,server=server1->db=testdb->table=sessionization_step_one_origins->action=select,server=server1->db=testdb->table=partition_table001->action=select,server=server1->db=testdb->table=partition_table002->action=select,server=server1->db=testdb->table=table001->action=select,server=server1->db=testdb->table=table002->action=select,server=server1->db=testdb->table=teacher->action=select,server=server1->db=testdb->table=whoyouare->action=select,server=server1->db=testdb->table=test_serde->action=select,server=server1->db=testdb->table=test_partition_serde->action=select,server=server1->db=testdb->table=test_enable_disable->action=select,server=server1->db=testdb->table=test_enable_disable1->action=select,server=server1->db=testdb->table=test_enable_disable2->action=select,server=server1->db=testdb->table=employees->action=select,server=server1->db=testdb->table=employees02->action=select,server=server1->db=testdb->table=staged_employees->action=select,server=server1->db=testdb->table=staged_employees02->action=select,server=server1->db=testdb->table=employees_props->action=select,server=server1->db=testdb->table=test_msck->action=select,server=server1->db=testdb2create->table=testtbl->action=select,server=server1->db=db4drop_cascade->table=tbl4drop->action=select,server=server1->db=testdb->table=employees022->action=select,server=server1->db=testdb->table=tbl4create_external->action=select"

#sentry_privileges[TableSelect]="server=server1->db=testdb->table=tbl4drop->action=select
#,server=server1->db=testdb->table=view4drop->action=select
#,server=server1->db=testdb->table=tbl4alter->action=select
#,server=server1->db=testdb->table=log_messages->action=select
#,server=server1->db=testdb->table=log_messages_external->action=select
#,server=server1->db=testdb->table=log_messages2->action=select
#,server=server1->db=testdb->table=log_messages2_external->action=select
#,server=server1->db=testdb->table=supply->action=select
#,server=server1->db=testdb->table=collecttest->action=select
#,server=server1->db=testdb->table=session_test->action=select
#,server=server1->db=testdb->table=sessionization_step_one_origins->action=select
#,server=server1->db=testdb->table=partition_table001->action=select
#,server=server1->db=testdb->table=partition_table002->action=select
#,server=server1->db=testdb->table=table001->action=select
#,server=server1->db=testdb->table=table002->action=select
#,server=server1->db=testdb->table=teacher->action=select
#,server=server1->db=testdb->table=whoyouare->action=select
#,server=server1->db=testdb->table=test_serde->action=select
#,server=server1->db=testdb->table=test_partition_serde->action=select
#,server=server1->db=testdb->table=test_enable_disable->action=select
#,server=server1->db=testdb->table=test_enable_disable1->action=select
#,server=server1->db=testdb->table=test_enable_disable2->action=select
#,server=server1->db=testdb->table=employees->action=select
#,server=server1->db=testdb->table=employees02->action=select
#,server=server1->db=testdb->table=staged_employees->action=select
#,server=server1->db=testdb->table=staged_employees02->action=select
#,server=server1->db=testdb->table=employees_props->action=select
#,server=server1->db=testdb->table=test_msck->action=select
#,server=server1->db=testdb2create->table=testtbl->action=select"

#,server=server1->db=db4drop_cascade->table=tbl4drop->action=select"

#,server=server1->db=testdb->table=tbl4create_external->action=select"



#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=tbl4drop->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=view4drop->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=tbl4alter->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=log_messages->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=log_messages_external->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=log_messages2->action=select'
#
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=log_messages2_external->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=supply->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=collecttest->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=session_test->action=select'
#
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=sessionization_step_one_origins->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=partition_table001->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=partition_table002->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=table001->action=select'
#
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=table002->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=teacher->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=whoyouare->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=test_serde->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=test_partition_serde->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=test_enable_disable->action=select'
#
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=test_enable_disable1->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=test_enable_disable2->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=employees->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=employees02->action=select'
#
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=staged_employees->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=staged_employees02->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=employees_props->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=test_msck->action=select'
#
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb2create->table=testtbl->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=db4drop_cascade->table=tbl4drop->action=select'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege '
#
#
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege '

sentry_privileges[TableInsert]="server=server1->db=testdb->table=tbl4drop->action=insert,server=server1->db=testdb->table=view4drop->action=insert,server=server1->db=testdb->table=tbl4alter->action=insert,server=server1->db=testdb->table=log_messages->action=insert,server=server1->db=testdb->table=log_messages_external->action=insert,server=server1->db=testdb->table=log_messages2->action=insert,server=server1->db=testdb->table=log_messages2_external->action=insert,server=server1->db=testdb->table=supply->action=insert,server=server1->db=testdb->table=collecttest->action=insert,server=server1->db=testdb->table=session_test->action=insert,server=server1->db=testdb->table=sessionization_step_one_origins->action=insert,server=server1->db=testdb->table=partition_table001->action=insert,server=server1->db=testdb->table=partition_table002->action=insert,server=server1->db=testdb->table=table001->action=insert,server=server1->db=testdb->table=table002->action=insert,server=server1->db=testdb->table=teacher->action=insert,server=server1->db=testdb->table=whoyouare->action=insert,server=server1->db=testdb->table=test_serde->action=insert,server=server1->db=testdb->table=test_partition_serde->action=insert,server=server1->db=testdb->table=test_enable_disable->action=insert,server=server1->db=testdb->table=test_enable_disable1->action=insert,server=server1->db=testdb->table=test_enable_disable2->action=insert,server=server1->db=testdb->table=employees->action=insert,server=server1->db=testdb->table=employees02->action=insert,server=server1->db=testdb->table=staged_employees->action=insert,server=server1->db=testdb->table=staged_employees02->action=insert,server=server1->db=testdb->table=employees_props->action=insert,server=server1->db=testdb->table=test_msck->action=insert,server=server1->db=testdb2create->table=testtbl->action=insert,server=server1->db=db4drop_cascade->table=tbl4drop->action=insert,server=server1->db=testdb->table=tbl4create_external->action=insert"

#sentry_privileges[TableInsert]="server=server1->db=testdb->table=tbl4drop->action=insert
#,server=server1->db=testdb->table=view4drop->action=insert
#,server=server1->db=testdb->table=tbl4alter->action=insert
#,server=server1->db=testdb->table=log_messages->action=insert
#,server=server1->db=testdb->table=log_messages_external->action=insert
#,server=server1->db=testdb->table=log_messages2->action=insert
#,server=server1->db=testdb->table=log_messages2_external->action=insert
#,server=server1->db=testdb->table=supply->action=insert
#,server=server1->db=testdb->table=collecttest->action=insert
#,server=server1->db=testdb->table=session_test->action=insert
#,server=server1->db=testdb->table=sessionization_step_one_origins->action=insert
#,server=server1->db=testdb->table=partition_table001->action=insert
#,server=server1->db=testdb->table=partition_table002->action=insert
#,server=server1->db=testdb->table=table001->action=insert
#,server=server1->db=testdb->table=table002->action=insert
#,server=server1->db=testdb->table=teacher->action=insert
#,server=server1->db=testdb->table=whoyouare->action=insert
#,server=server1->db=testdb->table=test_serde->action=insert
#,server=server1->db=testdb->table=test_partition_serde->action=insert
#,server=server1->db=testdb->table=test_enable_disable->action=insert
#,server=server1->db=testdb->table=test_enable_disable1->action=insert
#,server=server1->db=testdb->table=test_enable_disable2->action=insert
#,server=server1->db=testdb->table=employees->action=insert
#,server=server1->db=testdb->table=employees02->action=insert
#,server=server1->db=testdb->table=staged_employees->action=insert
#,server=server1->db=testdb->table=staged_employees02->action=insert
#,server=server1->db=testdb->table=employees_props->action=insert
#,server=server1->db=testdb->table=test_msck->action=insert
#,server=server1->db=testdb2create->table=testtbl->action=insert"

#,server=server1->db=db4drop_cascade->table=tbl4drop->action=insert"
#,server=server1->db=testdb->table=tbl4create_external->action=insert"
#

#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=tbl4drop->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=view4drop->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=tbl4alter->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=log_messages->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=log_messages_external->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=log_messages2->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=log_messages2_external->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=supply->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=collecttest->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=session_test->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=sessionization_step_one_origins->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=partition_table001->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=partition_table002->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=table001->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=table002->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=teacher->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=whoyouare->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=test_serde->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=test_partition_serde->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=test_enable_disable->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=test_enable_disable1->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=test_enable_disable2->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=employees->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=employees02->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=staged_employees->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=staged_employees02->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=employees_props->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=test_msck->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb2create->table=testtbl->action=insert'
#
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=db4drop_cascade->table=tbl4drop->action=insert'
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb2create->table=test->action=insert'
#
#
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename sentry_qa --privilege 'server=server1->db=testdb->table=tbl4create_external->action=insert'


#,server=server1->db=testdb->table=tbl4create_external->action=insert"


sentry_privileges[TableDrop]="server=server1->db=testdb->table=tbl4drop->action=drop,server=server1->db=testdb->table=view4drop->action=drop,server=server1->db=testdb->table=tbl4alter->action=drop,server=server1->db=testdb->table=log_messages->action=drop,server=server1->db=testdb->table=log_messages_external->action=drop,server=server1->db=testdb->table=log_messages2->action=drop,server=server1->db=testdb->table=log_messages2_external->action=drop,server=server1->db=testdb->table=supply->action=drop,server=server1->db=testdb->table=collecttest->action=drop,server=server1->db=testdb->table=session_test->action=drop,server=server1->db=testdb->table=sessionization_step_one_origins->action=drop,server=server1->db=testdb->table=partition_table001->action=drop,server=server1->db=testdb->table=partition_table002->action=drop,server=server1->db=testdb->table=table001->action=drop,server=server1->db=testdb->table=table002->action=drop,server=server1->db=testdb->table=teacher->action=drop,server=server1->db=testdb->table=whoyouare->action=drop,server=server1->db=testdb->table=test_serde->action=drop,server=server1->db=testdb->table=test_partition_serde->action=drop,server=server1->db=testdb->table=test_enable_disable->action=drop,server=server1->db=testdb->table=test_enable_disable1->action=drop,server=server1->db=testdb->table=test_enable_disable2->action=drop,server=server1->db=testdb->table=employees->action=drop,server=server1->db=testdb->table=employees02->action=drop,server=server1->db=testdb->table=staged_employees->action=drop,server=server1->db=testdb->table=staged_employees02->action=drop,server=server1->db=testdb->table=employees_props->action=drop,server=server1->db=testdb->table=test_msck->action=drop,server=server1->db=testdb2create->table=testtbl->action=drop,server=server1->db=db4drop_cascade->table=tbl4drop->action=drop"

#entry_privileges[TableDrop]="server=server1->db=testdb->table=tbl4drop->action=drop
#,server=server1->db=testdb->table=view4drop->action=drop
#,server=server1->db=testdb->table=tbl4alter->action=drop
#,server=server1->db=testdb->table=log_messages->action=drop
#,server=server1->db=testdb->table=log_messages_external->action=drop
#,server=server1->db=testdb->table=log_messages2->action=drop
#,server=server1->db=testdb->table=log_messages2_external->action=drop
#,server=server1->db=testdb->table=supply->action=drop
#,server=server1->db=testdb->table=collecttest->action=drop
#,server=server1->db=testdb->table=session_test->action=drop
#,server=server1->db=testdb->table=sessionization_step_one_origins->action=drop
#,server=server1->db=testdb->table=partition_table001->action=drop
#,server=server1->db=testdb->table=partition_table002->action=drop
#,server=server1->db=testdb->table=table001->action=drop
#,server=server1->db=testdb->table=table002->action=drop
#,server=server1->db=testdb->table=teacher->action=drop
#,server=server1->db=testdb->table=whoyouare->action=drop
#,server=server1->db=testdb->table=test_serde->action=drop
#,server=server1->db=testdb->table=test_partition_serde->action=drop
#,server=server1->db=testdb->table=test_enable_disable->action=drop
#,server=server1->db=testdb->table=test_enable_disable1->action=drop
#,server=server1->db=testdb->table=test_enable_disable2->action=drop
#,server=server1->db=testdb->table=employees->action=drop
#,server=server1->db=testdb->table=employees02->action=drop
#,server=server1->db=testdb->table=staged_employees->action=drop
#,server=server1->db=testdb->table=staged_employees02->action=drop
#,server=server1->db=testdb->table=employees_props->action=drop
#,server=server1->db=testdb->table=test_msck->action=drop
#,server=server1->db=testdb2create->table=testtbl->action=drop"

#,server=server1->db=db4drop_cascade->table=tbl4drop->action=drop"

#sentry_privileges[TableAlter]="server=server1->db=testdb->table=test_tble->action=all,server=server1->db=testdb->table=tbl4drop->action=all,server=server1->db=testdb->table=view4drop->action=all,server=server1->db=testdb->table=tbl4alter->action=all,server=server1->db=testdb->table=log_messages->action=all,server=server1->db=testdb->table=log_messages_external->action=all,server=server1->db=testdb->table=supply->action=all,server=server1->db=testdb->table=collecttest->action=all,server=server1->db=testdb->table=session_test->action=all,server=server1->db=testdb->table=sessionization_step_one_origins->action=all,server=server1->db=testdb->table=partition_table001->action=all,server=server1->db=testdb->table=partition_table002->action=all,server=server1->db=testdb->table=table001->action=all,server=server1->db=testdb->table=table002->action=all,server=server1->db=testdb->table=teacher1->action=all,server=server1->db=testdb->table=teacher2->action=all,server=server1->db=testdb->table=whoyouare->action=all,server=server1->db=testdb->table=test_serde->action=all,server=server1->db=testdb->table=test_partition_serde->action=all,server=server1->db=testdb->table=employees_props->action=all,server=server1->db=testdb->table=test_enable_disable->action=all,server=server1->db=testdb->table=test_enable_disable1->action=all,server=server1->db=testdb->table=test_enable_disable2->action=all,server=server1->db=testdb->table=employees->action=all,server=server1->db=testdb->table=staged_employees->action=all,server=server1->db=testdb->table=test_msck->action=all"
#sentry_privileges[TableCreate]="server=server1->db=testdb->table=test_tble->action=all,server=server1->db=testdb->table=tbl4drop->action=all,server=server1->db=testdb->table=view4drop->action=all,server=server1->db=testdb->table=tbl4alter->action=all,server=server1->db=testdb->table=log_messages->action=all,server=server1->db=testdb->table=log_messages_external->action=all,server=server1->db=testdb->table=supply->action=all,server=server1->db=testdb->table=collecttest->action=all,server=server1->db=testdb->table=session_test->action=all,server=server1->db=testdb->table=sessionization_step_one_origins->action=all,server=server1->db=testdb->table=partition_table001->action=all,server=server1->db=testdb->table=partition_table002->action=all,server=server1->db=testdb->table=table001->action=all,server=server1->db=testdb->table=table002->action=all,server=server1->db=testdb->table=teacher1->action=all,server=server1->db=testdb->table=teacher2->action=all,server=server1->db=testdb->table=whoyouare->action=all,server=server1->db=testdb->table=test_serde->action=all,server=server1->db=testdb->table=test_partition_serde->action=all,server=server1->db=testdb->table=employees_props->action=all,server=server1->db=testdb->table=test_enable_disable->action=all,server=server1->db=testdb->table=test_enable_disable1->action=all,server=server1->db=testdb->table=test_enable_disable2->action=all,server=server1->db=testdb->table=employees->action=all,server=server1->db=testdb->table=staged_employees->action=all,server=server1->db=testdb->table=test_msck->action=all"
#sentry_privileges[TableDrop]="server=server1->db=testdb->table=test_tble->action=all,server=server1->db=testdb->table=tbl4drop->action=all,server=server1->db=testdb->table=view4drop->action=all,server=server1->db=testdb->table=tbl4alter->action=all,server=server1->db=testdb->table=log_messages->action=all,server=server1->db=testdb->table=log_messages_external->action=all,server=server1->db=testdb->table=supply->action=all,server=server1->db=testdb->table=collecttest->action=all,server=server1->db=testdb->table=session_test->action=all,server=server1->db=testdb->table=sessionization_step_one_origins->action=all,server=server1->db=testdb->table=partition_table001->action=all,server=server1->db=testdb->table=partition_table002->action=all,server=server1->db=testdb->table=table001->action=all,server=server1->db=testdb->table=table002->action=all,server=server1->db=testdb->table=teacher1->action=all,server=server1->db=testdb->table=teacher2->action=all,server=server1->db=testdb->table=whoyouare->action=all,server=server1->db=testdb->table=test_serde->action=all,server=server1->db=testdb->table=test_partition_serde->action=all,server=server1->db=testdb->table=employees_props->action=all,server=server1->db=testdb->table=test_enable_disable->action=all,server=server1->db=testdb->table=test_enable_disable1->action=all,server=server1->db=testdb->table=test_enable_disable2->action=all,server=server1->db=testdb->table=employees->action=all,server=server1->db=testdb->table=staged_employees->action=all,server=server1->db=testdb->table=test_msck->action=all"
#sentry_privileges[TableInsert]="server=server1->db=testdb->table=test_tble->action=all,server=server1->db=testdb->table=tbl4drop->action=all,server=server1->db=testdb->table=view4drop->action=all,server=server1->db=testdb->table=tbl4alter->action=all,server=server1->db=testdb->table=log_messages->action=all,server=server1->db=testdb->table=log_messages_external->action=all,server=server1->db=testdb->table=supply->action=all,server=server1->db=testdb->table=collecttest->action=all,server=server1->db=testdb->table=session_test->action=all,server=server1->db=testdb->table=sessionization_step_one_origins->action=all,server=server1->db=testdb->table=partition_table001->action=all,server=server1->db=testdb->table=partition_table002->action=all,server=server1->db=testdb->table=table001->action=all,server=server1->db=testdb->table=table002->action=all,server=server1->db=testdb->table=teacher1->action=all,server=server1->db=testdb->table=teacher2->action=all,server=server1->db=testdb->table=whoyouare->action=all,server=server1->db=testdb->table=test_serde->action=all,server=server1->db=testdb->table=test_partition_serde->action=all,server=server1->db=testdb->table=employees_props->action=all,server=server1->db=testdb->table=test_enable_disable->action=all,server=server1->db=testdb->table=test_enable_disable1->action=all,server=server1->db=testdb->table=test_enable_disable2->action=all,server=server1->db=testdb->table=employees->action=all,server=server1->db=testdb->table=staged_employees->action=all,server=server1->db=testdb->table=test_msck->action=all"
#sentry_privileges[TableSelect]="server=server1->db=testdb->table=test_tble->action=all,server=server1->db=testdb->table=tbl4drop->action=all,server=server1->db=testdb->table=view4drop->action=all,server=server1->db=testdb->table=tbl4alter->action=all,server=server1->db=testdb->table=log_messages->action=all,server=server1->db=testdb->table=log_messages_external->action=all,server=server1->db=testdb->table=supply->action=all,server=server1->db=testdb->table=collecttest->action=all,server=server1->db=testdb->table=session_test->action=all,server=server1->db=testdb->table=sessionization_step_one_origins->action=all,server=server1->db=testdb->table=partition_table001->action=all,server=server1->db=testdb->table=partition_table002->action=all,server=server1->db=testdb->table=table001->action=all,server=server1->db=testdb->table=table002->action=all,server=server1->db=testdb->table=teacher1->action=all,server=server1->db=testdb->table=teacher2->action=all,server=server1->db=testdb->table=whoyouare->action=all,server=server1->db=testdb->table=test_serde->action=all,server=server1->db=testdb->table=test_partition_serde->action=all,server=server1->db=testdb->table=employees_props->action=all,server=server1->db=testdb->table=test_enable_disable->action=all,server=server1->db=testdb->table=test_enable_disable1->action=all,server=server1->db=testdb->table=test_enable_disable2->action=all,server=server1->db=testdb->table=employees->action=all,server=server1->db=testdb->table=staged_employees->action=all,server=server1->db=testdb->table=test_msck->action=all"

sentry_privileges[ColumnAll]="server=server1->db=db4create->action=all,server=server1->db=db4drop->action=all,server=server1->db=db4drop_cascade->action=all,server=server1->db=db4alter->action=all,server=server1->db=testdb->action=all,server=server1->db=db4tbl->action=all"
##============

##============For Encrypt column, they need to be done separately
encrypt_ini=/opt/meituan/sentry/conf/external.ini

DBAllWithEncryptedColumns1(){
cat <<- EOF >> $encrypt_ini
[encrypted_table]
encrypt_db4data.test_serde=c0,c1,c2
encrypt_db4alter.log_messages=hms,severity,server,process_id,message
encrypt_db4msck.test_msck=id,val
encrypt_db4data.staged_employees=name,salary,subordinates,deductions,address
encrypt_db4data.staged_employees02=name,salary,subordinates,deductions,address
encrypt_db4data.employees02=name,salary,subordinates,deductions,address
encrypt_db4props.employees_props=name,salary,subordinates,deductions,address
encrypt_db4data.testbuiltinfuncs=col1,col2,col3
EOF
}

#No permission for column
sentry_privileges[DBAllWithEncryptedColumns]="server=server1->db=encrypt_db4drop_cascade->action=all,server=server1->db=encrypt_db4tbl->action=all,server=server1->db=encrypt_db4data->action=all,server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4data->action=all,server=server1->db=encrypt_db4func->action=all,server=server1->db=encrypt_db4data->action=all,server=server1->db=encrypt_db4data->action=all,server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4msck->action=all,server=server1->db=encrypt_db4props->action=all"
#All permission for column
sentry_privileges[DBAllWithEncryptedColumns_2]="server=server1->db=encrypt_db4drop_cascade->action=all,server=server1->db=encrypt_db4drop_cascade->table=encrypt_tbl1->column=encrypt_column->action=all,server=server1->db=encrypt_db4drop_cascade->table=encrypt_tbl2->column=encrypt_column1->action=all,server=server1->db=encrypt_db4drop_cascade->table=encrypt_tbl2->column=encrypt_column2->action=all,server=server1->db=encrypt_db4tbl->action=all,server=server1->db=encrypt_db4tbl->table=tbl4show->column=encrypt_column->action=all,server=server1->db=encrypt_db4tbl->table=tbl2serde->column=c0->action=all,server=server1->db=encrypt_db4tbl->table=tbl2serde->column=c1->action=all,server=server1->db=encrypt_db4tbl->table=tbl2serde->column=c2->action=all,server=server1->db=encrypt_db4data->action=all,server=server1->db=encrypt_db4data->table=test_serde->column=c0->action=all,server=server1->db=encrypt_db4data->table=test_serde->column=c1->action=all,server=server1->db=encrypt_db4data->table=test_serde->column=c2->action=all,server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4alter->table=tbl4alter->column=encrypt_col1->action=all,server=server1->db=encrypt_db4alter->table=tbl4alter->column=encrypt_col2->action=all,server=server1->db=encrypt_db4alter->table=tbl4alter->column=encrypt_col3->action=all,server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=hms->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=severity->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=server->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=process_id->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=message->action=all,server=server1->db=encrypt_db4alter->table=log_messages_external->column=hms->action=all,server=server1->db=encrypt_db4alter->table=log_messages_external->column=severity->action=all,server=server1->db=encrypt_db4alter->table=log_messages_external->column=server->action=all,server=server1->db=encrypt_db4alter->table=log_messages_external->column=process_id->action=all,server=server1->db=encrypt_db4alter->table=log_messages_external->column=message->action=all,server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4alter->table=supply->column=id->action=all,server=server1->db=encrypt_db4alter->table=supply->column=part->action=all,server=server1->db=encrypt_db4alter->table=supply->column=quantity->action=all,server=server1->db=encrypt_db4alter->table=supply->column=day->action=all,server=server1->db=encrypt_db4data->table=supply->column=str->action=all,server=server1->db=encrypt_db4data->table=supply->column=countVal->action=all,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=st_user_id->action=all,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=st_pageview_id->action=all,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=st_page_url->action=all,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=st_referrer_url->action=all,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=st_timestamp->action=all,server=server1->db=encrypt_db4data->table=sessionization_step_one_origins_tgt_encrypted->column=ssoo_user_id->action=all,server=server1->db=encrypt_db4data->table=sessionization_step_one_origins_tgt_encrypted->column=ssoo_pageview_id->action=all,server=server1->db=encrypt_db4data->table=sessionization_step_one_origins_tgt_encrypted->column=ssoo_timestamp->action=all,server=server1->db=encrypt_db4data->table=partition_table_src->column=name->action=all,server=server1->db=encrypt_db4data->table=partition_table_src->column=ip->action=all,server=server1->db=encrypt_db4data->table=partition_table_tgt->column=name->action=all,server=server1->db=encrypt_db4data->table=partition_table_tgt->column=ip->action=all,server=server1->db=encrypt_db4data->table=table_src->column=name->action=all,server=server1->db=encrypt_db4data->table=table_src->column=ip->action=all,server=server1->db=encrypt_db4data->table=table_tgt->column=name->action=all,server=server1->db=encrypt_db4data->table=table_tgt->column=ip->action=all,server=server1->db=encrypt_db4data->table=whoyouare->column=who->action=all,server=server1->db=encrypt_db4func->action=all,server=server1->db=encrypt_db4func->table=teacher->column=name->action=all,server=server1->db=encrypt_db4data->action=all,server=server1->db=encrypt_db4data->table=test_serde->column=c0->action=all,server=server1->db=encrypt_db4data->table=test_serde->column=c1->action=all,server=server1->db=encrypt_db4data->table=test_serde->column=c2->action=all,server=server1->db=encrypt_db4data->table=testbuiltinfuncs->column=col1->action=all,server=server1->db=encrypt_db4data->table=testbuiltinfuncs->column=col2->action=all,server=server1->db=encrypt_db4data->table=testbuiltinfuncs->column=col3->action=all,server=server1->db=encrypt_db4data->table=staged_employees->column=name->action=all,server=server1->db=encrypt_db4data->table=staged_employees->column=salary->action=all,server=server1->db=encrypt_db4data->table=staged_employees->column=subordinates->action=all,server=server1->db=encrypt_db4data->table=staged_employees->column=deductions->action=all,server=server1->db=encrypt_db4data->table=staged_employees->column=address->action=all,server=server1->db=encrypt_db4data->table=staged_employees02->column=name->action=all,server=server1->db=encrypt_db4data->table=staged_employees02->column=salary->action=all,server=server1->db=encrypt_db4data->table=staged_employees02->column=subordinates->action=all,server=server1->db=encrypt_db4data->table=staged_employees02->column=deductions->action=all,server=server1->db=encrypt_db4data->table=staged_employees02->column=address->action=all,server=server1->db=encrypt_db4data->table=employees02->column=name->action=all,server=server1->db=encrypt_db4data->table=employees02->column=salary->action=all,server=server1->db=encrypt_db4data->table=employees02->column=subordinates->action=all,server=server1->db=encrypt_db4data->table=employees02->column=deductions->action=all,server=server1->db=encrypt_db4data->table=employees02->column=address->action=all,server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=hms->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=severity->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=server->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=process_id->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=message->action=all,server=server1->db=encrypt_db4msck->action=all,server=server1->db=encrypt_db4msck->table=test_msck->column=id->action=all,server=server1->db=encrypt_db4msck->table=test_msck->column=val->action=all,server=server1->db=encrypt_db4props->action=all,server=server1->db=encrypt_db4props->table=employees_props->column=name->action=all,server=server1->db=encrypt_db4props->table=employees_props->column=salary->action=all,server=server1->db=encrypt_db4props->table=employees_props->column=subordinates->action=all,server=server1->db=encrypt_db4props->table=employees_props->column=deductions->action=all,server=server1->db=encrypt_db4props->table=employees_props->column=address->action=all"
#select permission for column
sentry_privileges[DBAllWithEncryptedColumns_3]="server=server1->db=encrypt_db4drop_cascade->action=all,server=server1->db=encrypt_db4drop_cascade->table=encrypt_tbl1->column=encrypt_column->action=select,server=server1->db=encrypt_db4drop_cascade->table=encrypt_tbl2->column=encrypt_column1->action=select,server=server1->db=encrypt_db4drop_cascade->table=encrypt_tbl2->column=encrypt_column2->action=select,server=server1->db=encrypt_db4tbl->action=all,server=server1->db=encrypt_db4tbl->table=tbl4show->column=encrypt_column->action=select,server=server1->db=encrypt_db4tbl->table=tbl2serde->column=c0->action=select,server=server1->db=encrypt_db4tbl->table=tbl2serde->column=c1->action=select,server=server1->db=encrypt_db4tbl->table=tbl2serde->column=c2->action=select,server=server1->db=encrypt_db4data->action=all,server=server1->db=encrypt_db4data->table=test_serde->column=c0->action=select,server=server1->db=encrypt_db4data->table=test_serde->column=c1->action=select,server=server1->db=encrypt_db4data->table=test_serde->column=c2->action=select,server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4alter->table=tbl4alter->column=encrypt_col1->action=select,server=server1->db=encrypt_db4alter->table=tbl4alter->column=encrypt_col2->action=select,server=server1->db=encrypt_db4alter->table=tbl4alter->column=encrypt_col3->action=select,server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=hms->action=select,server=server1->db=encrypt_db4alter->table=log_messages->column=severity->action=select,server=server1->db=encrypt_db4alter->table=log_messages->column=server->action=select,server=server1->db=encrypt_db4alter->table=log_messages->column=process_id->action=select,server=server1->db=encrypt_db4alter->table=log_messages->column=message->action=select,server=server1->db=encrypt_db4alter->table=log_messages_external->column=hms->action=select,server=server1->db=encrypt_db4alter->table=log_messages_external->column=severity->action=select,server=server1->db=encrypt_db4alter->table=log_messages_external->column=server->action=select,server=server1->db=encrypt_db4alter->table=log_messages_external->column=process_id->action=select,server=server1->db=encrypt_db4alter->table=log_messages_external->column=message->action=select,server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4alter->table=supply->column=id->action=select,server=server1->db=encrypt_db4alter->table=supply->column=part->action=select,server=server1->db=encrypt_db4alter->table=supply->column=quantity->action=select,server=server1->db=encrypt_db4alter->table=supply->column=day->action=select,server=server1->db=encrypt_db4data->action=all,server=server1->db=encrypt_db4data->table=supply->column=str->action=select,server=server1->db=encrypt_db4data->table=supply->column=countVal->action=select,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=st_user_id->action=select,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=st_pageview_id->action=select,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=st_page_url->action=select,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=st_referrer_url->action=select,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=st_timestamp->action=select,server=server1->db=encrypt_db4data->table=sessionization_step_one_origins_tgt_encrypted->column=ssoo_user_id->action=select,server=server1->db=encrypt_db4data->table=sessionization_step_one_origins_tgt_encrypted->column=ssoo_pageview_id->action=select,server=server1->db=encrypt_db4data->table=sessionization_step_one_origins_tgt_encrypted->column=ssoo_timestamp->action=select,server=server1->db=encrypt_db4data->table=partition_table_src->column=name->action=select,server=server1->db=encrypt_db4data->table=partition_table_src->column=ip->action=select,server=server1->db=encrypt_db4data->table=partition_table_tgt->column=name->action=select,server=server1->db=encrypt_db4data->table=partition_table_tgt->column=ip->action=select,server=server1->db=encrypt_db4data->table=table_src->column=name->action=select,server=server1->db=encrypt_db4data->table=table_src->column=ip->action=select,server=server1->db=encrypt_db4data->table=table_tgt->column=name->action=select,server=server1->db=encrypt_db4data->table=table_tgt->column=ip->action=select,server=server1->db=encrypt_db4data->table=whoyouare->column=who->action=select,server=server1->db=encrypt_db4func->action=all,server=server1->db=encrypt_db4func->table=teacher->column=name->action=select,server=server1->db=encrypt_db4data->action=all,server=server1->db=encrypt_db4data->table=test_serde->column=c0->action=select,server=server1->db=encrypt_db4data->table=test_serde->column=c1->action=select,server=server1->db=encrypt_db4data->table=test_serde->column=c2->action=select,server=server1->db=encrypt_db4data->table=testbuiltinfuncs->column=col1->action=select,server=server1->db=encrypt_db4data->table=testbuiltinfuncs->column=col2->action=select,server=server1->db=encrypt_db4data->table=testbuiltinfuncs->column=col3->action=select,server=server1->db=encrypt_db4data->table=staged_employees->column=name->action=select,server=server1->db=encrypt_db4data->table=staged_employees->column=salary->action=select,server=server1->db=encrypt_db4data->table=staged_employees->column=subordinates->action=select,server=server1->db=encrypt_db4data->table=staged_employees->column=deductions->action=select,server=server1->db=encrypt_db4data->table=staged_employees->column=address->action=select,server=server1->db=encrypt_db4data->table=staged_employees02->column=salary->action=select,server=server1->db=encrypt_db4data->table=staged_employees02->column=subordinates->action=select,server=server1->db=encrypt_db4data->table=staged_employees02->column=deductions->action=select,server=server1->db=encrypt_db4data->table=staged_employees02->column=address->action=select,server=server1->db=encrypt_db4data->table=employees02->column=name->action=select,server=server1->db=encrypt_db4data->table=employees02->column=salary->action=select,server=server1->db=encrypt_db4data->table=employees02->column=subordinates->action=select,server=server1->db=encrypt_db4data->table=employees02->column=deductions->action=select,server=server1->db=encrypt_db4data->table=employees02->column=address->action=select,server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=hms->action=select,server=server1->db=encrypt_db4alter->table=log_messages->column=severity->action=select,server=server1->db=encrypt_db4alter->table=log_messages->column=server->action=select,server=server1->db=encrypt_db4alter->table=log_messages->column=process_id->action=select,server=server1->db=encrypt_db4alter->table=log_messages->column=message->action=select,server=server1->db=encrypt_db4msck->action=all,server=server1->db=encrypt_db4msck->table=test_msck->column=id->action=select,server=server1->db=encrypt_db4msck->table=test_msck->column=val->action=select,server=server1->db=encrypt_db4props->action=all,server=server1->db=encrypt_db4props->table=employees_props->column=name->action=select,server=server1->db=encrypt_db4props->table=employees_props->column=salary->action=select,server=server1->db=encrypt_db4props->table=employees_props->column=subordinates->action=select,server=server1->db=encrypt_db4props->table=employees_props->column=deductions->action=select,server=server1->db=encrypt_db4props->table=employees_props->column=address->action=select"
##============

# Super Privilege
if [[ "$2" == "SuperPrivil" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[SuperPrivil]}"`

# Server Privilege
elif [[ "$2" == "ServerAll" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerAll]}"`
elif [[ "$2" == "ServerCreate" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerCreate]}"`
elif [[ "$2" == "ServerAlter" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerAlter]}"`
elif [[ "$2" == "ServerDrop" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerDrop]}"`
elif [[ "$2" == "ServerInsert" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerInsert]}"`
elif [[ "$2" == "ServerSelect" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerSelect]}"`

# DB Privilege
elif [[ "$2" == "DBAll" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBAll]}"`
elif [[ "$2" == "DBCreate" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBCreate]}"`
elif [[ "$2" == "DBSelect" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBSelect]}"`
elif [[ "$2" == "DBAlter" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBAlter]}"`
elif [[ "$2" == "DBInsert" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBInsert]}"`
elif [[ "$2" == "DBDrop" ]]; then

# DB Privilege
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBDrop]}"`
elif [[ "$2" == "TableAll" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableAll]}"`
elif [[ "$2" == "TableAlter" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableAlter]}"`
elif [[ "$2" == "TableCreate" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableCreate]}"`
elif [[ "$2" == "TableDrop" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableDrop]}"`
elif [[ "$2" == "TableInsert" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableInsert]}"`
elif [[ "$2" == "TableSelect" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableSelect]}"`

# Column Privilege
elif [[ "$2" == "ColumnAll" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ColumnAll]}"`
elif [[ "$2" == "DBAllWithEncryptedColumns" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBAllWithEncryptedColumns]}"`
elif [[ "$2" == "List" ]]; then # For show privilege to specify $2 with List
    : ${privilege:="placeholder"}
else
    echo "Please specify valid sentry privilege"
    exit $NOPRI
fi


# set role name and role group for specify privilege
if [[ "$2" == "SuperPrivil" ]]; then
    ROLE_NAME=mt_qa
    ROLE_GROUP=mt_qa
else
    ROLE_NAME=hdp_qa
    ROLE_GROUP=hdp_qa
fi


case "$1" in
    "setup")
        # Add role, group and privilege
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --create_role -r $ROLE_NAME
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --add_role_group -r $ROLE_NAME -g $ROLE_GROUP

        for privil in $privileges; do
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --grant_privilege_role --rolename $ROLE_NAME --privilege "$privil"
        done
        ;;
    "clean")
        # Remove role, group and privilege
        for privil in $privileges; do
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --revoke_privilege_role -r $ROLE_NAME -p "$privil"
        done

        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --delete_role_group -r $ROLE_NAME -g $ROLE_GROUP
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --drop_role -r $ROLE_NAME
        ;;
    "check")
        # Check role, group and privilege
        # Too many roles and temporary comment the line.
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -g $ROLE_GROUP
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $ROLE_NAME
        ;;
    * )
    echo "Please specify valid action"
    exit $NOMATCH;;
esac
