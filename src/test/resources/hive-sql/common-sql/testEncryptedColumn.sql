--encrypt_db4data.encrypt_import_export=encrypt_name,encrypt_salary
--encrypt_db4data.encrypt_tgt_import_export=encrypt_name,encrypt_salary

USE encrypt_db4data;

--without rights
SELECT * FROM encrypt_db4data.encrypt_import_export ORDER BY encrypt_name, encrypt_salary;
SELECT subordinates, deductions, address, country, state FROM encrypt_db4data.encrypt_import_export WHERE country='US' ORDER BY encrypt_name, encrypt_salary;
SELECT encrypt_name, encrypt_salary FROM encrypt_db4data.encrypt_import_export ORDER BY encrypt_name, encrypt_salary;

SET hive.support.quoted.identifiers=None;
SELECT `(subordinates|deductions|address|country|state|encrypt_name|encrypt_salary)` from encrypt_db4data.encrypt_import_export;

--with rights
SELECT * FROM encrypt_db4data.encrypt_tgt_import_export ORDER BY encrypt_name, encrypt_salary;
SELECT subordinates, deductions, address, country, state FROM encrypt_db4data.encrypt_tgt_import_export WHERE country='US' ORDER BY encrypt_name, encrypt_salary;
SELECT encrypt_name, encrypt_salary FROM encrypt_db4data.encrypt_tgt_import_export ORDER BY encrypt_name, encrypt_salary;

SELECT `(subordinates|deductions|address|country|state|encrypt_name|encrypt_salary)` from encrypt_db4data.encrypt_tgt_import_export;
