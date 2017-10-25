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


##============
# set the corresponding privilege
declare -A sentry_privileges

# It will be used to check sentry flag value with true or false
sentry_privileges[SentryFlagTable]="server=server1->db=testdb->table=test_sentry_flag->action=select"
sentry_privileges[SentryFlagDB]="server=server1->db=testdb->action=select"

# Super privilege
sentry_privileges[SuperPrivil]="server=server1->action=all,server=server1->db=encrypt_db4tbl->table=tbl4show->column=encrypt_column->action=all,server=server1->db=origindb->table=waimai_order_shard__wm->column=common_ext->action=select"

# Server Privilege
sentry_privileges[ServerAll]="server=server1->action=all"
sentry_privileges[ServerAlter]="server=server1->action=alter"
sentry_privileges[ServerCreate]="server=server1->action=create"
sentry_privileges[ServerDrop]="server=server1->action=drop,server=server1->db=db4create->action=drop,server=server1->db=db4drop->action=drop,server=server1->db=db4drop_cascade->action=drop"
sentry_privileges[ServerInsert]="server=server1->action=insert"
sentry_privileges[ServerSelect]="server=server1->action=select"
sentry_privileges[ServerWrite]="server=server1->action=alter,server=server1->action=create,server=server1->action=insert"

# DB Privilege
sentry_privileges[DBAll]="server=server1->db=db4create->action=all,server=server1->db=db4drop->action=all,server=server1->db=db4drop_cascade->action=all,server=server1->db=db4tbl->action=all,server=server1->db=db4alter->action=all,server=server1->db=testdb->action=all"
sentry_privileges[DBCreate]="server=server1->db=db4create->action=create,server=server1->db=db4show->action=create"
sentry_privileges[DBAlter]="server=server1->db=db4create->action=alter,server=server1->db=db4drop->action=alter,server=server1->db=default->action=alter"
sentry_privileges[DBSelect]="server=server1->db=db4tbl->action=select,server=server1->db=db4create->action=select,server=server1->db=db4alter->action=select,server=server1->db=db4drop_cascade->action=select,server=server1->db=db4drop->action=select,server=server1->db=testdb->action=select"
sentry_privileges[DBInsert]="server=server1->db=db4tbl->action=insert,server=server1->db=db4alter->action=insert,server=server1->db=db4alter2->action=insert,server=server1->db=db4load->action=insert,server=server1->db=db4overwrite->action=insert,server=server1->db=db4query->action=insert,server=server1->db=db4func->action=insert,server=server1->db=db4addfile->action=insert,server=server1->db=testdb->action=insert,server=server1->db=db4show->action=insert"
sentry_privileges[DBWrite]="server=server1->db=db4create->action=create,server=server1->db=db4drop->action=create,server=server1->db=db4drop_cascade->action=create,server=server1->db=db4tbl->action=create,server=server1->db=db4alter->action=create,server=server1->db=testdb->action=create,server=server1->db=db4create->action=alter,server=server1->db=db4drop->action=alter,server=server1->db=db4drop_cascade->action=alter,server=server1->db=db4tbl->action=alter,server=server1->db=db4alter->action=alter,server=server1->db=testdb->action=alter,server=server1->db=db4create->action=insert,server=server1->db=db4drop->action=insert,server=server1->db=db4drop_cascade->action=insert,server=server1->db=db4tbl->action=insert,server=server1->db=db4alter->action=insert,server=server1->db=testdb->action=insert"

# Table Privilege
sentry_privileges[TableWrite]="server=server1->db=testdb->table=tbl4drop->action=alter,server=server1->db=testdb->table=view4drop->action=alter,server=server1->db=testdb->table=tbl4alter->action=alter,server=server1->db=testdb->table=log_messages->action=alter,server=server1->db=testdb->table=log_messages_external->action=alter,server=server1->db=testdb->table=log_messages2->action=alter,server=server1->db=testdb->table=log_messages2_external->action=alter,server=server1->db=testdb->table=supply->action=alter,server=server1->db=testdb->table=collecttest->action=alter,server=server1->db=testdb->table=session_test->action=alter,server=server1->db=testdb->table=sessionization_step_one_origins->action=alter,server=server1->db=testdb->table=partition_table001->action=alter,server=server1->db=testdb->table=partition_table002->action=alter,server=server1->db=testdb->table=table001->action=alter,server=server1->db=testdb->table=table002->action=alter,server=server1->db=testdb->table=teacher->action=alter,server=server1->db=testdb->table=whoyouare->action=alter,server=server1->db=testdb->table=test_serde->action=alter,server=server1->db=testdb->table=test_partition_serde->action=alter,server=server1->db=testdb->table=test_enable_disable->action=alter,server=server1->db=testdb->table=test_enable_disable1->action=alter,server=server1->db=testdb->table=test_enable_disable2->action=aler,server=server1->db=testdb->table=employees->action=alter,server=server1->db=testdb->table=employees02->action=alter,server=server1->db=testdb->table=staged_employees->action=alter,server=server1->db=testdb->table=staged_employees02->action=alter,server=server1->db=testdb->table=employees_props->action=alter,server=server1->db=testdb->table=test_msck->action=alter,server=server1->db=testdb2create->table=testtbl->action=alter,server=server1->db=db4drop_cascade->table=tbl4drop->action=alter,server=server1->db=testdb->table=tbl4drop->action=create,server=server1->db=testdb->table=view4drop->action=create,server=server1->db=testdb->table=tbl4alter->action=create,server=server1->db=testdb->table=log_messages->action=create,server=server1->db=testdb->table=log_messages_external->action=create,server=server1->db=testdb->table=log_messages2->action=create,server=server1->db=testdb->table=log_messages2_external->action=create,server=server1->db=testdb->table=supply->action=create,server=server1->db=testdb->table=collecttest->action=create,server=server1->db=testdb->table=session_test->action=create,server=server1->db=testdb->table=sessionization_step_one_origins->action=create,server=server1->db=testdb->table=partition_table001->action=create,server=server1->db=testdb->table=partition_table002->action=create,server=server1->db=testdb->table=table001->action=create,server=server1->db=testdb->table=table002->action=create,server=server1->db=testdb->table=teacher->action=create,server=server1->db=testdb->table=whoyouare->action=create,server=server1->db=testdb->table=test_serde->action=create,server=server1->db=testdb->table=test_partition_serde->action=create,server=server1->db=testdb->table=test_enable_disable->action=create,server=server1->db=testdb->table=test_enable_disable1->action=create,server=server1->db=testdb->table=test_enable_disable2->action=create,server=server1->db=testdb->table=employees->action=create,server=server1->db=testdb->table=employees02->action=create,server=server1->db=testdb->table=staged_employees->action=create,server=server1->db=testdb->table=staged_employees02->action=create,server=server1->db=testdb->table=employees_props->action=create,server=server1->db=testdb->table=test_msck->action=create,server=server1->db=testdb2create->table=testtbl->action=create,server=server1->db=db4drop_cascade->table=tbl4drop->action=create,server=server1->db=testdb->table=tbl4drop->action=insert,server=server1->db=testdb->table=view4drop->action=insert,server=server1->db=testdb->table=tbl4alter->action=insert,server=server1->db=testdb->table=log_messages->action=insert,server=server1->db=testdb->table=log_messages_external->action=insert,server=server1->db=testdb->table=log_messages2->action=insert,server=server1->db=testdb->table=log_messages2_external->action=insert,server=server1->db=testdb->table=supply->action=insert,server=server1->db=testdb->table=collecttest->action=insert,server=server1->db=testdb->table=session_test->action=insert,server=server1->db=testdb->table=sessionization_step_one_origins->action=insert,server=server1->db=testdb->table=partition_table001->action=insert,server=server1->db=testdb->table=partition_table002->action=insert,server=server1->db=testdb->table=table001->action=insert,server=server1->db=testdb->table=table002->action=insert,server=server1->db=testdb->table=teacher->action=insert,server=server1->db=testdb->table=whoyouare->action=insert,server=server1->db=testdb->table=test_serde->action=insert,server=server1->db=testdb->table=test_partition_serde->action=insert,server=server1->db=testdb->table=test_enable_disable->action=insert,server=server1->db=testdb->table=test_enable_disable1->action=insert,server=server1->db=testdb->table=test_enable_disable2->action=insert,server=server1->db=testdb->table=employees->action=insert,server=server1->db=testdb->table=employees02->action=insert,server=server1->db=testdb->table=staged_employees->action=insert,server=server1->db=testdb->table=staged_employees02->action=insert,server=server1->db=testdb->table=employees_props->action=insert,server=server1->db=testdb->table=test_msck->action=insert,server=server1->db=testdb2create->table=testtbl->action=insert,server=server1->db=db4drop_cascade->table=tbl4drop->action=insert"

