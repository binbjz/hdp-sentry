//encrypt_db4data.encrypt_import_export=encrypt_name,encrypt_salary
//encrypt_db4data.encrypt_tgt_import_export=encrypt_name,encrypt_salary


val test_sql="USE encrypt_db4data";
spark.sql(test_sql).collect().foreach(println);

//without rights
val test_sql="SELECT * FROM encrypt_db4data.encrypt_import_export ORDER BY encrypt_name, encrypt_salary";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT subordinates, deductions, address, country, state FROM encrypt_db4data.encrypt_import_export WHERE country='US' ORDER BY encrypt_name, encrypt_salary";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT encrypt_name, encrypt_salary FROM encrypt_db4data.encrypt_import_export ORDER BY encrypt_name, encrypt_salary";
spark.sql(test_sql).collect().foreach(println);

//with rights
val test_sql="SELECT * FROM encrypt_db4data.encrypt_tgt_import_export ORDER BY encrypt_name, encrypt_salary";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT subordinates, deductions, address, country, state FROM encrypt_db4data.encrypt_tgt_import_export WHERE country='US' ORDER BY encrypt_name, encrypt_salary";
spark.sql(test_sql).collect().foreach(println);
val test_sql="SELECT encrypt_name, encrypt_salary FROM encrypt_db4data.encrypt_tgt_import_export ORDER BY encrypt_name, encrypt_salary";
spark.sql(test_sql).collect().foreach(println);
