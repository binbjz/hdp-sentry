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

    // Define hive executor vars. If run hive sql please comment spark env statements.
    public static final String execSrc = File.separator + "opt" + File.separator + "meituan" + File.separator + "hive-1.2" + File.separator + "bin" + File.separator + "hive";
    public static final String cmdExec = String.format("%s --hiveconf hive.cli.errors.ignore=true", execSrc);
    public static final String sqlSrc = tSrc + File.separator + "hive-sql";
    public static final String commonSqlSrc = sqlSrc + File.separator + "common-sql";
    public static final String encryptColumnSqlSrc = sqlSrc + File.separator + "DBAllWithEncryptedColumns-sql";
    public static final String groupLoginSqlSrc = sqlSrc + File.separator + "GroupLogin-sql";
    public static final String stdOutput = "hive-output";
    public static final String jsonInput = "hive-json-input";

    /*
    // Define spark executor vars. If run spark sql please comment hive env statements.
    public static final String execSrc = File.separator + "opt" + File.separator + "meituan" + File.separator + "spark-2.1-sentry" + File.separator + "bin" + File.separator + "spark-shell";
    public static final String cmdExec = String.format("%s --master yarn --deploy-mode client --queue root.hadoop-hdp.etltest", execSrc);
    public static final String sqlSrc = tSrc + File.separator + "spark-sql";
    public static final String commonSqlSrc = sqlSrc + File.separator + "common-sql";
    public static final String encryptColumnSqlSrc = sqlSrc + File.separator + "DBAllWithEncryptedColumns-sql";
    public static final String groupLoginSqlSrc = sqlSrc + File.separator + "GroupLogin-sql";
    public static final String stdOutput = "spark-output";
    public static final String jsonInput = "spark-json-input";
    */
}