sentry_privileges[TableAll]="server=server1->db=testdb->table=tbl4drop->action=all,server=server1->db=testdb->table=view4drop->action=all,server=server1->db=testdb->table=tbl4alter->action=all,server=server1->db=testdb->table=log_messages->action=all,server=server1->db=testdb->table=log_messages_external->action=all,server=server1->db=testdb->table=log_messages2->action=all,server=server1->db=testdb->table=log_messages2_external->action=all,server=server1->db=testdb->table=supply->action=all,server=server1->db=testdb->table=collecttest->action=all,server=server1->db=testdb->table=session_test->action=all,server=server1->db=testdb->table=sessionization_step_one_origins->action=all,server=server1->db=testdb->table=partition_table001->action=all,server=server1->db=testdb->table=partition_table002->action=all,server=server1->db=testdb->table=table001->action=all,server=server1->db=testdb->table=table002->action=all,server=server1->db=testdb->table=teacher->action=all,server=server1->db=testdb->table=whoyouare->action=all,server=server1->db=testdb->table=test_serde->action=all,server=server1->db=testdb->table=test_partition_serde->action=all,server=server1->db=testdb->table=test_enable_disable->action=all,server=server1->db=testdb->table=test_enable_disable1->action=all,server=server1->db=testdb->table=test_enable_disable2->action=all,server=server1->db=testdb->table=employees->action=all,server=server1->db=testdb->table=employees02->action=all,server=server1->db=testdb->table=staged_employees->action=all,server=server1->db=testdb->table=staged_employees02->action=all,server=server1->db=testdb->table=employees_props->action=all,server=server1->db=testdb->table=test_msck->action=all,server=server1->db=testdb2create->table=testtbl->action=all,,server=server1->db=db4drop_cascade->table=tbl4drop->action=all"

sentry_privileges[TableAlter]="server=server1->db=testdb->table=tbl4drop->action=alter,server=server1->db=testdb->table=view4drop->action=alter,server=server1->db=testdb->table=tbl4alter->action=alter,server=server1->db=testdb->table=log_messages->action=alter,server=server1->db=testdb->table=log_messages_external->action=alter,server=server1->db=testdb->table=log_messages2->action=alter,server=server1->db=testdb->table=log_messages2_external->action=alter,server=server1->db=testdb->table=supply->action=alter,server=server1->db=testdb->table=collecttest->action=alter,server=server1->db=testdb->table=session_test->action=alter,server=server1->db=testdb->table=sessionization_step_one_origins->action=alter,server=server1->db=testdb->table=partition_table001->action=alter,server=server1->db=testdb->table=partition_table002->action=alter,server=server1->db=testdb->table=table001->action=alter,server=server1->db=testdb->table=table002->action=alter,server=server1->db=testdb->table=teacher->action=alter,server=server1->db=testdb->table=whoyouare->action=alter,server=server1->db=testdb->table=test_serde->action=alter,server=server1->db=testdb->table=test_partition_serde->action=alter,server=server1->db=testdb->table=test_enable_disable->action=alter,server=server1->db=testdb->table=test_enable_disable1->action=alter,server=server1->db=testdb->table=test_enable_disable2->action=alter,server=server1->db=testdb->table=employees->action=alter,server=server1->db=testdb->table=employees02->action=alter,server=server1->db=testdb->table=staged_employees->action=alter,server=server1->db=testdb->table=staged_employees02->action=alter,server=server1->db=testdb->table=employees_props->action=alter,server=server1->db=testdb->table=test_msck->action=alter,server=server1->db=testdb2create->table=testtbl->action=alter,server=server1->db=db4drop_cascade->table=tbl4drop->action=alter"

sentry_privileges[TableCreate]="server=server1->db=testdb->table=tbl4drop->action=create,server=server1->db=testdb->table=view4drop->action=create,server=server1->db=testdb->table=tbl4alter->action=create,server=server1->db=testdb->table=log_messages->action=create,server=server1->db=testdb->table=log_messages_external->action=create,server=server1->db=testdb->table=log_messages2->action=create,server=server1->db=testdb->table=log_messages2_external->action=create,server=server1->db=testdb->table=supply->action=create,server=server1->db=testdb->table=collecttest->action=create,server=server1->db=testdb->table=session_test->action=create,server=server1->db=testdb->table=sessionization_step_one_origins->action=create,server=server1->db=testdb->table=partition_table001->action=create,server=server1->db=testdb->table=partition_table002->action=create,server=server1->db=testdb->table=table001->action=create,server=server1->db=testdb->table=table002->action=create,server=server1->db=testdb->table=teacher->action=create,server=server1->db=testdb->table=whoyouare->action=create,server=server1->db=testdb->table=test_serde->action=create,server=server1->db=testdb->table=test_partition_serde->action=create,server=server1->db=testdb->table=test_enable_disable->action=create,server=server1->db=testdb->table=test_enable_disable1->action=create,server=server1->db=testdb->table=test_enable_disable2->action=create,server=server1->db=testdb->table=employees->action=create,server=server1->db=testdb->table=employees02->action=create,server=server1->db=testdb->table=staged_employees->action=create,server=server1->db=testdb->table=staged_employees02->action=create,server=server1->db=testdb->table=employees_props->action=create,server=server1->db=testdb->table=test_msck->action=create,server=server1->db=testdb2create->table=testtbl->action=create,server=server1->db=db4drop_cascade->table=tbl4drop->action=create"

