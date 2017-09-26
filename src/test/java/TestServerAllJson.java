import org.junit.*;
import utilityTool.SentryConstant;
import utilityTool.TraceHandler;
import utilityTool.UtilTool;

import java.io.File;
import java.util.Map;


public class TestServerAllJson {

    /**
     *  Add role, group and privilege
     *
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r server_all
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r server_all -g server_all
     * /opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename server_all --privilege 'server=server1->action=all'
     */

    /**
     * Remove role, group and privilege
     *
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --revoke_privilege_role -r server_all -p 'server=server1->action=all'
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --delete_role_group -r server_all -g server_all
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --drop_role -r server_all
     */

    /**
     * Check role, group and privilege
     * <p>
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_role
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_role -g server_all
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_privilege -r server_all
     */

/*
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r hdp_qa
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r hdp_qa -g hdp_qa
/opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --rolename hdp_qa --privilege 'server=server1->action=all'

/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --revoke_privilege_role -r hdp_qa -p 'server=server1->action=all'
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --delete_role_group -r hdp_qa -g hdp_qa
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --drop_role -r hdp_qa

/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_role
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_role -g hdp_qa
/opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_privilege -r hdp_qa
*/
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

/*
CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
SHOW DATABASES LIKE 'test_db';
DROP DATABASE test_db;
SHOW DATABASES LIKE 'test_db';
*/

    @AfterClass
    public static void cleanUp() {
        System.out.println("cleanUp......");

        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + " clean " + TraceHandler.getSTElement(0, "className");
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        System.out.println("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));
    }
}
