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
public class ServerAlter {
    private static final String className = TraceHandler.getSTElement(0, "className");
    private static final String jsonPath = SentryConstant.tSrc + File.separator + SentryConstant.jsonInput;
    private static final String jsonFile = jsonPath + File.separator + className + SentryConstant.suffix_json;
    private static final String sqlOutputPath = SentryConstant.tSrc + File.separator + SentryConstant.stdOutput + File.separator + className + File.separator + SentryConstant.sqlOutput;
    private static final Logger logger = LoggerFactory.getLogger(className);

    @BeforeClass
    public static void setUp() {
        logger.info("setUp " + className + "......");
    }


    @Test
    @UseDataProvider("dataProviderServerAlter")
    public void testServerAlter(String id, String tag, String desc, String sqlType, String sqlFile, String
            resultType, String resultFile) {
        logger.info("===============================================");
        logger.info("ServerAlter--> running testcase: " + id);
        logger.info("===============================================");
        String hiveSql = SentryConstant.cmdExec + SentryConstant.commonSqlSrc + File.separator + sqlFile;
        String[] sqlCmd = {"/bin/bash", "-c", hiveSql};
        logger.info(UtilTool.arrToStr(sqlCmd));

        Map map = UtilTool.execCommand(sqlCmd);

        //debug stage: write test results into output file.
        String output = sqlOutputPath + File.separator + resultFile;
        //UtilTool.writeAllBytes(output, map.get(1).toString());

        String expectedResults = UtilTool.readAllBytes(output);
        String actualResults = map.get(1).toString();
//        logger.info("expectedResults: " + expectedResults);
        logger.info("actualResults: " + actualResults);
        Assert.assertEquals(desc, expectedResults, actualResults);
    }


    @DataProvider
    public static Object[][] dataProviderServerAlter() {
        return DataProviderObj.dataGenerator(jsonFile);
    }


    @AfterClass
    public static void cleanUp() {
        logger.info("cleanUp " + className + "......");
    }
}