sentry_privileges[TableSelect]="server=server1->db=testdb->table=tbl4drop->action=select,server=server1->db=testdb->table=view4drop->action=select,server=server1->db=testdb->table=tbl4alter->action=select,server=server1->db=testdb->table=log_messages->action=select,server=server1->db=testdb->table=log_messages_external->action=select,server=server1->db=testdb->table=log_messages2->action=select,server=server1->db=testdb->table=log_messages2_external->action=select,server=server1->db=testdb->table=supply->action=select,server=server1->db=testdb->table=collecttest->action=select,server=server1->db=testdb->table=session_test->action=select,server=server1->db=testdb->table=sessionization_step_one_origins->action=select,server=server1->db=testdb->table=partition_table001->action=select,server=server1->db=testdb->table=partition_table002->action=select,server=server1->db=testdb->table=table001->action=select,server=server1->db=testdb->table=table002->action=select,server=server1->db=testdb->table=teacher->action=select,server=server1->db=testdb->table=whoyouare->action=select,server=server1->db=testdb->table=test_serde->action=select,server=server1->db=testdb->table=test_partition_serde->action=select,server=server1->db=testdb->table=test_enable_disable->action=select,server=server1->db=testdb->table=test_enable_disable1->action=select,server=server1->db=testdb->table=test_enable_disable2->action=select,server=server1->db=testdb->table=employees->action=select,server=server1->db=testdb->table=employees02->action=select,server=server1->db=testdb->table=staged_employees->action=select,server=server1->db=testdb->table=staged_employees02->action=select,server=server1->db=testdb->table=employees_props->action=select,server=server1->db=testdb->table=test_msck->action=select,server=server1->db=testdb2create->table=testtbl->action=select,server=server1->db=db4drop_cascade->table=tbl4drop->action=select,server=server1->db=testdb->table=employees022->action=select,server=server1->db=testdb->table=tbl4create_external->action=select"


sentry_privileges[TableInsert]="server=server1->db=testdb->table=tbl4drop->action=insert,server=server1->db=testdb->table=view4drop->action=insert,server=server1->db=testdb->table=tbl4alter->action=insert,server=server1->db=testdb->table=log_messages->action=insert,server=server1->db=testdb->table=log_messages_external->action=insert,server=server1->db=testdb->table=log_messages2->action=insert,server=server1->db=testdb->table=log_messages2_external->action=insert,server=server1->db=testdb->table=supply->action=insert,server=server1->db=testdb->table=collecttest->action=insert,server=server1->db=testdb->table=session_test->action=insert,server=server1->db=testdb->table=sessionization_step_one_origins->action=insert,server=server1->db=testdb->table=partition_table001->action=insert,server=server1->db=testdb->table=partition_table002->action=insert,server=server1->db=testdb->table=table001->action=insert,server=server1->db=testdb->table=table002->action=insert,server=server1->db=testdb->table=teacher->action=insert,server=server1->db=testdb->table=whoyouare->action=insert,server=server1->db=testdb->table=test_serde->action=insert,server=server1->db=testdb->table=test_partition_serde->action=insert,server=server1->db=testdb->table=test_enable_disable->action=insert,server=server1->db=testdb->table=test_enable_disable1->action=insert,server=server1->db=testdb->table=test_enable_disable2->action=insert,server=server1->db=testdb->table=employees->action=insert,server=server1->db=testdb->table=employees02->action=insert,server=server1->db=testdb->table=staged_employees->action=insert,server=server1->db=testdb->table=staged_employees02->action=insert,server=server1->db=testdb->table=employees_props->action=insert,server=server1->db=testdb->table=test_msck->action=insert,server=server1->db=testdb2create->table=testtbl->action=insert,server=server1->db=db4drop_cascade->table=tbl4drop->action=insert,server=server1->db=testdb->table=tbl4create_external->action=insert"

sentry_privileges[TableDrop]="server=server1->db=testdb->table=tbl4drop->action=drop,server=server1->db=testdb->table=view4drop->action=drop,server=server1->db=testdb->table=tbl4alter->action=drop,server=server1->db=testdb->table=log_messages->action=drop,server=server1->db=testdb->table=log_messages_external->action=drop,server=server1->db=testdb->table=log_messages2->action=drop,server=server1->db=testdb->table=log_messages2_external->action=drop,server=server1->db=testdb->table=supply->action=drop,server=server1->db=testdb->table=collecttest->action=drop,server=server1->db=testdb->table=session_test->action=drop,server=server1->db=testdb->table=sessionization_step_one_origins->action=drop,server=server1->db=testdb->table=partition_table001->action=drop,server=server1->db=testdb->table=partition_table002->action=drop,server=server1->db=testdb->table=table001->action=drop,server=server1->db=testdb->table=table002->action=drop,server=server1->db=testdb->table=teacher->action=drop,server=server1->db=testdb->table=whoyouare->action=drop,server=server1->db=testdb->table=test_serde->action=drop,server=server1->db=testdb->table=test_partition_serde->action=drop,server=server1->db=testdb->table=test_enable_disable->action=drop,server=server1->db=testdb->table=test_enable_disable1->action=drop,server=server1->db=testdb->table=test_enable_disable2->action=drop,server=server1->db=testdb->table=employees->action=drop,server=server1->db=testdb->table=employees02->action=drop,server=server1->db=testdb->table=staged_employees->action=drop,server=server1->db=testdb->table=staged_employees02->action=drop,server=server1->db=testdb->table=employees_props->action=drop,server=server1->db=testdb->table=test_msck->action=drop,server=server1->db=testdb2create->table=testtbl->action=drop,server=server1->db=db4drop_cascade->table=tbl4drop->action=drop"

##==Encrypted Columns Privilege
#No permission for column
sentry_privileges[DBAllWithEncryptedColumns]="server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4data->action=all,server=server1->db=encrypt_db4drop_cascade->action=all,server=server1->db=encrypt_db4msck->action=all,server=server1->db=encrypt_db4func->action=all,server=server1->db=encrypt_db4props->action=all,server=server1->db=encrypt_db4tbl->action=all"

