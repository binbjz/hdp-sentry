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
public class ServerDrop {
    private static final String className = TraceHandler.getSTElement(0, "className");
    private static final String jsonPath = SentryConstant.tSrc + File.separator + SentryConstant.jsonInput;
    private static final String jsonFile = jsonPath + File.separator + className + SentryConstant.suffix_json;
    private static final String hiveSqlPath = SentryConstant.tSrc + File.separator + className + File.separator + SentryConstant.hiveSqlSrc;
    private static final String hiveOutputPath = SentryConstant.tSrc + File.separator + className + File.separator + SentryConstant.hiveSqlOutput;
    private static final Logger logger = LoggerFactory.getLogger(className);


    @BeforeClass
    public static void setUp() {
        logger.debug("setUp ServerDrop......");

        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + " setup " + className;
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        logger.debug(UtilTool.arrToStr(sentryCmd));
        logger.debug("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));

        String hiveSh = SentryConstant.jSrc + File.separator + SentryConstant.hive_sh + " proxy_user " + "normal";
        String[] hiveCmd = {"/bin/bash", "-c", "source " + hiveSh};
        logger.debug(UtilTool.arrToStr(hiveCmd));
        logger.debug("exit code:\n" + UtilTool.execCommand(hiveCmd).get(0));
    }


    @Test
    @UseDataProvider("dataProviderServerDrop")
    public void testServerDrop(String id, String tag, String desc, String sqlType, String sqlFile, String
            resultType, String resultFile) {
        logger.debug("===============================================");
        logger.debug("ServerDrop--> running testcase: " + id);
        logger.debug("===============================================");
        String hiveSql = SentryConstant.hiveExec + " -f " + hiveSqlPath + File.separator + sqlFile;
        String[] sqlCmd = {"/bin/bash", "-c", hiveSql};
        logger.debug(UtilTool.arrToStr(sqlCmd));

        Map map = UtilTool.execCommand(sqlCmd);
        logger.debug("exit code:\n" + map.get(0).toString());
        logger.debug("command result:\n" + map.get(1).toString());

        //debug stage: write test results into output file.
        String hiveOutput = hiveOutputPath + File.separator + resultFile;
        logger.debug(hiveOutput);
        UtilTool.writeAllBytes(hiveOutput, map.get(1).toString());

        String expectedResults = UtilTool.readAllBytes(hiveOutput);
        String actualResults = map.get(1).toString();
        logger.debug("expectedResults: " + expectedResults);
        logger.debug("actualResults: " + actualResults);
        Assert.assertEquals(desc, expectedResults, actualResults);
    }


    @DataProvider
    public static Object[][] dataProviderServerDrop() {
        return DataProviderObj.dataGenerator(jsonFile);
    }


    @AfterClass
    public static void cleanUp() {
        logger.debug("cleanUp ServerDrop......");

        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + " clean " + className;
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        logger.debug("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));
    }
}
