import com.tngtech.java.junit.dataprovider.DataProvider;
import com.tngtech.java.junit.dataprovider.DataProviderRunner;
import com.tngtech.java.junit.dataprovider.UseDataProvider;
import eventhandling.DataProviderObj;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import utilitytool.SentryConstant;
import utilitytool.TraceHandler;
import utilitytool.UtilTool;

import java.io.File;
import java.util.Map;


@RunWith(DataProviderRunner.class)
public class TableWrite {
    private static final String className = TraceHandler.getSTElement(0, "className");
    private static final String jsonPath = SentryConstant.tSrc + File.separator + SentryConstant.jsonInput;
    private static final String jsonFile = jsonPath + File.separator + className + SentryConstant.suffix_json;
    private static final String hiveSqlPath = SentryConstant.tSrc + File.separator + className + File.separator + SentryConstant.hiveSqlSrc;
    private static final String hiveOutputPath = SentryConstant.tSrc + File.separator + className + File.separator + SentryConstant.hiveSqlOutput;
    private static final Logger logger = LoggerFactory.getLogger(className);


    @BeforeClass
    public static void setUp() {
        logger.info("setUp TableWrite......");

        System.setProperty("log.base", SentryConstant.logPath);
        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + " setup " + className;
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        logger.info(UtilTool.arrToStr(sentryCmd));
        logger.info("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));

        String hiveSh = SentryConstant.jSrc + File.separator + SentryConstant.hive_sh + " proxy_user " + "normal";
        String[] hiveCmd = {"/bin/bash", "-c", "source " + hiveSh};
        logger.info(UtilTool.arrToStr(hiveCmd));
        logger.info("exit code:\n" + UtilTool.execCommand(hiveCmd).get(0));
    }


    @Test
    @UseDataProvider("dataProviderTableWrite")
    public void testTableWrite(String id, String tag, String desc, String sqlType, String sqlFile, String
            resultType, String resultFile) {
        logger.info("===============================================");
        logger.info("TableWrite--> running testcase: " + id);
        logger.info("===============================================");
        String hiveSql = SentryConstant.hiveExec + " -f " + hiveSqlPath + File.separator + sqlFile;
        String[] sqlCmd = {"/bin/bash", "-c", hiveSql};
        logger.info(UtilTool.arrToStr(sqlCmd));

        Map map = UtilTool.execCommand(sqlCmd);
        logger.info("exit code:\n" + map.get(0).toString());
        logger.info("command result:\n" + map.get(1).toString());

        //debug stage: write test results into output file.
        String hiveOutput = hiveOutputPath + File.separator + resultFile;
        logger.info(hiveOutput);
        UtilTool.writeAllBytes(hiveOutput, map.get(1).toString());

        String expectedResults = UtilTool.readAllBytes(hiveOutput);
        String actualResults = map.get(1).toString();
        logger.info("expectedResults: " + expectedResults);
        logger.info("actualResults: " + actualResults);
        Assert.assertEquals(desc, expectedResults, actualResults);
    }


    @DataProvider
    public static Object[][] dataProviderTableWrite() {
        return DataProviderObj.dataGenerator(jsonFile);
    }


    @AfterClass
    public static void cleanUp() {
        logger.info("cleanUp TableWrite......");

        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + " clean " + className;
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        logger.info(UtilTool.arrToStr(sentryCmd));
        logger.info("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));
    }
}