#All permission for column
sentry_privileges[DBAllWithEncryptedColumns_2]="server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4alter->table=test_partition->column=encrypt_id->action=all,server=server1->db=encrypt_db4alter->table=test_partition->column=encrypt_part->action=all,server=server1->db=encrypt_db4alter->table=test_partition->column=encrypt_quantity->action=all,server=server1->db=encrypt_db4alter->table=test_enable_disable_partition->column=encrypt_hms->action=all,server=server1->db=encrypt_db4alter->table=test_enable_disable_partition->column=encrypt_severity->action=all,server=server1->db=encrypt_db4alter->table=test_enable_disable_partition->column=encrypt_server->action=all,server=server1->db=encrypt_db4alter->table=test_enable_disable_partition->column=encrypt_process_id->action=all,server=server1->db=encrypt_db4alter->table=test_enable_disable_partition->column=encrypt_message->action=all,server=server1->db=encrypt_db4alter->table=tbl4addcolumn->column=encrypt_col1->action=all,server=server1->db=encrypt_db4alter->table=tbl4addcolumn->column=encrypt_col2->action=all,server=server1->db=encrypt_db4alter->table=tbl4addcolumn->column=encrypt_col3->action=all,server=server1->db=encrypt_db4alter->table=tbl4change->column=encrypt_col1->action=all,server=server1->db=encrypt_db4alter->table=tbl4change->column=encrypt_col2->action=all,server=server1->db=encrypt_db4alter->table=tbl4change->column=encrypt_col3->action=all,server=server1->db=encrypt_db4alter->table=test_enable_disable->column=encrypt_hms->action=all,server=server1->db=encrypt_db4alter->table=test_enable_disable->column=encrypt_severity->action=all,server=server1->db=encrypt_db4alter->table=test_enable_disable->column=encrypt_server->action=all,server=server1->db=encrypt_db4alter->table=test_enable_disable->column=encrypt_process_id->action=all,server=server1->db=encrypt_db4alter->table=test_enable_disable->column=encrypt_message->action=all,server=server1->db=encrypt_db4alter->table=tbl4rename->column=encrypt_col1->action=all,server=server1->db=encrypt_db4alter->table=tbl4rename->column=encrypt_col2->action=all,server=server1->db=encrypt_db4alter->table=tbl4rename->column=encrypt_col3->action=all,server=server1->db=encrypt_db4alter->table=tbl4replace->column=encrypt_col1->action=all,server=server1->db=encrypt_db4alter->table=tbl4replace->column=encrypt_col2->action=all,server=server1->db=encrypt_db4alter->table=tbl4replace->column=encrypt_col3->action=all,server=server1->db=encrypt_db4alter->table=tbl4fileformat->column=encrypt_hms->action=all,server=server1->db=encrypt_db4alter->table=tbl4fileformat->column=encrypt_severity->action=all,server=server1->db=encrypt_db4alter->table=tbl4fileformat->column=encrypt_server->action=all,server=server1->db=encrypt_db4alter->table=tbl4fileformat->column=encrypt_process_id->action=all,server=server1->db=encrypt_db4alter->table=tbl4fileformat->column=encrypt_message->action=all,server=server1->db=encrypt_db4alter->table=tbl4fileformat_external->column=encrypt_hms->action=all,server=server1->db=encrypt_db4alter->table=tbl4fileformat_external->column=encrypt_severity->action=all,server=server1->db=encrypt_db4alter->table=tbl4fileformat_external->column=encrypt_server->action=all,server=server1->db=encrypt_db4alter->table=tbl4fileformat_external->column=encrypt_process_id->action=all,server=server1->db=encrypt_db4alter->table=tbl4fileformat_external->column=encrypt_message->action=all,server=server1->db=encrypt_db4alter->table=tbl4descformatted->column=encrypt_hms->action=all,server=server1->db=encrypt_db4alter->table=tbl4descformatted->column=encrypt_severity->action=all,server=server1->db=encrypt_db4alter->table=tbl4descformatted->column=encrypt_server->action=all,server=server1->db=encrypt_db4alter->table=tbl4descformatted->column=encrypt_process_id->action=all,server=server1->db=encrypt_db4alter->table=tbl4descformatted->column=encrypt_message->action=all,server=server1->db=encrypt_db4data->action=all,server=server1->db=encrypt_db4data->table=test_serde_partition->column=encrypt_c0->action=all,server=server1->db=encrypt_db4data->table=test_serde_partition->column=encrypt_c1->action=all,server=server1->db=encrypt_db4data->table=test_serde_partition->column=encrypt_c2->action=all,server=server1->db=encrypt_db4data->table=test_serde->column=encrypt_c0->action=all,server=server1->db=encrypt_db4data->table=test_serde->column=encrypt_c1->action=all,server=server1->db=encrypt_db4data->table=test_serde->column=encrypt_c2->action=all,server=server1->db=encrypt_db4data->table=test_clusteredby->column=encrypt_name->action=all,server=server1->db=encrypt_db4data->table=test_clusteredby->column=encrypt_salary->action=all,server=server1->db=encrypt_db4data->table=test_clusteredby->column=encrypt_subordinates->action=all,server=server1->db=encrypt_db4data->table=test_clusteredby->column=encrypt_deductions->action=all,server=server1->db=encrypt_db4data->table=test_clusteredby->column=encrypt_address->action=all,server=server1->db=encrypt_db4data->table=encrypt_test_analyze->column=encrypt_name->action=all,server=server1->db=encrypt_db4data->table=encrypt_test_analyze->column=encrypt_salary->action=all,server=server1->db=encrypt_db4data->table=encrypt_test_analyze->column=encrypt_subordinates->action=all,server=server1->db=encrypt_db4data->table=encrypt_test_analyze->column=encrypt_deductions->action=all,server=server1->db=encrypt_db4data->table=encrypt_test_analyze->column=encrypt_address->action=all,server=server1->db=encrypt_db4data->table=tbl4builtinfuncs->column=encrypt_col1->action=all,server=server1->db=encrypt_db4data->table=tbl4builtinfuncs->column=encrypt_col2->action=all,server=server1->db=encrypt_db4data->table=tbl4builtinfuncs->column=encrypt_col3->action=all,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=encrypt_user_id->action=all,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=encrypt_pageview_id->action=all,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=encrypt_page_url->action=all,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=encrypt_referrer_url->action=all,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=encrypt_timestamp->action=all,server=server1->db=encrypt_db4data->table=sessionization_step_one_origins_tgt_encrypted->column=encrypt_ssoo_user_id->action=all,server=server1->db=encrypt_db4data->table=sessionization_step_one_origins_tgt_encrypted->column=encrypt_ssoo_pageview_id->action=all,server=server1->db=encrypt_db4data->table=sessionization_step_one_origins_tgt_encrypted->column=encrypt_ssoo_timestamp->action=all,server=server1->db=encrypt_db4data->table=encrypt_import_export->column=encrypt_name->action=all,server=server1->db=encrypt_db4data->table=encrypt_import_export->column=encrypt_salary->action=all,server=server1->db=encrypt_db4data->table=encrypt_import_export->column=encrypt_subordinates->action=all,server=server1->db=encrypt_db4data->table=encrypt_import_export->column=encrypt_deductions->action=all,server=server1->db=encrypt_db4data->table=encrypt_import_export->column=encrypt_address->action=all,server=server1->db=encrypt_db4data->table=encrypt_tgt_import_export->column=encrypt_name->action=all,server=server1->db=encrypt_db4data->table=encrypt_tgt_import_export->column=encrypt_salary->action=all,server=server1->db=encrypt_db4data->table=encrypt_tgt_import_export->column=encrypt_subordinates->action=all,server=server1->db=encrypt_db4data->table=encrypt_tgt_import_export->column=encrypt_deductions->action=all,server=server1->db=encrypt_db4data->table=encrypt_tgt_import_export->column=encrypt_address->action=all,server=server1->db=encrypt_db4data->table=encrypt_employees->column=encrypt_name->action=all,server=server1->db=encrypt_db4data->table=encrypt_employees->column=encrypt_salary->action=all,server=server1->db=encrypt_db4data->table=encrypt_employees->column=encrypt_subordinates->action=all,server=server1->db=encrypt_db4data->table=encrypt_employees->column=encrypt_deductions->action=all,server=server1->db=encrypt_db4data->table=encrypt_employees->column=encrypt_address->action=all,server=server1->db=encrypt_db4data->table=encrypt_tgt_employees->column=encrypt_name->action=all,server=server1->db=encrypt_db4data->table=encrypt_tgt_employees->column=encrypt_salary->action=all,server=server1->db=encrypt_db4data->table=encrypt_tgt_employees->column=encrypt_subordinates->action=all,server=server1->db=encrypt_db4data->table=encrypt_tgt_employees->column=encrypt_deductions->action=all,server=server1->db=encrypt_db4data->table=encrypt_tgt_employees->column=encrypt_address->action=all,server=server1->db=encrypt_db4data->table=partition_table_src->column=name->action=all,server=server1->db=encrypt_db4data->table=partition_table_src->column=ip->action=all,server=server1->db=encrypt_db4data->table=partition_table_tgt->column=name->action=all,server=server1->db=encrypt_db4data->table=partition_table_tgt->column=ip->action=all,server=server1->db=encrypt_db4data->table=table_src->column=name->action=all,server=server1->db=encrypt_db4data->table=table_src->column=ip->action=all,server=server1->db=encrypt_db4data->table=table_tgt->column=name->action=all,server=server1->db=encrypt_db4data->table=table_tgt->column=ip->action=all,server=server1->db=encrypt_db4data->table=collecttest->column=str->action=all,server=server1->db=encrypt_db4data->table=whoyouare->column=who->action=all,server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=hms->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=severity->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=server->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=process_id->action=all,server=server1->db=encrypt_db4alter->table=log_messages->column=message->action=all,server=server1->db=encrypt_db4tbl->action=all,server=server1->db=encrypt_db4tbl->table=tbl4view->column=encrypt_c0->action=all,server=server1->db=encrypt_db4tbl->table=tbl4view->column=encrypt_c1->action=all,server=server1->db=encrypt_db4tbl->table=tbl4view->column=encrypt_c2->action=all,server=server1->db=encrypt_db4drop_cascade->action=all,server=server1->db=encrypt_db4drop_cascade->table=encrypt_tbl4drop->column=encrypt_id->action=all,server=server1->db=encrypt_db4drop_cascade->table=encrypt_tbl4drop->column=encrypt_val->action=all,server=server1->db=encrypt_db4msck->action=all,server=server1->db=encrypt_db4msck->table=test_msck->column=encrypt_id->action=all,server=server1->db=encrypt_db4msck->table=test_msck->column=encrypt_val->action=all,server=server1->db=encrypt_db4props->action=all,server=server1->db=encrypt_db4props->table=employees_props->column=encrypt_name->action=all,server=server1->db=encrypt_db4props->table=employees_props->column=encrypt_salary->action=all,server=server1->db=encrypt_db4props->table=employees_props->column=encrypt_subordinates->action=all,server=server1->db=encrypt_db4props->table=employees_props->column=encrypt_deductions->action=all,server=server1->db=encrypt_db4props->table=employees_props->column=encrypt_address->action=all,server=server1->db=encrypt_db4func->action=all,server=server1->db=encrypt_db4func->table=teacher->column=name->action=all"

