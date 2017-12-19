--encrypt_db4data.encrypt_import_export=encrypt_name,encrypt_salary
--encrypt_db4data.encrypt_tgt_import_export=encrypt_name,encrypt_salary

USE encrypt_db4data;

--without rights
SELECT * FROM encrypt_db4data.encrypt_import_export;
SELECT subordinates, deductions, address, country, state FROM encrypt_db4data.encrypt_import_export WHERE country='US';
SELECT encrypt_name, encrypt_salary FROM encrypt_db4data.encrypt_import_export;

--with rights
SELECT * FROM encrypt_db4data.encrypt_tgt_import_export;
SELECT subordinates, deductions, address, country, state FROM encrypt_db4data.encrypt_tgt_import_export WHERE country='US';
SELECT encrypt_name, encrypt_salary FROM encrypt_db4data.encrypt_tgt_import_export;
