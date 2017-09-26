package utilityTool;

import java.nio.file.Paths;

public class SentryConstant {
    public static final String wsPath = Paths.get(".").toAbsolutePath().normalize().toString();
    public static final String jSrc = Paths.get("src/main/resources").toAbsolutePath().toString();
    public static final String tSrc = Paths.get("src/test/resources").toAbsolutePath().toString();
    public static final String hiveExec = "/opt/meituan/hive-1.2/bin/hive";
    public static final String hiveSqlSrc = "hive-sql";
    public static final String hiveSqlOutput = "hive-output";
    public static final String hiveDataSrc = "hive-data";
    public static final String hive_sh = "hive_env.sh";
    public static final String sentry_sh = "sentry_env.sh";
    public static final String suffix_sql = ".sql";
    public static final String suffix_output = ".txt";
}