#Select permission for column
sentry_privileges[DBAllWithEncryptedColumns_3]="server=server1->db=encrypt_db4alter->action=all,server=server1->db=encrypt_db4alter->table=test_partition->column=encrypt_id->action=select,server=server1->db=encrypt_db4alter->table=test_partition->column=encrypt_part->action=select,server=server1->db=encrypt_db4alter->table=test_partition->column=encrypt_quantity->action=select,server=server1->db=encrypt_db4alter->table=test_enable_disable_partition->column=encrypt_hms->action=select,server=server1->db=encrypt_db4alter->table=test_enable_disable_partition->column=encrypt_severity->action=select,server=server1->db=encrypt_db4alter->table=test_enable_disable_partition->column=encrypt_server->action=select,server=server1->db=encrypt_db4alter->table=test_enable_disable_partition->column=encrypt_process_id->action=select,server=server1->db=encrypt_db4alter->table=test_enable_disable_partition->column=encrypt_message->action=select,server=server1->db=encrypt_db4alter->table=tbl4addcolumn->column=encrypt_col1->action=select,server=server1->db=encrypt_db4alter->table=tbl4addcolumn->column=encrypt_col2->action=select,server=server1->db=encrypt_db4alter->table=tbl4addcolumn->column=encrypt_col3->action=select,server=server1->db=encrypt_db4alter->table=tbl4change->column=encrypt_col1->action=select,server=server1->db=encrypt_db4alter->table=tbl4change->column=encrypt_col2->action=select,server=server1->db=encrypt_db4alter->table=tbl4change->column=encrypt_col3->action=select,server=server1->db=encrypt_db4alter->table=test_enable_disable->column=encrypt_hms->action=select,server=server1->db=encrypt_db4alter->table=test_enable_disable->column=encrypt_severity->action=select,server=server1->db=encrypt_db4alter->table=test_enable_disable->column=encrypt_server->action=select,server=server1->db=encrypt_db4alter->table=test_enable_disable->column=encrypt_process_id->action=select,server=server1->db=encrypt_db4alter->table=test_enable_disable->column=encrypt_message->action=select,server=server1->db=encrypt_db4alter->table=tbl4rename->column=encrypt_col1->action=select,server=server1->db=encrypt_db4alter->table=tbl4rename->column=encrypt_col2->action=select,server=server1->db=encrypt_db4alter->table=tbl4rename->column=encrypt_col3->action=select,server=server1->db=encrypt_db4alter->table=tbl4replace->column=encrypt_col1->action=select,server=server1->db=encrypt_db4alter->table=tbl4replace->column=encrypt_col2->action=select,server=server1->db=encrypt_db4alter->table=tbl4replace->column=encrypt_col3->action=select,server=server1->db=encrypt_db4alter->table=tbl4fileformat->column=encrypt_hms->action=select,server=server1->db=encrypt_db4alter->table=tbl4fileformat->column=encrypt_severity->action=select,server=server1->db=encrypt_db4alter->table=tbl4fileformat->column=encrypt_server->action=select,server=server1->db=encrypt_db4alter->table=tbl4fileformat->column=encrypt_process_id->action=select,server=server1->db=encrypt_db4alter->table=tbl4fileformat->column=encrypt_message->action=select,server=server1->db=encrypt_db4alter->table=tbl4fileformat_external->column=encrypt_hms->action=select,server=server1->db=encrypt_db4alter->table=tbl4fileformat_external->column=encrypt_severity->action=select,server=server1->db=encrypt_db4alter->table=tbl4fileformat_external->column=encrypt_server->action=select,server=server1->db=encrypt_db4alter->table=tbl4fileformat_external->column=encrypt_process_id->action=select,server=server1->db=encrypt_db4alter->table=tbl4fileformat_external->column=encrypt_message->action=select,server=server1->db=encrypt_db4alter->table=tbl4descformatted->column=encrypt_hms->action=select,server=server1->db=encrypt_db4alter->table=tbl4descformatted->column=encrypt_severity->action=select,server=server1->db=encrypt_db4alter->table=tbl4descformatted->column=encrypt_server->action=select,server=server1->db=encrypt_db4alter->table=tbl4descformatted->column=encrypt_process_id->action=select,server=server1->db=encrypt_db4alter->table=tbl4descformatted->column=encrypt_message->action=select,server=server1->db=encrypt_db4data->action=all,server=server1->db=encrypt_db4data->table=test_serde_partition->column=encrypt_c0->action=select,server=server1->db=encrypt_db4data->table=test_serde_partition->column=encrypt_c1->action=select,server=server1->db=encrypt_db4data->table=test_serde_partition->column=encrypt_c2->action=select,server=server1->db=encrypt_db4data->table=test_serde->column=encrypt_c0->action=select,server=server1->db=encrypt_db4data->table=test_serde->column=encrypt_c1->action=select,server=server1->db=encrypt_db4data->table=test_serde->column=encrypt_c2->action=select,server=server1->db=encrypt_db4data->table=test_clusteredby->column=encrypt_name->action=select,server=server1->db=encrypt_db4data->table=test_clusteredby->column=encrypt_salary->action=select,server=server1->db=encrypt_db4data->table=test_clusteredby->column=encrypt_subordinates->action=select,server=server1->db=encrypt_db4data->table=test_clusteredby->column=encrypt_deductions->action=select,server=server1->db=encrypt_db4data->table=test_clusteredby->column=encrypt_address->action=select,server=server1->db=encrypt_db4data->table=encrypt_test_analyze->column=encrypt_name->action=select,server=server1->db=encrypt_db4data->table=encrypt_test_analyze->column=encrypt_salary->action=select,server=server1->db=encrypt_db4data->table=encrypt_test_analyze->column=encrypt_subordinates->action=select,server=server1->db=encrypt_db4data->table=encrypt_test_analyze->column=encrypt_deductions->action=select,server=server1->db=encrypt_db4data->table=encrypt_test_analyze->column=encrypt_address->action=select,server=server1->db=encrypt_db4data->table=tbl4builtinfuncs->column=encrypt_col1->action=select,server=server1->db=encrypt_db4data->table=tbl4builtinfuncs->column=encrypt_col2->action=select,server=server1->db=encrypt_db4data->table=tbl4builtinfuncs->column=encrypt_col3->action=select,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=encrypt_user_id->action=select,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=encrypt_pageview_id->action=select,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=encrypt_page_url->action=select,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=encrypt_referrer_url->action=select,server=server1->db=encrypt_db4data->table=session_src_encrypted->column=encrypt_timestamp->action=select,server=server1->db=encrypt_db4data->table=sessionization_step_one_origins_tgt_encrypted->column=encrypt_ssoo_user_id->action=select,server=server1->db=encrypt_db4data->table=sessionization_step_one_origins_tgt_encrypted->column=encrypt_ssoo_pageview_id->action=select,server=server1->db=encrypt_db4data->table=sessionization_step_one_origins_tgt_encrypted->column=encrypt_ssoo_timestamp->action=select,server=server1->db=encrypt_db4data->table=encrypt_import_export->column=encrypt_name->action=select,server=server1->db=encrypt_db4data->table=encrypt_import_export->column=encrypt_salary->action=select,server=server1->db=encrypt_db4data->table=encrypt_import_export->column=encrypt_subordinates->action=select,server=server1->db=encrypt_db4data->table=encrypt_import_export->column=encrypt_deductions->action=select,server=server1->db=encrypt_db4data->table=encrypt_import_export->column=encrypt_address->action=select,server=server1->db=encrypt_db4data->table=encrypt_tgt_import_export->column=encrypt_name->action=select,server=server1->db=encrypt_db4data->table=encrypt_tgt_import_export->column=encrypt_salary->action=select,server=server1->db=encrypt_db4data->table=encrypt_tgt_import_export->column=encrypt_subordinates->action=select,server=server1->db=encrypt_db4data->table=encrypt_tgt_import_export->column=encrypt_deductions->action=select,server=server1->db=encrypt_db4data->table=encrypt_tgt_import_export->column=encrypt_address->action=select,server=server1->db=encrypt_db4data->table=encrypt_employees->column=encrypt_name->action=select,server=server1->db=encrypt_db4data->table=encrypt_employees->column=encrypt_salary->action=select,server=server1->db=encrypt_db4data->table=encrypt_employees->column=encrypt_subordinates->action=select,server=server1->db=encrypt_db4data->table=encrypt_employees->column=encrypt_deductions->action=select,server=server1->db=encrypt_db4data->table=encrypt_employees->column=encrypt_address->action=select,server=server1->db=encrypt_db4data->table=encrypt_tgt_employees->column=encrypt_name->action=select,server=server1->db=encrypt_db4data->table=encrypt_tgt_employees->column=encrypt_salary->action=select,server=server1->db=encrypt_db4data->table=encrypt_tgt_employees->column=encrypt_subordinates->action=select,server=server1->db=encrypt_db4data->table=encrypt_tgt_employees->column=encrypt_deductions->action=select,server=server1->db=encrypt_db4data->table=encrypt_tgt_employees->column=encrypt_address->action=select,server=server1->db=encrypt_db4data->table=partition_table_src->column=name->action=select,server=server1->db=encrypt_db4data->table=partition_table_src->column=ip->action=select,server=server1->db=encrypt_db4data->table=partition_table_tgt->column=name->action=select,server=server1->db=encrypt_db4data->table=partition_table_tgt->column=ip->action=select,server=server1->db=encrypt_db4data->table=table_src->column=name->action=select,server=server1->db=encrypt_db4data->table=table_src->column=ip->action=select,server=server1->db=encrypt_db4data->table=table_tgt->column=name->action=select,server=server1->db=encrypt_db4data->table=table_tgt->column=ip->action=select,server=server1->db=encrypt_db4data->table=collecttest->column=str->action=select,server=server1->db=encrypt_db4data->table=whoyouare->column=who->action=select,server=server1->db=encrypt_db4tbl->action=all,server=server1->db=encrypt_db4tbl->table=tbl4view->column=encrypt_c0->action=select,server=server1->db=encrypt_db4tbl->table=tbl4view->column=encrypt_c1->action=select,server=server1->db=encrypt_db4tbl->table=tbl4view->column=encrypt_c2->action=select,server=server1->db=encrypt_db4drop_cascade->action=select,server=server1->db=encrypt_db4drop_cascade->table=encrypt_tbl4drop->column=encrypt_id->action=select,server=server1->db=encrypt_db4drop_cascade->table=encrypt_tbl4drop->column=encrypt_val->action=select,server=server1->db=encrypt_db4msck->action=all,server=server1->db=encrypt_db4msck->table=test_msck->column=encrypt_id->action=select,server=server1->db=encrypt_db4msck->table=test_msck->column=encrypt_val->action=select,server=server1->db=encrypt_db4props->action=all,server=server1->db=encrypt_db4props->table=employees_props->column=encrypt_name->action=select,server=server1->db=encrypt_db4props->table=employees_props->column=encrypt_salary->action=select,server=server1->db=encrypt_db4props->table=employees_props->column=encrypt_subordinates->action=select,server=server1->db=encrypt_db4props->table=employees_props->column=encrypt_deductions->action=select,server=server1->db=encrypt_db4props->table=employees_props->column=encrypt_address->action=select,server=server1->db=encrypt_db4func->action=all,server=server1->db=encrypt_db4func->table=teacher->column=name->action=select"
##============

