import org.junit.*;
import utilityTool.SentryConstant;
import utilityTool.TraceHandler;
import utilityTool.UtilTool;

import java.io.File;
import java.util.Map;


public class TestServerAllJson {

    @BeforeClass
    public static void setUp() {
        System.out.println("setUp......");

        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + " setup " + TraceHandler.getSTElement(0, "className");
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        System.out.println("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));

        String hiveSh = SentryConstant.jSrc + File.separator + SentryConstant.hive_sh + " proxy_user";
        String[] hiveCmd = {"/bin/bash", "-c", "source " + hiveSh};
        System.out.println("exit code:\n" + UtilTool.execCommand(hiveCmd).get(0));
    }

    //Pass
    @Test
//    @Ignore
    /**
     * test CREATE DATABASE
     *      DROP DATABASE
     *      SHOW DATABASES
     *
     * DROP DATABASE IF EXISTS test_db CASCADE;
     * CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
     * SHOW DATABASES LIKE 'test_db';
     * DROP DATABASE test_db;
     * SHOW DATABASES LIKE 'test_db';
     */
    public void testCreateDropDB() {
        String hiveSql = SentryConstant.hiveExec + " -f " + SentryConstant.tSrc + File.separator + TraceHandler.getSTElement(0, "className") + File.separator + SentryConstant.hiveSqlSrc + File.separator + TraceHandler.getSTElement(0, "methodName") + SentryConstant.suffix_sql;
        String[] sqlCmd = {"/bin/bash", "-c", hiveSql};
        System.out.println(UtilTool.arrToStr(sqlCmd));

        Map map = UtilTool.execCommand(sqlCmd);
        System.out.println("exit code:\n" + map.get(0).toString());
//        System.out.println("command result:\n" + map.get(1).toString());

        //debug stage: write test results into output file.
        String hiveOutput = SentryConstant.tSrc + File.separator + TraceHandler.getSTElement(0, "className") + File.separator + SentryConstant.hiveSqlOutput + File.separator + TraceHandler.getSTElement(0, "methodName") + SentryConstant.suffix_output;
//        System.out.println(hiveOutput);
//        utilityTool.UtilTool.writeAllBytes(hiveOutput, map.get(1).toString());

        String expectedResults = UtilTool.readAllBytes(hiveOutput);
        String actualResults = map.get(1).toString();
        Assert.assertEquals(expectedResults, actualResults);
    }


    @AfterClass
    public static void cleanUp() {
        System.out.println("cleanUp......");

        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + " clean " + TraceHandler.getSTElement(0, "className");
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        System.out.println("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));
    }
}
