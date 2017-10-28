#!/bin/bash
#filename: sentry_grp_env.sh
#
#The script will grant sentry role and group privilege for proxy user+group login way
#

# Define param and env
ARGS=2
BAD_PARAMS=66
NOMATCH=127
NOPRI=62
LOGIN_USER=hive
DB_NAME=testdb

export HADOOP_HOME=/opt/meituan/hadoop
export SENTRY_HOME=/opt/meituan/sentry
source /opt/meituan/hadoop/bin/hadoop_user_login.sh $LOGIN_USER


# Check CLI parameter
[ $# -ne $ARGS ] && echo "Usage: `basename $BASH_SOURCE` (setup|clean|check) (privilege)" && exit $BAD_PARAMS

##============
declare -A sentry_privileges

# Split multiple user group privileges by pipe symbols
sentry_privileges[GroupLogin]='mart_waimai_group="server=server1->db=mart_waimai->action=all"|ba_ups_group="server=server1->db=ba_ups->table=mt_dp_uid_mapping_new->action=select"|dw_group="server=server1->db=dim->table=ndm_user->action=select,server=server1->db=dim->table=collecttest->action=select,server=server1->db=dw->table=dim_employee->action=select"|mart_waimai_crm_group="server=server1->db=mart_waimai_crm->table=topic_dt_check_list__poiaor_aortype_audit->action=select"|mart_wmorg_group="server=server1->db=mart_wmorg->table=employ_encrypted->action=select"|origin_waimai_group="server=server1->db=origin_waimai->table=waimai_cos__wm_employ->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=binded_phone->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=common_ext->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_address->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_name->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_phone->action=select"|origindb_group="server=server1->db=origindb->table=gis__admin_division->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=binded_phone->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=common_ext->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_address->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_name->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_phone->action=select"|origindb_delta_group="server=server1->db=origindb_delta->table=waimai_money_exchange__wm_exchange_flow->action=select"|origin_dianping_group="server=server1->db=origin_dianping->table=dpmid_ugcreview_basereview->action=select"|dim_group="server=server1->db=dim->table=ndm_user->column=username->action=select,server=server1->db=dim->table=ndm_user->column=mobile->action=select"'

sentry_privileges[GroupLogin_2]='mart_waimai_group="server=server1->db=mart_waimai->table=dim_ad_cpc_activity_poi->action=select,server=server1->db=mart_waimai->table=dim_ad_cpc_activity->action=select,server=server1->db=mart_waimai->table=cis_mappoi_in_aor->action=select,server=server1->db=mart_waimai->table=table001->action=select,server=server1->db=mart_waimai->table=table002->action=select,server=server1->db=mart_waimai->table=partition_table001->action=select,server=server1->db=mart_waimai->table=partition_table002->action=select,server=server1->db=mart_waimai->table=dim_ad_cpc_activity_poi->action=create,server=server1->db=mart_waimai->table=dim_ad_cpc_activity->action=create,server=server1->db=mart_waimai->table=cis_mappoi_in_aor->action=create,server=server1->db=mart_waimai->table=table001->action=create,server=server1->db=mart_waimai->table=table002->action=create,server=server1->db=mart_waimai->table=partition_table001->action=create,server=server1->db=mart_waimai->table=partition_table002->action=create,server=server1->db=mart_waimai->table=dim_ad_cpc_activity_poi->action=insert,server=server1->db=mart_waimai->table=dim_ad_cpc_activity->action=insert,server=server1->db=mart_waimai->table=cis_mappoi_in_aor->action=insert,server=server1->db=mart_waimai->table=table001->action=insert,server=server1->db=mart_waimai->table=table002->action=insert,server=server1->db=mart_waimai->table=partition_table001->action=insert,server=server1->db=mart_waimai->table=partition_table002->action=insert,server=server1->db=mart_waimai->table=dim_ad_cpc_activity_poi->action=alter,server=server1->db=mart_waimai->table=dim_ad_cpc_activity->action=alter,server=server1->db=mart_waimai->table=cis_mappoi_in_aor->action=alter,server=server1->db=mart_waimai->table=table001->action=alter,server=server1->db=mart_waimai->table=table002->action=alter,server=server1->db=mart_waimai->table=partition_table001->action=alter,server=server1->db=mart_waimai->table=partition_table002->action=alter"|ba_ups_group="server=server1->db=ba_ups->table=mt_dp_uid_mapping_new->action=select"|dim_group="server=server1->db=dim->table=ndm_user->action=select,server=server1->db=dim->table=collecttest->action=select,server=server1->db=dim->table=ndm_user->column=username->action=select,server=server1->db=dim->table=ndm_user->column=mobile->action=select"|dw_group="server=server1->db=dw->table=dim_employee->action=select"|mart_wmorg_group="server=server1->db=mart_wmorg->table=employ_encrypted->action=select"|origin_waimai_group="server=server1->db=origin_waimai->table=waimai_cos__wm_employ->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->action=select"|origindb_group="server=server1->db=origindb->table=gis__admin_division->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=binded_phone->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=common_ext->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_address->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_name->action=select,server=server1->db=origindb->table=waimai_order_shard__wm->column=recipient_phone->action=select"|origindb_delta_group="server=server1->db=origindb_delta->table=waimai_money_exchange__wm_exchange_flow->action=select"|origin_dianping_group="server=server1->db=origin_dianping->table=dpmid_ugcreview_basereview->action=select"'

sentry_privileges[GroupLogin_3]='ba_ups_group="server=server1->db=ba_ups->action=select"|dim_group="server=server1->db=dim->action=select"|dw_group="server=server1->db=dw->action=select"|mart_waimai_group="server=server1->db=mart_waimai->action=all"|mart_waimai_crm_group="server=server1->db=mart_waimai_crm->action=select,server=server1->db=mart_waimai_crm->action=drop"|mart_wmorg_group="server=server1->db=mart_wmorg->action=select"|origin_waimai_group="server=server1->db=origin_waimai->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=binded_phone->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=common_ext->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_address->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_name->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_phone->action=select"|origindb_group="server=server1->db=origindb->action=select"|origin_dianping_group="server=server1->db=origin_dianping->action=select"'

sentry_privileges[GroupLogin_3]='ba_ups_group="server=server1->db=ba_ups->action=select"|dim_group="server=server1->db=dim->action=select"|dw_group="server=server1->db=dw->action=select"|mart_waimai_group="server=server1->db=mart_waimai->action=select,server=server1->db=mart_waimai->action=create,server=server1->db=mart_waimai->action=alter,server=server1->db=mart_waimai->action=insert"|mart_waimai_crm_group="server=server1->db=mart_waimai_crm->action=select"|mart_wmorg_group="server=server1->db=mart_wmorg->action=select"|origin_waimai_group="server=server1->db=origin_waimai->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=binded_phone->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=common_ext->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_address->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_name->action=select,server=server1->db=origin_waimai->table=waimai_safe_order->column=recipient_phone->action=select"|origindb_group="server=server1->db=origindb->action=select"|origin_dianping_group="server=server1->db=origin_dianping->action=select"'

#sentry_privileges[GroupLogin_4]='ba_ups_group="server=server1->db=ba_ups->action=select"|dim_group="server=server1->db=dim->action=select,server=server1->db=dim->table=ndm_user->column=username->action=select,server=server1->db=dim->table=ndm_user->column=mobile->action=select"|dw_group="server=server1->db=dw->action=select"|mart_waimai_group="server=server1->db=mart_waimai->action=select,server=server1->db=mart_waimai->action=create,server=server1->db=mart_waimai->action=alter,server=server1->db=mart_waimai->action=insert"|mart_waimai_crm_group="server=server1->db=mart_waimai_crm->action=all"|mart_wmorg_group="server=server1->db=mart_wmorg->action=select"|origin_waimai_group="server=server1->db=origin_waimai->action=select"|origindb_group="server=server1->db=origindb->action=select"|origindb_delta_group="server=server1->db=origindb_delta->action=select"|origin_dianping_group="server=server1->db=origin_dianping->action=select"'

##============
# Just verify if this is correct
if [[ "$2" = "GroupLogin" ]]; then
    :
elif [[ "$2" = "GroupLogin_2" ]]; then
    :
elif [[ "$2" = "GroupLogin_3" ]]; then
    :
#elif [[ "$2" = "GroupLogin_4" ]]; then
#    :
else
    echo "Please specify valid sentry user group privilege"
    exit $NOPRI
fi

# Split and grant privilege to multiple users and the corresponding groups
groups_login=${sentry_privileges[$2]} # Mark -- Need to modify GroupLogin to $2 after debugging

for i in  `awk -F'|' '{for(i=1;i<=NF;i++) print $i}' <<< $groups_login`;do
    ROLE_NAME=`awk -F'="' '{print $1}' <<< $i`
    ROLE_GROUP=$ROLE_NAME
    PRIVILEGES=`awk -F'="' '{gsub(/"/, "", $2); print $2}' <<< $i`
    PRIVIL_SPLIT=`awk -F',' '{for(i=1;i<=NF;i++) print $i}' <<< "$PRIVILEGES"`

    case "$1" in
        "setup")
            # Add role, group and privilege
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --create_role -r $ROLE_NAME
            $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --add_role_group -r $ROLE_NAME -g $ROLE_GROUP

            for PRIVIL in $PRIVIL_SPLIT; do
                $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --grant_privilege_role --rolename $ROLE_NAME --privilege $PRIVIL
            done
            ;;
        "clean")
            # Remove role, group and privilege
            for PRIVIL in $PRIVIL_SPLIT; do
                $SENTRY_HOME/bin/sentryShell -conf $SENTRY_HOME/conf/sentry-site.xml --revoke_privilege_role -r $ROLE_NAME -p $PRIVIL
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
done