##============Proxy Uer+Groups Privilege
####super user to create tables and views

#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename mt_qa --privilege "server=server1->db=origindb->table=waimai_order_shard__wm->column=binded_phone->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename mt_qa --privilege "server=server1->db=origindb->table=waimai_order_shard__wm->column=common_ext->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename mt_qa --privilege "server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_address->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename mt_qa --privilege "server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_name->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename mt_qa --privilege "server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_phone->action=select"


#sentry_privileges[superuser_columns]="server=server1->db=origindb->table=waimai_order_shard__wm->column=common_ext->action=select"


#sentry_privileges[superuser_columns]=
#"server=server1->db=origindb->table=waimai_order_shard__wm->column=binded_phone->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=common_ext->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_address->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_name->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_phone->action=select"



#proxy user+groups
#DB ALL + TABLE SELECT
#origin_waimai.waimai_safe_order VIEW reference encrypt columns
#origindb.waimai_order_shard__wm TABLE has encrypt columns
#give privilege on the base table for encrypt columns
#give privilege on the view for encrypt columns
#dim.ndm_user has 2 encrypt columns, grant select privilege
#

#GROUPS USED IN THIS CASE:
#mart_waimai_group
#ba_ups_group
#dw_group
#mart_waimai_crm_group
#mart_wmorg_group
#origin_waimai_group
#origindb_group
#origindb_delta_group
#origin_dianping_group
#origindb_group
#origin_waimai_group
#dim_group




