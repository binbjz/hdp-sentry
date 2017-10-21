--encrypt_db4data.tbl4builtinfuncs=col1,col2,col3
--CREATE DATABASE encrypt_db4data;
--DROP DATABASE encrypt_db4data;


--encrypt_db4func.teacher=name
--encrypt_db4data.whoyouare=who
--encrypt_db4props.employees_props=encrypt_name,encrypt_salary,encrypt_subordinates,encrypt_deductions,encrypt_address
--encrypt_db4msck.test_msck=encrypt_id,encrypt_val
--encrypt_db4data.collecttest=str
--encrypt_db4data.table_tgt=name,ip
--encrypt_db4data.table_src=name,ip
--encrypt_db4data.partition_table_tgt=name,ip
--encrypt_db4data.partition_table_src=name,ip
--encrypt_db4data.encrypt_employees=encrypt_name,encrypt_salary,encrypt_subordinates,encrypt_deductions,encrypt_address
--encrypt_db4data.encrypt_tgt_employees=encrypt_name,encrypt_salary,encrypt_subordinates,encrypt_deductions,encrypt_address
--encrypt_db4data.encrypt_import_export=encrypt_name,encrypt_salary,encrypt_subordinates,encrypt_deductions,encrypt_address
--encrypt_db4data.encrypt_tgt_import_export=encrypt_name,encrypt_salary,encrypt_subordinates,encrypt_deductions,encrypt_address
--encrypt_db4drop_cascade.encrypt_tbl4drop=encrypt_id,encrypt_val
--encrypt_db4alter.tbl4descformatted=encrypt_hms,encrypt_severity,encrypt_server,encrypt_process_id,encrypt_message
--encrypt_db4data.sessionization_step_one_origins_tgt_encrypted=ssoo_user_id,ssoo_pageview_id,ssoo_timestamp
--encrypt_db4data.session_src_encrypted=encrypt_user_id,encrypt_pageview_id,encrypt_page_url,encrypt_referrer_url,encrypt_timestamp
--encrypt_db4tbl.tbl4view=encrypt_c0,encrypt_c1,encrypt_c2
--encrypt_db4data.tbl4builtinfuncs=col1,col2,col3



USE encrypt_db4data;
CREATE TABLE IF NOT EXISTS tbl4builtinfuncs (col1 STRING, col2 STRING, col3 STRING);
INSERT INTO tbl4builtinfuncs VALUES ('lower', 'ab', 'cd,ab,ef'), ('Mixed', 'ab,ef', 'cd,ab,ef'), ('UPPER', 'abc', 'cd,ab,ef');
SELECT repeat(col2,2) repeat, ascii(col1) ascii, lpad(col1, 12, col2) lpad, split(col3, ',') split, find_in_set(col2, col3) find_in_set FROM tbl4builtinfuncs;
DROP TABLE tbl4builtinfuncs;
