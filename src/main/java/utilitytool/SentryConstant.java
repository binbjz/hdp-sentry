package utilitytool;

import java.io.File;
import java.nio.file.Paths;

public class SentryConstant {
    // Common vars
    public static final String wsPath = Paths.get(".").toAbsolutePath().normalize().toString();
    public static final String jSrc = Paths.get("src" + File.separator + "main" + File.separator + "resources").toAbsolutePath().toString();
    public static final String tSrc = Paths.get("src" + File.separator + "test" + File.separator + "resources").toAbsolutePath().toString();
    public static final String sqlOutput = "sql-output";
    public static final String suffix_json = ".json";
    public static final String hive_12 = "hive-1.2";
    public static final String spark_21 = "spark-2.1";
    public static final String spark_22 = "spark-2.2";


    // Define hive executor vars. If run hive sql please comment spark env statements.
    public static final String execSrc = File.separator + "opt" + File.separator + "meituan" + File.separator + hive_12 + File.separator + "bin" + File.separator + "hive";
    public static final String cmdExec = String.format("%s --hiveconf hive.cli.errors.ignore=true -f ", execSrc);
    public static final String sqlSrc = tSrc + File.separator + "hive-sql";
    public static final String commonSqlSrc = sqlSrc + File.separator + "common-sql";
    public static final String encryptColumnSqlSrc = sqlSrc + File.separator + "DBAllWithEncryptedColumns-sql";
    public static final String groupLoginSqlSrc = sqlSrc + File.separator + "GroupLogin-sql";
    public static final String stdOutput = "hive-output";
    public static final String jsonInput = "hive-json-input";

    /*
    // Define spark executor vars. If run spark sql please comment hive env statements.
    public static final String execSrc = File.separator + "opt" + File.separator + "meituan" + File.separator + spark_22 + File.separator + "bin" + File.separator + "spark-shell";
    public static final String hiveDataSrc = tSrc + File.separator + "source-data";
    public static final String cmdExec = String.format("%s --master yarn --deploy-mode client --queue root.hadoop-hdp.etltest --jars %s -i ", execSrc, hiveDataSrc + File.separator + "hive_qa_udf.jar");
    public static final String sqlSrc = tSrc + File.separator + "spark-sql";
    public static final String commonSqlSrc = sqlSrc + File.separator + "common-sql";
    public static final String encryptColumnSqlSrc = sqlSrc + File.separator + "DBAllWithEncryptedColumns-sql";
    public static final String groupLoginSqlSrc = sqlSrc + File.separator + "GroupLogin-sql";
    public static final String stdOutput = "spark-output";
    public static final String jsonInput = "spark-json-input";
    */
}
