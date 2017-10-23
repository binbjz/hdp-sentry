CREATE  TABLE `dw.dim_employee`(
 `employee_id` bigint COMMENT '员工第一次入职时给员工分配的ID，离职后再次入职保持不变',
 `employee_name` string COMMENT '员工的中文名',
 `mis_name` string COMMENT '员工的mis账号名',
 `gender` bigint COMMENT '员工性别，0：未知；1：男；2：女',
 `birthday` string COMMENT '员工的生日，格式为yyyy-MM-dd',
 `entry_date` string COMMENT '员工的入职时间，格式为yyyy-MM-dd',
 `left_date` string COMMENT '员工的离职时间，格式为yyyy-MM-dd',
 `position_id` bigint COMMENT '员工的职位id',
 `position_begin_date` string COMMENT '岗位开始时间',
 `position_end_date` string COMMENT '岗位结束时间',
 `job_id` string COMMENT '员工的工号',
 `job_status` bigint COMMENT '员工的在职状态, 0:未知,1:在职,2:离职,3:停薪留职,4:应聘',
 `job_status_name` string COMMENT '工的在职状态名称',
 `is_deleted` bigint COMMENT '记录是否被删除',
 `org_id` bigint COMMENT '员工所在的组织节点id',
 `org_name` string COMMENT '员工所在的组织节点名称',
 `org_leader_id` bigint COMMENT '组织节点的leader的员工id',
 `superior_id` bigint COMMENT '员工直接上级的员工id',
 `dep_id` bigint COMMENT '员工所在部门id',
 `dep_name` string COMMENT '员工所在部门名称',
 `internal_email` string COMMENT '员工的email',
 `mobile_phone_no` string COMMENT '员工的手机号',
 `org_unit_id` bigint COMMENT '员工所在的到店餐饮的管理单元',
 `tenant_id` bigint COMMENT '租户ID(1.新美大员工 2.猫眼员工 2001.天子星 5001.Demo)但',
 `effect_begin_date` string COMMENT '开链时间，如20100101',
 `is_enabled` string COMMENT '是否最新',
 `effect_end_date` string COMMENT '关联时间，如20151231')
COMMENT '员工信息维度表'
ROW FORMAT SERDE
 'org.apache.hadoop.hive.ql.io.orc.OrcSerde'
STORED AS INPUTFORMAT
 'org.apache.hadoop.hive.ql.io.orc.OrcInputFormat'
OUTPUTFORMAT
 'org.apache.hadoop.hive.ql.io.orc.OrcOutputFormat'
LOCATION
 'viewfs://hadoop-meituan/nn19/warehouse/dw.db/dim_employee'
TBLPROPERTIES (
 'numFiles'='4',
 'last_modified_by'='hadoop-data',
 'last_modified_time'='1490945480',
 'transient_lastDdlTime'='1508263656',
 'COLUMN_STATS_ACCURATE'='false',
 'totalSize'='18934694',
 'numRows'='-1',
 'rawDataSize'='-1');