sentry_privileges[GroupLogin]="server=server1->db=mart_waimai->action=all,server=server1->db=ba_ups->table=mt_dp_uid_mapping_new->action=select,server=server1->db=dim->table=ndm_user->action=select,server=server1->db=dim->table=collecttest->action=select,server=server1->db=dw->table=dim_employee->action=select,server=server1->db=mart_waimai_crm->table=topic_dt_check_list__poiaor_aortype_audit->action=select,server=server1->db=mart_wmorg->table=employ_encrypted->action=select,server=server1->db=origin_waimai->table=waimai_cos__wm_employ->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->action=select,server=server1->db=origindb->table=gis__admin_division->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->action=select,server=server1->db=origindb_delta->table=waimai_money_exchange__wm_exchange_flow->action=select,server=server1->db=origin_dianping->table=dpmid_ugcreview_basereview->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=binded_phone->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=common_ext->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_address->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_name->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_phone->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=binded_phone->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=common_ext->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_address->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_name->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_phone->action=select,server=server1->db=dim->table=ndm_user->column=username->action=select,server=server1->db=dim->table=ndm_user->column=mobile->action=select"


#DB.TABLE SELECT+CREATE+INSERT+ALTER + TABLE SELECT
#origin_waimai.waimai_safe_order VIEW reference encrypt columns
#origindb.waimai_order_shard__wm TABLE has encrypt columns
#give privilege on the base table for encrypt columns
#do not give privilege on the view for encrypt columns
#dim.ndm_user has 2 encrypt columns, grant select privilege

mart_waimai_group="server=server1->db=mart_waimai->table=dim_ad_cpc_activity_poi->action=select"

ba_ups_group="server=server1->db=ba_ups->table=mt_dp_uid_mapping_new->action=select"
dw_group
mart_wmorg_group
origin_waimai_group

origindb_group

origindb_delta_group
origin_dianping_group
mart_waimai_crm_group

origindb_group
dim_group


sentry_privileges[GroupLogin_2]="server=server1->db=mart_waimai->table=dim_ad_cpc_activity_poi->action=select,server=server1->db=mart_waimai->table=dim_ad_cpc_activity->action=select,server=server1->db=mart_waimai->table=cis_mappoi_in_aor->action=select,server=server1->db=mart_waimai->table=table001->action=select,server=server1->db=mart_waimai->table=table002->action=select,server=server1->db=mart_waimai->table=partition_table001->action=select,server=server1->db=mart_waimai->table=partition_table002->action=select,server=server1->db=mart_waimai->table=dim_ad_cpc_activity_poi->action=create,server=server1->db=mart_waimai->table=dim_ad_cpc_activity->action=create,server=server1->db=mart_waimai->table=cis_mappoi_in_aor->action=create,server=server1->db=mart_waimai->table=table001->action=create,server=server1->db=mart_waimai->table=table002->action=create,server=server1->db=mart_waimai->table=partition_table001->action=create,server=server1->db=mart_waimai->table=partition_table002->action=create,server=server1->db=mart_waimai->table=dim_ad_cpc_activity_poi->action=insert,server=server1->db=mart_waimai->table=dim_ad_cpc_activity->action=insert,server=server1->db=mart_waimai->table=cis_mappoi_in_aor->action=insert,server=server1->db=mart_waimai->table=table001->action=insert,server=server1->db=mart_waimai->table=table002->action=insert,server=server1->db=mart_waimai->table=partition_table001->action=insert,server=server1->db=mart_waimai->table=partition_table002->action=insert,server=server1->db=mart_waimai->table=dim_ad_cpc_activity_poi->action=alter,server=server1->db=mart_waimai->table=dim_ad_cpc_activity->action=alter,server=server1->db=mart_waimai->table=cis_mappoi_in_aor->action=alter,server=server1->db=mart_waimai->table=table001->action=alter,server=server1->db=mart_waimai->table=table002->action=alter,server=server1->db=mart_waimai->table=partition_table001->action=alter,server=server1->db=mart_waimai->table=partition_table002->action=alter,server=server1->db=ba_ups->table=mt_dp_uid_mapping_new->action=select,server=server1->db=dim->table=ndm_user->action=select,server=server1->db=dim->table=collecttest->action=select,server=server1->db=dw->table=dim_employee->action=select,server=server1->db=mart_wmorg->table=employ_encrypted->action=select,server=server1->db=origin_waimai->table=waimai_cos__wm_employ->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->action=select,server=server1->db=origindb->table=gis__admin_division->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->action=select,server=server1->db=origindb_delta->table=waimai_money_exchange__wm_exchange_flow->action=select,server=server1->db=origin_dianping->table=dpmid_ugcreview_basereview->action=select,server=server1->db=mart_waimai_crm->table=topic_dt_check_list__poiaor_aortype_audit->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=binded_phone->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=common_ext->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_address->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_name->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_phone->action=select,server=server1->db=dim->table=ndm_user->column=mobile->action=select,server=server1->db=dim->table=ndm_user->column=username->action=select"


#DB ALL + DB SELECT
#origin_waimai.waimai_safe_order VIEW reference encrypt columns
#origindb.waimai_order_shard__wm TABLE has encrypt columns
#do not give privilege on the base table for encrypt columns
#give privilege on the view for encrypt columns
#dim.ndm_user has 2 encrypt columns, do not grant select privilege
sentry_privileges[GroupLogin_3]="server=server1->db=ba_ups->action=select,server=server1->db=dim->action=select,server=server1->db=dw->action=select,server=server1->db=mart_waimai->action=all,server=server1->db=mart_waimai_crm->action=select,server=server1->db=mart_wmorg->action=select,server=server1->db=origin_waimai->action=select,server=server1->db=origindb->action=select,server=server1->db=origindb_delta->action=select,server=server1->db=origin_dianping->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=binded_phone->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=common_ext->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_address->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_name->action=select,server=server1->db=origin_waimai->table=waimai_safe_o£¢rder->column=recipient_phone->action=select"

