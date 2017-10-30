package utilitytool;

import java.io.File;
import java.nio.file.Paths;

public class SentryConstant {
    public static final String wsPath = Paths.get(".").toAbsolutePath().normalize().toString();
    public static final String jSrc = Paths.get("src" + File.separator + "main" + File.separator + "resources").toAbsolutePath().toString();
    public static final String tSrc = Paths.get("src" + File.separator + "test" + File.separator + "resources").toAbsolutePath().toString();
    public static final String hiveSrc = File.separator + "opt" + File.separator + "meituan" + File.separator + "hive-1.2" + File.separator + "bin" + File.separator + "hive";
    public static final String hiveExec = String.format("%s --hiveconf hive.cli.errors.ignore=true", hiveSrc);
    public static final String hiveSqlSrc = tSrc + File.separator + "hive-sql";
    public static final String commonSqlSrc = tSrc + File.separator + "hive-sql" + File.separator + "common-sql";
    public static final String encryptColumnSqlSrc = tSrc + File.separator + "hive-sql" + File.separator + "DBAllWithEncryptedColumns-sql";
    public static final String groupLoginSqlSrc = tSrc + File.separator + "hive-sql" + File.separator + "GroupLogin-sql";
    public static final String hiveOutput = "hive-output";
    public static final String sqlOutput = "sql-output";
    public static final String jsonInput = "json-input";
    public static final String suffix_json = ".json";
}
