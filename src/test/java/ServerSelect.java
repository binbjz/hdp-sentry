import com.tngtech.java.junit.dataprovider.DataProvider;
import com.tngtech.java.junit.dataprovider.DataProviderRunner;
import com.tngtech.java.junit.dataprovider.UseDataProvider;
import eventhandling.DataProviderObj;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import utilitytool.SentryConstant;
import utilitytool.TraceHandler;
import utilitytool.UtilTool;

import java.io.File;
import java.util.Map;


@RunWith(DataProviderRunner.class)
public class ServerSelect {
    private static final String className = TraceHandler.getSTElement(0, "className");
    private static final String jsonPath = SentryConstant.tSrc + File.separator + SentryConstant.jsonInput;
    private static final String jsonFile = jsonPath + File.separator + className + SentryConstant.suffix_json;
    private static final String hiveSqlPath = SentryConstant.tSrc + File.separator + className + File.separator + SentryConstant.hiveSqlSrc;
    private static final String hiveOutputPath = SentryConstant.tSrc + File.separator + className + File.separator + SentryConstant.hiveSqlOutput;


    @BeforeClass
    public static void setUp() {
        System.out.println("setUp ServerSelect......");

        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + " setup " + className;
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        System.out.println(UtilTool.arrToStr(sentryCmd));
        System.out.println("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));

        String hiveSh = SentryConstant.jSrc + File.separator + SentryConstant.hive_sh + " proxy_user " + "normal";
        String[] hiveCmd = {"/bin/bash", "-c", "source " + hiveSh};
        System.out.println(UtilTool.arrToStr(hiveCmd));
        System.out.println("exit code:\n" + UtilTool.execCommand(hiveCmd).get(0));
    }


    @Test
    @UseDataProvider("dataProviderServerSelect")
    public void testServerAll(String id, String tag, String desc, String sqlType, String sqlFile, String
            resultType, String resultFile) {
        System.out.println("===============================================");
        System.out.println("ServerSelect--> running testcase: " + id);
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
//        UtilTool.writeAllBytes(hiveOutput, map.get(1).toString());

        String expectedResults = UtilTool.readAllBytes(hiveOutput);
        String actualResults = map.get(1).toString();
        System.out.println("expectedResults: " + expectedResults);
        System.out.println("actualResults: " + actualResults);
        Assert.assertEquals(desc, expectedResults, actualResults);
    }


    @DataProvider
    public static Object[][] dataProviderServerSelect() {
        return DataProviderObj.dataGenerator(jsonFile);
    }


    @AfterClass
    public static void cleanUp() {
        System.out.println("cleanUp ServerSelect......");

        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + " clean " + className;
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        System.out.println("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));
    }
}