#DB SELECT+CREATE+ALTER+INSERT + DB SELECT
#dim.ndm_user has 2 encrypt columns, grant select privilege
sentry_privileges[GroupLogin_4]="server=server1->db=ba_ups->action=select,server=server1->db=dim->action=select,server=server1->db=dw->action=select,server=server1->db=mart_waimai->action=select,server=server1->db=mart_waimai->action=create,server=server1->db=mart_waimai->action=alter,server=server1->db=mart_waimai->action=insert,server=server1->db=mart_waimai_crm->action=select,server=server1->db=mart_wmorg->action=select,server=server1->db=origin_waimai->action=select,server=server1->db=origindb->action=select,server=server1->db=origindb_delta->action=select,server=server1->db=origin_dianping->action=select,server=server1->db=dim->table=ndm_user->column=username->action=select,server=server1->db=dim->table=ndm_user->column=mobile->action=select"


### grant encrypt column privilege
#origin_dianping_group="server=server1->db=origin_dianping->table=dpmid_ugcreview_basereview->column=reviewbody->action=select"
#
#origindb_group="server=server1->db=origindb->table=waimai_order_shard__wm->column=binded_phone->action=select"
#origindb_group="server=server1->db=origindb->table=waimai_order_shard__wm->column=common_ext->action=select"
#origindb_group="server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_address->action=select"
#origindb_group="server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_name->action=select"
#origindb_group="server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_phone->action=select"
#
#origin_waimai_group="server=server1->db=origin_waimai->table=waimai_cos__wm_employ->column=email->action=select"
#origin_waimai_group="server=server1->db=origin_waimai->table=waimai_cos__wm_employ->column=mobile->action=select"
#
#origin_waimai_group="server=server1->db=origin_waimai->table=waimai_safe_order->column=binded_phone->action=select"
#origin_waimai_group="server=server1->db=origin_waimai->table=waimai_safe_order->column=common_ext->action=select"
#origin_waimai_group="server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_address->action=select"
#origin_waimai_group="server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_name->action=select"
#origin_waimai_group="server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_phone->action=select"
#
#dw_group="server=server1->db=dw->table=dim_employee->column=birthday->action=select"
#dw_group="server=server1->db=dw->table=dim_employee->column=mobile_phone_no->action=select"
#dim_group="server=server1->db=dim->table=ndm_user->column=username->action=select"
#dim_group="server=server1->db=dim->table=ndm_user->column=mobile->action=select"
#
#ba_ups_group="server=server1->db=ba_ups->table=mt_dp_uid_mapping_new->column=mobile->action=select"



#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r ba_ups_group
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r ba_ups_group -g ba_ups_group
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename ba_ups_group --privilege "server=server1->db=ba_ups->action=select"
#
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r dw_group
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r dw_group -g dw_group
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename dw_group --privilege "server=server1->db=dim->action=select"
#
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r dw_group
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r dw_group -g dw_group
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename dw_group --privilege "server=server1->db=dw->action=select"
#
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r mart_waimai_group
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r mart_waimai_group -g mart_waimai_group
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename mart_waimai_group --privilege "server=server1->db=mart_waimai->action=select"
#
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r mart_waimai_crm_group
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r mart_waimai_crm_group -g mart_waimai_crm_group
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename mart_waimai_crm_group --privilege "server=server1->db=mart_waimai_crm->action=select"
#
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r mart_wmorg_group
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r mart_wmorg_group -g mart_wmorg_group
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename mart_wmorg_group --privilege "server=server1->db=mart_wmorg->action=select"
#
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r origin_waimai_group
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r origin_waimai_group -g origin_waimai_group
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origin_waimai_group --privilege "server=server1->db=origin_waimai->action=select"
#
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r origindb_group
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r origindb_group -g origindb_group
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origindb_group --privilege "server=server1->db=origindb->action=select"
#
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r origindb_delta_group
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r origindb_delta_group -g origindb_delta_group
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origindb_delta_group --privilege "server=server1->db=origindb_delta->action=select"
#
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r origin_dianping_group
#/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r origin_dianping_group -g origin_dianping_group
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origin_dianping_group --privilege "server=server1->db=origin_dianping->action=select"
#
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origin_dianping_group --privilege "server=server1->db=origin_dianping->table=dpmid_ugcreview_basereview->column=reviewbody->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origindb_group --privilege "server=server1->db=origindb->table=waimai_order_shard__wm->column=binded_phone->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origindb_group --privilege "server=server1->db=origindb->table=waimai_order_shard__wm->column=common_ext->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origindb_group --privilege "server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_address->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origindb_group --privilege "server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_name->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origindb_group --privilege "server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_phone->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origin_waimai_group --privilege "server=server1->db=origin_waimai->table=waimai_cos__wm_employ->column=email->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origin_waimai_group --privilege "server=server1->db=origin_waimai->table=waimai_cos__wm_employ->column=mobile->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origin_waimai_group --privilege "server=server1->db=origin_waimai->table=waimai_safe_order->column=binded_phone->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origin_waimai_group --privilege "server=server1->db=origin_waimai->table=waimai_safe_order->column=common_ext->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origin_waimai_group --privilege "server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_address->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origin_waimai_group --privilege "server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_name->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename origin_waimai_group --privilege "server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_phone->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename dw_group --privilege "server=server1->db=dw->table=dim_employee->column=birthday->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename dw_group --privilege "server=server1->db=dw->table=dim_employee->column=mobile_phone_no->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename dw_group --privilege "server=server1->db=dim->table=ndm_user->column=username->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename dw_group --privilege "server=server1->db=dim->table=ndm_user->column=mobile->action=select"
#/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename ba_ups_group --privilege "server=server1->db=ba_ups->table=mt_dp_uid_mapping_new->column=mobile->action=select"
##============

##============
# Sentry Flag
if [[ "$2" == "SentryFlagTable" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[SentryFlagTable]}"`
elif [[ "$2" == "SentryFlagDB" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[SentryFlagDB]}"`

# Super Privilege
elif [[ "$2" == "SuperPrivil" ]]; then
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
elif [[ "$2" == "ServerWrite" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[ServerWrite]}"`

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
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBDrop]}"`
elif [[ "$2" == "DBWrite" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBWrite]}"`

# Table Privilege
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
elif [[ "$2" == "TableWrite" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[TableWrite]}"`

# Encrypted Columns Privilege
elif [[ "$2" == "DBAllWithEncryptedColumns" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBAllWithEncryptedColumns]}"`
elif [[ "$2" == "DBAllWithEncryptedColumns_2" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBAllWithEncryptedColumns_2]}"`
elif [[ "$2" == "DBAllWithEncryptedColumns_3" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[DBAllWithEncryptedColumns_3]}"`

# Proxy user group Privilege
elif [[ "$2" == "GroupLogin" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[GroupLogin]}"`
elif [[ "$2" == "GroupLogin_2" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[GroupLogin_2]}"`
elif [[ "$2" == "GroupLogin_3" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[GroupLogin_3]}"`
elif [[ "$2" == "GroupLogin_4" ]]; then
    privileges=`awk 'BEGIN{FS=","}{for(i=1;i<=NF;i++)print $i}' <<< "${sentry_privileges[GroupLogin_4]}"`

# For show privilege to specify $2 with List
elif [[ "$2" == "List" ]]; then
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


# Exec Privilege
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
        # Too many roles, so temporary comment the line.
        #$SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_role -g $ROLE_GROUP
        $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --list_privilege -r $ROLE_NAME
        ;;
    * )
    echo "Please specify valid action"
    exit $NOMATCH;;
esac
