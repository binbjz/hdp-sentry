import eventhandling.DataProviderObj;
import org.testng.*;
import org.testng.annotations.*;
import utilitytool.SentryConstant;
import utilitytool.TraceHandler;
import utilitytool.UtilTool;

import java.io.File;
import java.util.Map;


public class DBSelect {
    private static final String className = TraceHandler.getSTElement(0, "className");
    private static final String jsonPath = SentryConstant.tSrc + File.separator + SentryConstant.jsonInput;
    private static final String jsonFile = jsonPath + File.separator + className + SentryConstant.suffix_json;
    private static final String hiveSqlPath = SentryConstant.tSrc + File.separator + className + File.separator + SentryConstant.hiveSqlSrc;
    private static final String hiveOutputPath = SentryConstant.tSrc + File.separator + className + File.separator + SentryConstant.hiveSqlOutput;

    @BeforeClass
    public static void setUp() {
        System.out.println("preSetUp DBSelect......");
        String preSql = String.format("prepare%s.sql", className);
        UtilTool.privilHandler(className, preSql, "setup");

        System.out.println("setUp DBSelect......");
        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + " setup " + className;
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        System.out.println(UtilTool.arrToStr(sentryCmd));
        System.out.println("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));

        String hiveSh = SentryConstant.jSrc + File.separator + SentryConstant.hive_sh + " proxy_user";
        String[] hiveCmd = {"/bin/bash", "-c", "source " + hiveSh};
        System.out.println(UtilTool.arrToStr(hiveCmd));
        System.out.println("exit code:\n" + UtilTool.execCommand(hiveCmd).get(0));
    }


    @Test(dataProvider = "DataProvider_DBSelect")
    public void testDBInsert(String id, String tag, String desc, String sqlType, String sqlFile, String
            resultType, String resultFile) {
        System.out.println("===============================================");
        System.out.println("DBSelect--> running testcase: " + id);
        System.out.println("===============================================");
        String hiveSql = SentryConstant.hiveExec + " -f " + hiveSqlPath + File.separator + sqlFile;
        String[] sqlCmd = {"/bin/bash", "-c", hiveSql};
        System.out.println(UtilTool.arrToStr(sqlCmd));

        Map map = UtilTool.execCommand(sqlCmd);
        System.out.println("exit code:\n" + map.get(0).toString());
        System.out.println("command result:\n" + map.get(1).toString());

        //debug stage: write test results into output file.
        String hiveOutput = hiveOutputPath + File.separator + resultFile;
        System.out.println(hiveOutput);
        UtilTool.writeAllBytes(hiveOutput, map.get(1).toString());

        String expectedResults = UtilTool.readAllBytes(hiveOutput);
        String actualResults = map.get(1).toString();
        System.out.println("expectedResults: " + expectedResults);
        System.out.println("actualResults: " + actualResults);
        Assert.assertEquals(expectedResults, actualResults, desc);
    }


    @DataProvider(name = "DataProvider_DBSelect")
    public Object[][] dataProviderDBInsert() {
        return DataProviderObj.dataGenerator(jsonFile);
    }


    @AfterClass
    public static void cleanUp() {

        System.out.println("cleanUp DBSelect......");
        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + " clean " + className;
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        System.out.println(UtilTool.arrToStr(sentryCmd));
        System.out.println("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));

        System.out.println("postCleanUp DBSelect......");
        String preSql = String.format("post%s.sql", className);
        UtilTool.privilHandler(className, preSql, "clean");
    }
}
