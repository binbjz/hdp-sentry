import eventhandling.DataProviderObj;
import org.testng.*;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;
import utilitytool.SentryConstant;
import utilitytool.TraceHandler;
import utilitytool.UtilTool;

import java.io.File;
import java.util.Map;


public class ServerAll {
    private static final String className = TraceHandler.getSTElement(0, "className");
    private static final String jsonPath = SentryConstant.tSrc + File.separator + SentryConstant.jsonInput;
    private static final String jsonFile = jsonPath + File.separator + className + SentryConstant.suffix_json;


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


    @Test(dataProvider = "DataProvider_ServerAll")
    public void testServerAll(String id, String tag, String desc, String sqlType, String sqlFile, String resultType, String resultFile) {
        System.out.println("running testcase: " + id);
        String hiveSql = SentryConstant.hiveExec + " -f " + SentryConstant.tSrc + File.separator + TraceHandler.getSTElement(0, "className") + File.separator + SentryConstant.hiveSqlSrc + File.separator + sqlFile;
        String[] sqlCmd = {"/bin/bash", "-c", hiveSql};
        System.out.println(UtilTool.arrToStr(sqlCmd));

        Map map = UtilTool.execCommand(sqlCmd);
        System.out.println("exit code:\n" + map.get(0).toString());
        System.out.println("command result:\n" + map.get(1).toString());

        //debug stage: write test results into output file.
        String hiveOutput = SentryConstant.tSrc + File.separator + TraceHandler.getSTElement(0, "className") + File.separator + SentryConstant.hiveSqlOutput + File.separator + resultFile;
        System.out.println(hiveOutput);
//        UtilTool.writeAllBytes(hiveOutput, map.get(1).toString());

        String expectedResults = UtilTool.readAllBytes(hiveOutput);
        String actualResults = map.get(1).toString();
        System.out.println("expectedResults: " + expectedResults);
        System.out.println("actualResults: " + actualResults);
        Assert.assertEquals(desc, expectedResults, actualResults);
    }


    @DataProvider(name = "DataProvider_ServerAll")
    public Object[][] dataProviderServerAll() {
        return DataProviderObj.dataGenerator(jsonFile);
    }


    @AfterClass
    public static void cleanUp() {
        System.out.println("cleanUp......");

        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + " clean " + TraceHandler.getSTElement(0, "className");
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        System.out.println("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));
    }
}