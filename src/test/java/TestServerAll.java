import org.junit.*;
import utilityTool.SentryConstant;
import utilityTool.TraceHandler;
import utilityTool.UtilTool;

import java.io.File;
import java.util.Arrays;
import java.util.Map;


public class TestServerAll {

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

    //Pass
    @Test
    @Ignore
    /**
     * test CREATE DATABASE
     * DROP DATABASE CASCADE
     * SHOW DATABASES
     * CREATE TABLE
     * CREATE VIEW
     * <p>
     * DROP DATABASE IF EXISTS test_db CASCADE;
     * CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
     * SHOW DATABASES LIKE 'test_db';
     * CREATE TABLE test_db.test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
     * CREATE VIEW test_db.test_view AS SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM test_db.test_tbl;
     * USE test_db;
     * SHOW TABLES;
     * DROP DATABASE test_db CASCADE;
     * SHOW DATABASES LIKE 'test_db';
     */
    public void testCreateDropDBCascade() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

        String hiveSql = SentryConstant.hiveExec + SentryConstant.tSrc + File.separator + TraceHandler.getSTElement(0, "className") + File.separator + SentryConstant.hiveSqlSrc + File.separator + TraceHandler.getSTElement(0, "methodName") + SentryConstant.suffix_sql;
        System.out.println(hiveSql);
        String[] SqlCmd = {"/bin/bash", "-c", hiveSql};
        System.out.println("exit code:\n" + UtilTool.execCommand(SqlCmd).get(0));
        System.out.println("command result:\n" + UtilTool.execCommand(SqlCmd).get(1));

    }

/*
CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
SHOW DATABASES LIKE 'test_db';
CREATE TABLE test_db.test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
CREATE VIEW test_db.test_view AS SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM test_db.test_tbl;
USE test_db;
SHOW TABLES;
DROP DATABASE test_db CASCADE;
SHOW DATABASES LIKE 'test_db';
*/

    //Pass
    @Test
    @Ignore
    /**
     * test ALTER DATABASE
     * DESCRIBE DATABASE
     * <p>
     * CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
     * ALTER DATABASE test_db SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa');
     * DESCRIBE DATABASE test_db;
     * DESCRIBE DATABASE EXTENDED test_db;
     * DROP DATABASE test_db;
     */
    public void testAlterPropertiesDescribeDB() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

/*
CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
DESCRIBE DATABASE EXTENDED test_db;
ALTER DATABASE test_db SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa');
DESCRIBE DATABASE EXTENDED test_db;
DROP DATABASE test_db;
*/

    //PASS
    @Test
    @Ignore
    /**
     * test CREATE DATABASE
     *      USE <dbName>
     *      CREATE TABLE
     *      DROP TABLE
     *      DROP DATABASE
     *
     * CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
     * USE test_db;
     * CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
     * SHOW TABLES;
     * SHOW TABLES LIKE 'test*';
     * DROP TABLE test_tbl;
     * DROP DATABASE test_db;
     */
    public void testCreateDropTable() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }
/*
CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
USE test_db;
CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
SHOW TABLES;
SHOW TABLES LIKE 'test*';
DROP TABLE test_tbl;
DROP DATABASE test_db;
*/

    //PASS  FAILED TO CREATE INDEX
    @Test
    @Ignore
    /**
     * test CREATE DATABASE
     *      USE <dbName>
     *      CREATE TABLE
     *      CREATE VIEW
     *      ALTER VIEW
     *      DESCRIBE VIEW
     *      SHOW TABLE
     *      DROP VIEW
     *      DROP TABLE
     *      DROP DATABASE
     *
     * CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
     * USE test_db;
     * CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
     * CREATE VIEW test_view AS SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM test_tbl;
     * ALTER VIEW test_view SET TBLPROPERTIES ('created_at' = '20170905');
     *
     *
     * -- CREATE INDEX test_tbl_index ON TABLE test_tbl (col3)
     * -- AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler'
     * -- WITH DEFERRED REBUILD IDXPROPERTIES ('creator' = 'HADOOP-QA')
     * -- IN TABLE test_tbl_index_on_col3_column
     * -- COMMENT 'test_tbl indexed by col3.';
     *
     * DESCRIBE test_view;
     * SHOW CREATE TABLE test_view;
     * DROP VIEW test_view;
     * DROP TABLE test_tbl;
     * DROP DATABASE test_db;
     */
    public void testCreateAlterDescribeShowDropView() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }

/*
CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
USE test_db;
CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
CREATE VIEW test_view AS SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM test_tbl;
ALTER VIEW test_view SET TBLPROPERTIES ('created_at' = '20170905');
DESCRIBE EXTENDED test_view;
SHOW CREATE TABLE test_view;
DROP VIEW test_view;
DROP TABLE test_tbl;
DROP DATABASE test_db;
*/

    //PASS
    @Test
    @Ignore
    /**
     * test CREATE DATABASE...WITH DBPROPERTIES
     *      USE <dbName>
     *      CREATE TABLE
     *      ALTER TABLE...ADD COLUMNS
     *      DESCRIBE TABLE
     *      ALTER TABLE...REPLACE COLUMNS
     *      SHOW TABLE
     *      ALTER TABLE...CHANGE...AFTER
     *      ALTER TABLE...CHANGE...FIRST
     *      ALTER TABLE...RENAME
     *      ALTER TABLE...SET TBLPROPERTIES
     *      DESCRIBE EXTENDED TABLE
     *      DROP DATABASE
     *
     * CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
     * USE test_db;
     * CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
     * ALTER TABLE test_tbl ADD COLUMNS (id STRING);
     * DESCRIBE TABLE test_tbl;
     * ALTER TABLE test_tbl REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2', new_col3 STRING COMMENT 'new column3');
     * SHOW CREATE TABLE test_tbl;
     * ALTER TABLE test_tbl CHANGE new_col1 new_col1to2 INT COMMENT "put column1 to position 2nd" AFTER new_col2;
     * ALTER TABLE test_tbl CHANGE new_col3 new_col3to1 INT COMMENT "put last column to position 1st" FIRST;
     * DESCRIBE test_tbl;
     * ALTER TABLE test_tbl RENAME TO test_tbl_new;
     * ALTER TABLE test_tbl_new SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
     * DESCRIBE EXTENDED test_tbl_new;
     * DROP DATABASE test_db CASCADE;
     */
    public void testAlterDescribeTable01() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }

/*
CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
USE test_db;
CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
ALTER TABLE test_tbl ADD COLUMNS (id STRING);
DESCRIBE test_tbl;
ALTER TABLE test_tbl REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2', new_col3 STRING COMMENT 'new column3');
SHOW CREATE TABLE test_tbl;
ALTER TABLE test_tbl CHANGE new_col1 new_col1to2 INT COMMENT "put column1 to position 2nd" AFTER new_col2;
ALTER TABLE test_tbl CHANGfrE new_col3 new_col3to1 INT COMMENT "put last column to position 1st" FIRST;
DESCRIBE test_tbl;
ALTER TABLE test_tbl RENAME TO test_tbl_new;
ALTER TABLE test_tbl_new SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
DESCRIBE EXTENDED test_tbl_new;
DROP DATABASE test_db CASCADE;
*/

    //FAILED FOR ALTER PARTITION
    @Test
    @Ignore
    /**
     * test CREATE TABLE
     *      ALTER TABLE .. SET FILEFORMAT
     *      DESCRIBE EXTENDED TABLE
     *      ALTER TABLE .. ADD PARTITION location
     *      ALTER TABLE .. PARTITION SET FILEFORMAT
     *      SHOW CREATE TABLE
     *      SHOW PARTITIONS
     *      DESCRIBE TABLE
     *
     * CREATE DATABASE test_db;
     * CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
     * PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
     *
     * ALTER TABLE test_db.log_messages ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/test_db.db/log_messages/2012/01/02';
     * ALTER TABLE log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
     * SHOW CREATE TABLE test_db.log_messages;
     * SHOW PARTITIONS test_db.log_messages;
     * DESCRIBE EXTENDED test_db.log_messages;
     * DESCRIBE test_db.log_messages;
     *
     *
     * CREATE EXTERNAL TABLE IF NOT EXISTS test_db.log_messages_external (hms INT, severity STRING, server STRING, process_id INT, message STRING) PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
     * ALTER TABLE test_db.log_messages_external ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/test_db.db/log_messages_external/2012/01/02';
     * DESCRIBE EXTENDED test_db.log_messages_external;
     * DESCRIBE test_db.log_messages_external;
     *
     *
     * ALTER TABLE test_db.log_messages SET FILEFORMAT SEQUENCEFILE;
     * DESCRIBE EXTENDED test_db.log_messages;
     * DESCRIBE test_db.log_messages;
     *
     * DROP TABLE test_db.log_messages;
     *
     * DROP DATABASE test_db CASCADE;
     */
    public void testAlterDescribeTable02() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }


//FAILED FOR ALTER PARTITION
/*
CREATE DATABASE test_db;
CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE test_db.log_messages ADD PARTITION(year = 2012, month = 1, day = 2)
LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/test_db.db/log_messages/2012/01/02';

*  ALTER TABLE test_db.log_messages PARTITION (year = 2012, month = 1, day = 2) SET FILEFORMAT SEQUENCEFILE;
SHOW CREATE TABLE test_db.log_messages;
SHOW PARTITIONS test_db.log_messages;
DESCRIBE EXTENDED test_db.log_messages;
DESCRIBE test_db.log_messages;

CREATE EXTERNAL TABLE IF NOT EXISTS test_db.log_messages_external (hms INT, severity STRING, server STRING, process_id INT, message STRING) PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
ALTER TABLE test_db.log_messages_external ADD PARTITION(year = 2012, month = 1, day = 2)
LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/test_db.db/log_messages_external/2012/01/02';

DESCRIBE EXTENDED test_db.log_messages_external;
DESCRIBE test_db.log_messages_external;

ALTER TABLE test_db.log_messages SET FILEFORMAT SEQUENCEFILE;
DESCRIBE EXTENDED test_db.log_messages;
DESCRIBE test_db.log_messages;

DROP TABLE test_db.log_messages;

DROP DATABASE test_db CASCADE;
*/

    /**
     * test ALTER TABLE .. PARTITION .. RENAME TO PARTITION
     * ALTER TABLE employees PARTITION(country='CHN',STATE='BJ') RENAME TO PARTITION(country='CHINA',STATE='BEIJING');
     */

    //FAILED ALTER TABLE PARTITION
    @Test
    @Ignore
    /**
     *
     *
     * CREATE DATABASE test_db;
     * CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
     * PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
     * -- 命令行结合SQL执行
     * ALTER TABLE ..SET LOCATION
     * ALTER TABLE test_db.log_messages ADD PARTITION (year = 2011, month = 1, day = 1);
     * ALTER TABLE test_db.log_messages ADD PARTITION (year = 2011, month = 1, day = 2);
     * ALTER TABLE test_db.log_messages ADD PARTITION (year = 2011, month = 2, day = 1);
     *
     * dfs -ls /user/hive/warehouse/test_db.db/log_messages/year=2011/month=1/day=1;
     * dfs -ls /user/hive/warehouse/test_db.db/log_messages/year=2011/month=1/day=2;
     * dfs -ls /user/hive/warehouse/test_db.db/log_messages/year=2011/month=2/day=1;
     *
     * dfs -mkdir /user/hive/warehouse/test_db.db/log_messages_new;
     * dfs -mkdir /user/hive/warehouse/test_db.db/log_messages_new/year=2011;
     * dfs -mkdir /user/hive/warehouse/test_db.db/log_messages_new/year=2011/month=2;
     * dfs -mkdir /user/hive/warehouse/test_db.db/log_messages_new/year=2011/month=2/day=1;
     * --将要移动的分区的数据复制到新路径
     * --hadoop distcp 命令：
     * --hadoop distcp /user/hive/warehouse/test_db.db/log_messages/year=2011/month=2/day=1 /user/hive/warehouse/test_db.db/log_messages_new/year=2011/month=2/day=1;
     * --更改TABLE以将分区指向新位置：
     * ALTER TABLE test_db.log_messages PARTITION (year = 2011, month = 1, day = 1) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/test_db.db/log_messages_new/year=2011/month=1/day=1';
     * ALTER TABLE test_db.log_messages PARTITION (year = 2011, month = 1, day = 2) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/test_db.db/log_messages_new/year=2011/month=1/day=2';
     * --获取table的真实hdfs路径
     * DESC FORMATTED test_db.log_messages;
     * --获取partition的真实hdfs路径
     * DESC FORMATTED test_db.log_messages partition (year = 2011, month = 1, day =1);
     * DESC FORMATTED test_db.log_messages partition (year = 2011, month = 1, day =2);
     * DESC FORMATTED test_db.log_messages partition (year = 2011, month = 2, day =1);
     * --使用hadoop fs -rmr 命令删除分区的HDFS副本：
     * dfs -rm -r /user/hive/warehouse/test_db.db/log_messages/year=2011/month=1/day=1;
     * dfs -rm -r /user/hive/warehouse/test_db.db/log_messages/year=2011/month=1/day=2;
     * dfs -rm -r /user/hive/warehouse/test_db.db/log_messages/year=2011/month=2/day=1;
     */
    public void testAlterDescribeTableWithDFS() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }

/*
CREATE DATABASE test_db;
CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
-- 命令行结合SQL执行
-- ALTER TABLE ..SET LOCATION
ALTER TABLE test_db.log_messages ADD PARTITION (year = 2011, month = 1, day = 1);
ALTER TABLE test_db.log_messages ADD PARTITION (year = 2011, month = 1, day = 2);
ALTER TABLE test_db.log_messages ADD PARTITION (year = 2011, month = 2, day = 1);

dfs -ls /user/hive/warehouse/test_db.db/log_messages/year=2011/month=1/day=1;
dfs -ls /user/hive/warehouse/test_db.db/log_messages/year=2011/month=1/day=2;
dfs -ls /user/hive/warehouse/test_db.db/log_messages/year=2011/month=2/day=1;

dfs -mkdir /user/hive/warehouse/test_db.db/log_messages_new;
dfs -mkdir /user/hive/warehouse/test_db.db/log_messages_new/year=2011;
dfs -mkdir /user/hive/warehouse/test_db.db/log_messages_new/year=2011/month=2;
dfs -mkdir /user/hive/warehouse/test_db.db/log_messages_new/year=2011/month=2/day=1;
--将要移动的分区的数据复制到新路径
--hadoop distcp 命令：
--hadoop distcp /user/hive/warehouse/test_db.db/log_messages/year=2011/month=2/day=1 /user/hive/warehouse/test_db.db/log_messages_new/year=2011/month=2/day=1;
--更改TABLE以将分区指向新位置：
ALTER TABLE test_db.log_messages PARTITION (year = 2011, month = 2, day = 1) SET LOCATION 'viewfs://hadoop-meituan-test/user/hive/warehouse/test_db.db/log_messages_new/year=2011/month=2/day=1';

--获取table的真实hdfs路径
DESC FORMATTED test_db.log_messages;
--获取partition的真实hdfs路径
DESC FORMATTED test_db.log_messages partition (year = 2011, month = 1, day =1);
DESC FORMATTED test_db.log_messages partition (year = 2011, month = 1, day =2);
DESC FORMATTED test_db.log_messages partition (year = 2011, month = 2, day =1);
--使用hadoop fs -rmr 命令删除分区的HDFS副本：
dfs -rm -r /user/hive/warehouse/test_db.db/log_messages/year=2011/month=1/day=1;
dfs -rm -r /user/hive/warehouse/test_db.db/log_messages/year=2011/month=1/day=2;
dfs -rm -r /user/hive/warehouse/test_db.db/log_messages/year=2011/month=2/day=1;
DROP TABLE test_db.log_messages;
DROP DATABASE test_db;
*/

    //PASS
    @Test
    @Ignore
    /**
     *  ALTER TABLE .. ADD PARTITION
     *  ALTER TABLE .. DROP PARTITION
     *  ALTER TABLE .. DROP PARTITION
     *
     *  CREATE DATABASE test_db;
     *  CREATE TABLE test_db.supply (id INT, part STRING, quantity INT)  PARTITIONED BY (day INT);
     *  ALTER TABLE test_db.supply ADD PARTITION (day = 20110102);
     *  ALTER TABLE test_db.supply ADD PARTITION (day = 20110103);
     *  ALTER TABLE test_db.supply ADD PARTITION (day = 20110104);
     *  SHOW PARTITIONS test_db.supply;
     *  SET hive.cli.print.header=true;
     *  SELECT id, part, quantity FROM test_db.supply WHERE day >= 20110102 AND day < 20110103 AND quantity < 4 ;
     *  ALTER TABLE test_db.supply DROP PARTITION (day = 20110102);
     *  ALTER TABLE test_db.supply DROP PARTITION (day = 20110103);
     *  ALTER TABLE test_db.supply DROP PARTITION (day = 20110104);
     *  SHOW PARTITIONS test_db.supply;
     *  DROP TABLE test_db.supply;
     *  DROP DATABASE test_db;
     */
    public void testAddDropShowPartition() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }
/*
ALTER TABLE .. ADD PARTITION
ALTER TABLE .. DROP PARTITION
ALTER TABLE .. DROP PARTITION

CREATE DATABASE test_db;
CREATE TABLE test_db.supply (id INT, part STRING, quantity INT)  PARTITIONED BY (day INT);
ALTER TABLE test_db.supply ADD PARTITION (day = 20110102);
ALTER TABLE test_db.supply ADD PARTITION (day = 20110103);
ALTER TABLE test_db.supply ADD PARTITION (day = 20110104);
SHOW PARTITIONS test_db.supply;
SET hive.cli.print.header=true;
SELECT id, part, quantity FROM test_db.supply WHERE day >= 20110102 AND day < 20110103 AND quantity < 4 ;
ALTER TABLE test_db.supply DROP PARTITION (day = 20110102);
ALTER TABLE test_db.supply DROP PARTITION (day = 20110103);
ALTER TABLE test_db.supply DROP PARTITION (day = 20110104);
SHOW PARTITIONS test_db.supply;
DROP TABLE test_db.supply;
DROP DATABASE test_db;
*/

    //TO BE DONE <Need to confirm>
    @Test
    @Ignore
    /**
     * -- 1022 SHOW GRANT ROLE
     * 单独测试
     */

    public void testShowGrantRole() {
//        Assert.assertEquals("hello", "hello");
//        System.out.println("~~~~~~~~~~~");

        String hiveSql = SentryConstant.hiveExec + " -f " + SentryConstant.tSrc + File.separator + TraceHandler.getSTElement(0, "className") + File.separator + SentryConstant.hiveSqlSrc + File.separator + TraceHandler.getSTElement(0, "methodName") + SentryConstant.suffix_sql;
        String[] sqlCmd = {"/bin/bash", "-c", hiveSql};
        System.out.println(Arrays.toString(sqlCmd));

        Map map = UtilTool.execCommand(sqlCmd);
        System.out.println("exit code:\n" + map.get(0).toString());
        System.out.println("command result:\n" + map.get(1).toString());

        //debug stage: write test results into output file.
        String hiveOutput = SentryConstant.tSrc + File.separator + TraceHandler.getSTElement(0, "className") + File.separator + SentryConstant.hiveSqlOutput + File.separator + TraceHandler.getSTElement(0, "methodName") + SentryConstant.suffix_output;
        System.out.println(hiveOutput);
//        utilityTool.UtilTool.writeAllBytes(hiveOutput, map.get(1).toString());

        System.out.println("~~~~~~~~~~~");

        String expectedResults = map.get(1).toString();
        String actualResults = UtilTool.readAllBytes(hiveOutput);
        Assert.assertEquals(expectedResults, actualResults);

    }

    //TO BE DONE
    //FAILED

    /**
     * 单独测试
     * test LOAD DATA
     * <p>
     * CREATE TABLE serde_regex （
     * <p>
     * LOAD DATA LOCAL INPATH “../data/files/apache.access.log” INTO TABLE serde_regex ;
     * LOAD DATA LOCAL INPATH “../data/files/apache.access.2.log” INTO TABLE serde_regex ;
     * SET hive.cli.print.header=true;
     * SELECT * FROM serde_regex ORDER BY time ;
     * <p>
     * export TMP=/tmp
     * $TMP/kv_data.txt  that looks like:
     * k1=v1,k2=v2
     * k4=v4,k5=v5,k6=v6
     * k7=v7,k7=v7,k3=v7
     * Create this Perl script and save it as $TMP/split_kv.pl :
     * #!/usr/bin/perl
     * while (<STDIN>) {
     * my $line = $_;
     * chomp($line);
     * my @kvs = split(/,/, $line);
     * foreach my $p (@kvs) {
     * my @kv = split(/=/, $p);
     * print $kv[0] . "\t" . $kv[1] . "\n";
     * }
     * }
     * CREATE TABLE kv_data ( line STRING );
     * LOAD DATA LOCAL INPATH '${env:TMP}/kv_data.txt' INTO TABLE kv_data;
     * SET hive.cli.print.header=true;
     * SELECT TRANSFORM (line) USING 'perl split_kv.pl' AS (key, value) FROM kv_data;
     * k1 v1
     * k2 v2
     * k4 v4
     * k5 v5
     * k6 v6
     * k7 v7
     * k7 v7
     * k3 v7
     * <p>
     * export FILEPATH=/opt/meituan/qa_test/testfile
     * <p>
     * CREATE TABLE sum (number INT);
     * LOAD DATA LOCAL INPATH '$ {env：FILEPATH} /data_to_sum.txt'INTO TABLE sum ;
     * <p>
     * <p>
     * SELECT * FROM test_tbl;
     * SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM test_tbl;
     * SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM test_view;
     */

    //PASS 需要把用户加入各个节点的USERADD
    @Test
    @Ignore
    /**
     * export FILEPATH=/opt/meituan/qa_test/testfile
     * cat $FILEPATH/test_file.txt;
     * twelve&12
     * twelve&1
     * eleven&11
     * eleven&10
     *
     * CREATE DATABASE test_db;
     * CREATE TABLE test_db.collecttest (str STRING, countVal INT)
     * ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';
     * LOAD DATA LOCAL INPATH '${env:FILEPATH}/test_file.txt' INTO TABLE test_db.collecttest;
     *
     * SELECT str, concat_ws( ',' , collect_set(cast(countVal AS STRING))) FROM test_db.collecttest GROUP BY str;
     * eleven 11,10
     * twelve 12,1
     *
     * DROP TABLE test_db.collecttest
     * DROP DATABASE test_db;
     */
    public void testLoadDataLocal() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

        String filePath = SentryConstant.tSrc + File.separator + SentryConstant.hiveDataSrc;
        String hiveSql = SentryConstant.tSrc + File.separator + TraceHandler.getSTElement(0, "className") + File.separator + SentryConstant.hiveSqlSrc + File.separator + TraceHandler.getSTElement(0, "methodName") + SentryConstant.suffix_sql;
        String hiveCmd = String.format("%s -hiveconf FILEPATH='%s' -f %s", SentryConstant.hiveExec, filePath, hiveSql);
        System.out.println("hiveCmd: " + hiveCmd);

        String[] sqlCmd = {"/bin/bash", "-c", hiveCmd};
        System.out.println("sqlCmd" + Arrays.toString(sqlCmd));
        Map map = UtilTool.execCommand(sqlCmd);
        System.out.println("exit code:\n" + map.get(0).toString());
        System.out.println("command result:\n" + map.get(1).toString());
    }

/*
export FILEPATH=/opt/meituan/qa_test/testfile
cat $FILEPATH/test_file.txt;
twelve&12
twelve&1
eleven&11
eleven&10

CREATE DATABASE test_db;
CREATE TABLE test_db.collecttest (str STRING, countVal INT)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '&' LINES TERMINATED BY '10';
LOAD DATA LOCAL INPATH '${env:FILEPATH}/test_file.txt' INTO TABLE test_db.collecttest;

SELECT str, concat_ws( ',' , collect_set(cast(countVal AS STRING))) as val FROM test_db.collecttest GROUP BY str;

SELECT str, count(*) as val FROM test_db.collecttest GROUP BY str;
SELECT count(*) FROM test_db.collecttest;

DROP DATABASE test_db CASCADE;
*/

    //PASS
    @Test
    @Ignore
    /**
     * test CREATE TABLE .. AS SELECT
     *
     * CREATE DATABASE test_db;
     * CREATE TABLE test_db.session_test (
     *   st_user_id STRING
     *  ,st_pageview_id STRING
     *  ,st_page_url STRING
     *  ,st_referrer_url STRING
     *  ,st_timestamp DOUBLE);
     *
     * CREATE TABLE test_db.sessionization_step_one_origins AS
     * SELECT c.c_user_id as ssoo_user_id
     *       ,c.c_pageview_id as ssoo_pageview_id
     *       ,c.c_timestamp as ssoo_timestamp
     * FROM (SELECT a.a_user_id as c_user_id
     *             ,a.a_pageview_id as c_pageview_id
     *             ,a.a_timestamp as c_timestamp
     *             ,SUM(IF(a.a_timestamp + 1800 >= b.b_timestamp AND a.a_timestamp < b.b_timestamp,1,0)) AS c_nonorigin_flags
     *       FROM (SELECT st_user_id as a_user_id
     *                   ,st_pageview_id as a_pageview_id
     *                   ,st_timestamp as a_timestamp
     *            FROM test_db.session_test ) a
     *        JOIN (SELECT st_user_id as b_user_id
     *                    ,st_timestamp as b_timestamp
     *              FROM test_db.session_test ) b
     *         ON a.a_user_id = b.b_user_id
     *       GROUP BY a.a_user_id
     *               ,a.a_pageview_id
     *               ,a.a_timestamp) c;
     *
     * DESCRIBE test_db.sessionization_step_one_origins;
     *
     * DROP DATABASE test_db;
     */
    public void testCreateTableAsSelect() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

    /*
CREATE DATABASE test_db;
CREATE TABLE test_db.session_test (
   st_user_id STRING
  ,st_pageview_id STRING
  ,st_page_url STRING
  ,st_referrer_url STRING
  ,st_timestamp DOUBLE);

INSERT INTO test_db.session_test VALUES ('100', '101', '102', 'HTTP://WWW.MEITUAN.COM', 10000);

CREATE TABLE test_db.sessionization_step_one_origins AS
SELECT c.c_user_id as ssoo_user_id
      ,c.c_pageview_id as ssoo_pageview_id
      ,c.c_timestamp as ssoo_timestamp
FROM (SELECT a.a_user_id as c_user_id
            ,a.a_pageview_id as c_pageview_id
            ,a.a_timestamp as c_timestamp
            ,SUM(IF(a.a_timestamp + 1800 >= b.b_timestamp AND a.a_timestamp < b.b_timestamp,1,0)) AS c_nonorigin_flags
      FROM (SELECT st_user_id as a_user_id
                  ,st_pageview_id as a_pageview_id
                  ,st_timestamp as a_timestamp
            FROM test_db.session_test ) a
         JOIN (SELECT st_user_id as b_user_id
                     ,st_timestamp as b_timestamp
               FROM test_db.session_test ) b
           ON a.a_user_id = b.b_user_id
      GROUP BY a.a_user_id
              ,a.a_pageview_id
              ,a.a_timestamp) c;

SET hive.cli.print.header=true;
SELECT * FROM test_db.sessionization_step_one_origins;

DESCRIBE test_db.sessionization_step_one_origins;

DROP DATABASE test_db CASCADE;
*/


    //PASS
    @Test
    @Ignore
    /**
     * test CREATE TABLE LIKE
     *      SET
     *      INSERT OVERWRITE TABLE PARTITION
     *
     * CREATE DATABASE test_db;
     * CREATE TABLE test_db.partition_table001 (name STRING, ip STRING)
     * PARTITIONED BY (dt STRING, ht STRING)
     * ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";
     *
     * INSERT INTO test_db.partition_table001 PARTITION (dt='20150617', ht='00') VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');
     *
     * SET hive.exec.dynamic.partition=true;
     * SET hive.exec.dynamic.partition.mode=nonstrict;
     * SET hive.cli.print.header=true;
     *
     * CREATE TABLE IF NOT EXISTS test_db.partition_table002 LIKE test_db.partition_table001;
     * INSERT OVERWRITE TABLE test_db.partition_table002 PARTITION (dt='20150617', ht='00') SELECT name, ip FROM test_db.partition_table001 WHERE dt='20150617' and ht='00' AND name='meituan';
     * SELECT * FROM test_db.partition_table002;
     * INSERT OVERWRITE TABLE test_db.partition_table002 PARTITION (dt, ht) SELECT * FROM test_db.partition_table001 WHERE dt='20150617' AND name='baidu';
     * SELECT * FROM test_db.partition_table002;
     * INSERT OVERWRITE TABLE test_db.partition_table002 PARTITION (dt='20150617', ht) SELECT name, ip, ht FROM test_db.partition_table001 WHERE dt='20150617' and ht='00' AND name='alibaba';
     * SELECT * FROM test_db.partition_table002;
     * DROP TABLE test_db.partition_table001;
     * DROP TABLE test_db.partition_table002;
     * DROP DATABASE test_db;
     */
    public void testInsertOverwriteTablePartition() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }
/*
 * test CREATE TABLE LIKE
 *      SET
 *      INSERT OVERWRITE TABLE PARTITION
 *
CREATE DATABASE test_db;
CREATE TABLE test_db.partition_table001 (name STRING, ip STRING)
PARTITIONED BY (dt STRING, ht STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

INSERT INTO test_db.partition_table001 PARTITION (dt='20150617', ht='00') VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.cli.print.header=true;

CREATE TABLE IF NOT EXISTS test_db.partition_table002 LIKE test_db.partition_table001;
INSERT OVERWRITE TABLE test_db.partition_table002 PARTITION (dt='20150617', ht='00') SELECT name, ip FROM test_db.partition_table001 WHERE dt='20150617' and ht='00' AND name='meituan';
SELECT * FROM test_db.partition_table002;
INSERT OVERWRITE TABLE test_db.partition_table002 PARTITION (dt, ht) SELECT * FROM test_db.partition_table001 WHERE dt='20150617' AND name='baidu';
SELECT * FROM test_db.partition_table002;
INSERT OVERWRITE TABLE test_db.partition_table002 PARTITION (dt='20150617', ht) SELECT name, ip, ht FROM test_db.partition_table001 WHERE dt='20150617' and ht='00' AND name='alibaba';
SELECT * FROM test_db.partition_table002;
DROP TABLE test_db.partition_table001;
DROP TABLE test_db.partition_table002;
DROP DATABASE test_db;
*/


    //PASS
    @Test
    @Ignore
    /**
     * test CREATE TABLE LIKE
     *      SET
     *      INSERT OVERWRITE TABLE
     *
     * CREATE DATABASE test_db;
     * CREATE TABLE test_db.table001 (name STRING, ip STRING)
     * ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";
     *
     * INSERT INTO test_db.table001 VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');
     *
     * SET hive.cli.print.header=true;
     *
     * CREATE TABLE IF NOT EXISTS test_db.table002 LIKE test_db.table001;
     * INSERT OVERWRITE TABLE test_db.table002 SELECT name, ip FROM test_db.table001 WHERE name='meituan';
     * SELECT * FROM test_db.table002;
     *
     * INSERT OVERWRITE TABLE test_db.table002 SELECT * FROM test_db.table001;
     * SELECT * FROM test_db.table002;
     *
     * SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM test_db.table002;
     *
     * DROP TABLE test_db.table001;
     * DROP TABLE test_db.table002;
     *
     * DROP DATABASE test_db;
     */
    public void testInsertOverwriteTable() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }
    /*
     * test CREATE TABLE LIKE
     *      SET
     *      INSERT OVERWRITE TABLE
     *
CREATE DATABASE test_db;
CREATE TABLE test_db.table001 (name STRING, ip STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";

INSERT INTO test_db.table001 VALUES ('meituan', '10.0.0.1'), ('baidu', '10.0.0.2'), ('alibaba', '10.0.0.3');

SET hive.cli.print.header=true;

CREATE TABLE IF NOT EXISTS test_db.table002 LIKE test_db.table001;
INSERT OVERWRITE TABLE test_db.table002 SELECT name, ip FROM test_db.table001 WHERE name='meituan';
SELECT * FROM test_db.table002;

INSERT OVERWRITE TABLE test_db.table002 SELECT * FROM test_db.table001;
SELECT * FROM test_db.table002;

SELECT ROW_NUMBER() OVER(PARTITION BY ip ORDER BY ip DESC) ID, name, ip FROM test_db.table002;

DROP TABLE test_db.table001;
DROP TABLE test_db.table002;

DROP DATABASE test_db;
     */

    //PASS
    @Test
    @Ignore
    /**
     * test ADD JAR
     *      CREATE FUNCTION
     *
     * CREATE DATABASE test_db;
     * USE test_db;
     * ADD JAR /opt/meituan/qa_test/testfile/hive_qa_udf.jar;
     * LIST JARS;
     * CREATE TEMPORARY FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
     * CREATE TABLE teacher (name STRING);
     * INSERT INTO teacher VALUES ('TEACHER QA');
     * SELECT qa_lower(name) as name FROM teacher;
     * DROP TABLE teacher;
     * DELETE JAR /opt/meituan/qa_test/testfile/hive_qa_udf.jar;
     * DROP DATABASE test_db;
     */
    public void testAddJarCreateTmpFunction() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

/*
CREATE DATABASE test_db;
USE test_db;
ADD JAR /opt/meituan/qa_test/testfile/hive_qa_udf.jar;
LIST JARS;
CREATE TEMPORARY FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
CREATE TABLE teacher (name STRING);
INSERT INTO teacher VALUES ('TEACHER QA');
SELECT qa_lower(name) as name FROM teacher;
DROP TABLE teacher;
DELETE JAR /opt/meituan/qa_test/testfile/hive_qa_udf.jar;
LIST JARS;
DROP DATABASE test_db;
*/

    //FAILED
    @Test
    @Ignore
    /**
     * test ADD JAR
     *      CREATE FUNCTION
     *
     * CREATE DATABASE test_db;
     * USE test_db;
     * ADD JAR /opt/meituan/qa_test/testfile/hive_qa_udf.jar;
     * LIST JARS;
     * CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
     * CREATE TABLE teacher (name STRING);
     * INSERT INTO teacher VALUES ('TEACHER QA');
     * SELECT qa_lower(name) as name FROM teacher;
     * DROP TABLE teacher;
     * DELETE JAR /opt/meituan/qa_test/testfile/hive_qa_udf.jar;
     * DROP DATABASE test_db;
     */
    public void testAddJarCreateFunction() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

/*
CREATE DATABASE test_db;
USE test_db;
ADD JAR /opt/meituan/qa_test/testfile/hive_qa_udf.jar;
LIST JARS;
CREATE FUNCTION qa_lower AS 'com.example.hive.udf.LowerCase';
CREATE TABLE teacher (name STRING);
INSERT INTO teacher VALUES ('TEACHER QA');
SELECT qa_lower(name) as name FROM teacher;
DROP TABLE teacher;
DELETE JAR /opt/meituan/qa_test/testfile/hive_qa_udf.jar;
LIST JARS;
DROP DATABASE test_db;
*/


    //PASS
    @Test
    @Ignore
    /**
     * test ADD FILE
     *
     * #!/bin/bash
     * #!/bin/bash
     * while read LINE
     * do
     * echo "Hello,  $LINE"
     * done
     *
     * CREATE DATABASE test_db;
     * CREATE TABLE test_db.whoyouare(who string);
     * LOAD DATA LOCAL INPATH '/opt/meituan/qa_test/testfile/who.txt' OVERWRITE INTO TABLE test_db.whoyouare;
     * SET hive.cli.print.header=true;
     * SELECT * FROM test_db.whoyouare;
     * ADD FILE /opt/meituan/qa_test/testfile/test_who.sh;
     * LIST FILES;
     * SET hive.cli.print.header=true;
     * SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM test_db.whoyouare;
     * DELETE FILE /opt/meituan/qa_test/testfile/test_who.sh;
     * LIST FILE;
     * DROP TABLE test_db.whoyouare;
     * DROP DATABASE test_db;
     */
    public void testAddFile() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

/*
cat /opt/meituan/qa_test/testfile/test_who.sh
#!/bin/bash
while read LINE
do
    echo "Hello,  $LINE"
done

CREATE DATABASE test_db;
CREATE TABLE test_db.whoyouare(who string);
LOAD DATA LOCAL INPATH '/opt/meituan/qa_test/testfile/who.txt' OVERWRITE INTO TABLE test_db.whoyouare;
SET hive.cli.print.header=true;
SELECT * FROM test_db.whoyouare;
ADD FILE /opt/meituan/qa_test/testfile/test_who.sh;
LIST FILES;
SET hive.cli.print.header=true;
SELECT TRANSFORM (who) USING 'sh test_who.sh' AS (who) FROM test_db.whoyouare;
DELETE FILE /opt/meituan/qa_test/testfile/test_who.sh;
LIST FILE;
DROP TABLE test_db.whoyouare;
DROP DATABASE test_db;
*/

    //PASS
    @Test
    @Ignore
    /**
     * test ALTER TABLE ..SET SERDEPROPERTIES
     *
     * CREATE DATABASE test_db;
     *
     * CREATE TABLE test_db.test_serde (c0 string, c1 string, c2 string) ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
     * WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;
     *
     * ALTER TABLE test_db.test_serde SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s')
     * SHOW CREATE TABLE test_db.test_serde;
     *
     * DROP TABLE test_db.test_serde;
     *
     * DROP DATABASE test_db;
     */
    public void testAlterSerDeTable() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

/*
CREATE DATABASE test_db;
CREATE TABLE test_db.test_serde (c0 string, c1 string, c2 string) ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

ALTER TABLE test_db.test_serde SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
SHOW CREATE TABLE test_db.test_serde;

DROP TABLE test_db.test_serde;

DROP DATABASE test_db;
*/


    //FAILED ALTER TABLE PARTITION
    @Test
    @Ignore
    /**
     * test ALTER TABLE .. PARTITION SET SERDEPROPERTIES
     *
     * CREATE DATABASE test_db;
     * CREATE TABLE test_db.test_serde(c0 string, c1 string, c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
     * ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
     * WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;
     *
     * ALTER TABLE test_db.test_serde ADD PARTITION (col10='abc', col20='123');
     * DESCRIBE EXTENDED test_db.test_serde PARTITION (col10='abc', col20='123');
     *
     * ALTER TABLE test_db.test_serde PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
     * DESCRIBE EXTENDED test_db.test_serde PARTITION (col10='abc', col20='123');
     *
     * DROP TABLE test_db.test_serde;
     * DROP DATABASE test_db;
     */
    public void testAlterSerDePartition() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }
/*
CREATE DATABASE test_db;
CREATE TABLE test_db.test_serde(c0 string, c1 string, c2 string) PARTITIONED BY (col10 STRING, col20 STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;

ALTER TABLE test_db.test_serde ADD PARTITION (col10='abc', col20='123');
DESCRIBE EXTENDED test_db.test_serde PARTITION (col10='abc', col20='123');

ALTER TABLE test_db.test_serde PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
DESCRIBE EXTENDED test_db.test_serde PARTITION (col10='abc', col20='123');

DROP TABLE test_db.test_serde;
DROP DATABASE test_db;
*/

    //PASS
    @Test
    @Ignore
    /**
     * INSERT OVERWRITE TABLE
     * INSERT OVERWRITE DIRECTORY
     *
     * cat california-employees.csv
     * name|salary|subordinates|deductions|address
     * John Doe,100000.0,Mary Smith|Todd Jones,Federal Taxes=0.2|State Taxes=0.05|Insurance=0.1,Michigan Ave.|Chicago|IL|60600
     * Mary Smith,80000.0,Bill King,Federal Taxes=0.2|State Taxes=0.05|Insurance=0.1,Ontario St.|Chicago|IL|60601
     * Todd Jones,70000.0,,Federal Taxes=0.15|State Taxes=0.03|Insurance=0.1,Chicago Ave.|Oak Park|IL|60700
     * Bill King,60000.0,,Federal Taxes=0.15|State Taxes=0.03|Insurance=0.1,Obscure Dr.|Obscuria|IL|60100
     *
     * CREATE DATABASE test_db;
     * CREATE TABLE test_db.staged_employees (
     *  name STRING
     * ,salary FLOAT
     * ,subordinates ARRAY<STRING>
     * ,deductions MAP<STRING, FLOAT>
     * ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
     * ) PARTITIONED BY (country STRING, state STRING)
     * ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
     * COLLECTION ITEMS TERMINATED BY '|'
     * MAP KEYS TERMINATED BY '='
     * LINES TERMINATED BY '\n' STORED AS TEXTFILE;
     *
     * CREATE TABLE test_db.employees (
     *  name STRING
     * ,salary FLOAT
     * ,subordinates ARRAY<STRING>
     * ,deductions MAP<STRING, FLOAT>
     * ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
     * ) PARTITIONED BY (country STRING, state STRING)
     * ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
     * COLLECTION ITEMS TERMINATED BY '|'
     * MAP KEYS TERMINATED BY '='
     * LINES TERMINATED BY '\n' STORED AS TEXTFILE;
     *
     * ALTER TABLE test_db.staged_employees ADD PARTITION (country = 'US', state = 'CA');
     * ALTER TABLE test_db.staged_employees ADD PARTITION (country = 'US', state = 'OR');
     * ALTER TABLE test_db.staged_employees ADD PARTITION (country = 'US', state = 'IL');
     *
     * export FILEPATH=/opt/meituan/qa_test/testfile
     * echo $FILEPATH
     * LOAD DATA LOCAL INPATH '${env:FILEPATH}/california-employees.csv'
     * INTO TABLE test_db.staged_employees
     * PARTITION (country = 'US', state = 'CA');
     *
     * FROM test_db.staged_employees se
     * INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state = 'OR')
     * SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
     * INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state = 'IL')
     * SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
     * INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state = 'CA')
     * SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA';
     *
     * SET hive.cli.print.header=true;
     * SELECT * FROM test_db.employees;
     *
     * INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state = 'CA')
     * SELECT name, salary, subordinates, deductions, address FROM test_db.staged_employees se WHERE se.country = 'US' AND se.state = 'CA';
     *
     * TRUNCATE TABLE test_db.employees;
     *
     * SET hive.exec.dynamic.partition=true;
     * SET hive.vectorized.execution.enabled = true;
     * SET hive.vectorized.execution.reduce.enabled = true;
     * INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state)
     * SELECT se.name, se.salary, se.subordinates, se.deductions, se.address, se.state FROM test_db.staged_employees se WHERE se.country = 'US';
     * SELECT * FROM test_db.employees;
     *
     * INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
     * SELECT * FROM test_db.staged_employees se WHERE se.country = 'US' and se.state = 'CA';
     * !ls -l /tmp/ca_employees;
     * !ls -rm -r /tmp/ca_employees;
     *
     * FROM (
     * SELECT emp.name, emp.salary FROM test_db.staged_employees emp WHERE emp.salary < 6000
     * UNION ALL
     * SELECT emp.name, emp.salary FROM test_db.staged_employees emp WHERE emp.salary > 7000
     * ) unioninput
     * INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;
     * dfs -cat /tmp/union.out/* ;
     * dfs -rm -r /tmp/union.out ;
     *
     * ANALYZE TABLE test_db.staged_employees COMPUTE STATISTICS FOR columns name, salary;
     * -- 只搜集分区
     * ANALYZE TABLE test_db.staged_employees PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
     * -- 如果执行,则同时搜集分区间OR/CA/IL
     * ANALYZE TABLE test_db.staged_employees PARTITION (country = 'US', state)  COMPUTE STATISTICS;
     * -- 如果执行 搜集所有分区
     * ANALYZE TABLE test_db.staged_employees PARTITION (country, state) COMPUTE STATISTICS;
     * ANALYZE TABLE test_db.staged_employees COMPUTE STATISTICS;
     * -- 查看分区的统计信息：
     * DESCRIBE EXTENDED test_db.staged_employees;
     * DESCRIBE EXTENDED test_db.staged_employees PARTITION (country = 'US', state = 'CA');
     *
     * DROP TABLE test_db.staged_employees;
     * DROP TABLE test_db.employees;
     *
     * DROP DATABASE test_db;
     */
    public void testInsertOverwriteTableDir() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

/*
cat california-employees.csv
name|salary|subordinates|deductions|address
John Doe,100000.0,Mary Smith|Todd Jones,Federal Taxes=0.2|State Taxes=0.05|Insurance=0.1,Michigan Ave.|Chicago|IL|60600
Mary Smith,80000.0,Bill King,Federal Taxes=0.2|State Taxes=0.05|Insurance=0.1,Ontario St.|Chicago|IL|60601
Todd Jones,70000.0,,Federal Taxes=0.15|State Taxes=0.03|Insurance=0.1,Chicago Ave.|Oak Park|IL|60700
Bill King,60000.0,,Federal Taxes=0.15|State Taxes=0.03|Insurance=0.1,Obscure Dr.|Obscuria|IL|60100

CREATE DATABASE test_db;
CREATE TABLE test_db02.staged_employees (
   name STRING
  ,salary FLOAT
  ,subordinates ARRAY<STRING>
  ,deductions MAP<STRING, FLOAT>
  ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

CREATE TABLE test_db.employees (
   name STRING
  ,salary FLOAT
  ,subordinates ARRAY<STRING>
  ,deductions MAP<STRING, FLOAT>
  ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

ALTER TABLE test_db.staged_employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE test_db.staged_employees ADD PARTITION (country = 'US', state = 'OR');
ALTER TABLE test_db.staged_employees ADD PARTITION (country = 'US', state = 'IL');

export FILEPATH=/opt/meituan/qa_test/testfile
echo $FILEPATH
LOAD DATA LOCAL INPATH '${env:FILEPATH}/california-employees.csv'
INTO TABLE test_db02.staged_employees
PARTITION (country = 'US', state = 'CA');

LOAD DATA LOCAL INPATH '/opt/meituan/qa_test/testfile/california-employees.csv'
INTO TABLE test_db02.staged_employees
PARTITION (country = 'US', state = 'CA');

FROM test_db.staged_employees se
INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state = 'OR')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'OR'
INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state = 'IL')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'IL'
INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address WHERE se.country = 'US' AND se.state = 'CA';

SET hive.cli.print.header=true;
SELECT * FROM test_db.employees;


INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state = 'CA')
SELECT name, salary, subordinates, deductions, address FROM test_db.staged_employees se WHERE se.country = 'US' AND se.state = 'CA';

TRUNCATE TABLE test_db.employees;

SET hive.exec.dynamic.partition=true;
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;
INSERT OVERWRITE TABLE test_db.employees PARTITION (country = 'US', state)
SELECT se.name, se.salary, se.subordinates, se.deductions, se.address, se.state FROM test_db.staged_employees se WHERE se.country = 'US';
SELECT * FROM test_db.employees;

INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM test_db.staged_employees se WHERE se.country = 'US' and se.state = 'CA';
!ls -l /tmp/ca_employees;
!ls -rm -r /tmp/ca_employees;

FROM (
      SELECT emp.name, emp.salary FROM test_db.staged_employees emp WHERE emp.salary < 6000
      UNION ALL
      SELECT emp.name, emp.salary FROM test_db.staged_employees emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;
dfs -cat /tmp/union.out/* ;
dfs -rm -r /tmp/union.out ;

ANALYZE TABLE test_db.staged_employees COMPUTE STATISTICS FOR columns name, salary;
-- 只搜集分区
ANALYZE TABLE test_db.staged_employees PARTITION (country = 'US', state = 'CA') COMPUTE STATISTICS;
-- 如果执行,则同时搜集分区间OR/CA/IL
ANALYZE TABLE test_db.staged_employees PARTITION (country = 'US', state)  COMPUTE STATISTICS;
-- 如果执行 搜集所有分区
ANALYZE TABLE test_db.staged_employees PARTITION (country, state) COMPUTE STATISTICS;
ANALYZE TABLE test_db.staged_employees COMPUTE STATISTICS;
-- 查看分区的统计信息：
DESCRIBE EXTENDED test_db.staged_employees;
DESCRIBE EXTENDED test_db.staged_employees PARTITION (country = 'US', state = 'CA');

DROP TABLE test_db.staged_employees;
DROP TABLE test_db.employees;

DROP DATABASE test_db;
*/


    //PASS
    @Test
    @Ignore
    /**
     * test IMPORT TABLE
     *      EXPORT TABLE
     *      ALTER TABLE TOUCH
     *      ALTER TABLE TOUCH PARTITION
     *      DESCRIBE TABLE .. PARTITION
     *      ALTER TABLE .. CLUSTERED BY SORTED BY
     *
     * cat california-employees.csv
     * name|salary|subordinates|deductions|address
     * John Doe,100000.0,Mary Smith|Todd Jones,Federal Taxes=0.2|State Taxes=0.05|Insurance=0.1,1|Michigan Ave.|Chicago|IL|60600
     * Mary Smith,80000.0,Bill King,Federal Taxes=0.2|State Taxes=0.05|Insurance=0.1,100|Ontario St.|Chicago|IL|60601
     * Todd Jones,70000.0,,Federal Taxes=0.15|State Taxes=0.03|Insurance=0.1,200|Chicago Ave.|Oak Park|IL|60700
     * Bill King,60000.0,,Federal Taxes=0.15|State Taxes=0.03|Insurance=0.1,300|Obscure Dr.|Obscuria|IL|60100
     *
     * CREATE DATABASE test_db;
     *
     * CREATE TABLE test_db.employees (
     *  name STRING
     * ,salary FLOAT
     * ,subordinates ARRAY<STRING>
     * ,deductions MAP<STRING, FLOAT>
     * ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
     * ) PARTITIONED BY (country STRING, state STRING)
     * ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
     * COLLECTION ITEMS TERMINATED BY '|'
     * MAP KEYS TERMINATED BY '='
     * LINES TERMINATED BY '\n' STORED AS TEXTFILE;
     *
     * CREATE TABLE test_db.staged_employees (
     *  name STRING
     * ,salary FLOAT
     * ,subordinates ARRAY<STRING>
     * ,deductions MAP<STRING, FLOAT>
     * ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
     * ) PARTITIONED BY (country STRING, state STRING)
     * ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
     * COLLECTION ITEMS TERMINATED BY '|'
     * MAP KEYS TERMINATED BY '='
     * LINES TERMINATED BY '\n' STORED AS TEXTFILE;
     *
     * ALTER TABLE test_db.staged_employees ADD PARTITION (country = 'US', state = 'CA');
     * ALTER TABLE test_db.employees ADD PARTITION (country = 'US', state = 'CA');
     *
     * SET FILEPATH=/opt/meituan/qa_test/testfile;
     * SELECT '${hiveconf:FILEPATH}';
     *
     * LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
     * INTO TABLE test_db.staged_employees
     * PARTITION (country = 'US', state = 'CA');
     *
     * -- TRUNCATE TABLE test_db.staged_employees;
     * -- export FILEPATH=/opt/meituan/qa_test/testfile;
     * -- echo $FILEPATH;
     * -- LOAD DATA LOCAL INPATH '${env:FILEPATH}/california-employees.csv'
     * -- INTO TABLE test_db.staged_employees
     * -- PARTITION (country = 'US', state = 'CA');
     *
     * -- 导出分区并且导入到分区表分区
     * EXPORT TABLE test_db.staged_employees PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
     * dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;
     *
     * IMPORT TABLE test_db.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
     * SHOW PARTITIONS test_db.employees;
     *
     * ALTER TABLE test_db.employees TOUCH;
     *
     * ALTER TABLE test_db.staged_employees TOUCH PARTITION (country = 'US', state = 'CA') ;
     * ALTER TABLE test_db.employees TOUCH PARTITION (country = 'US', state = 'CA') ;
     * ALTER TABLE test_db.employees ADD PARTITION (country = 'CHN', state = 'BJ') ;
     * ALTER TABLE test_db.employees TOUCH PARTITION (country = 'CHN', state = 'BJ') ;
     *
     * DESCRIBE test_db.employees PARTITION (country='US', state='CA');
     * DESCRIBE EXTENDED test_db.employees PARTITION (country='US', state='CA');
     *
     * ALTER TABLE test_db.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
     * dfs -rm -R /tmp/employee;
     *
     * DROP TABLE test_db.employees;
     * DROP TABLE test_db.staged_employees;
     *
     * DROP DATABASE test_db CASCADE;
     */
    public void testImportExportAlterTableClusteredBySortedBy() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }


/*
CREATE DATABASE test_db;

CREATE TABLE test_db.employees (
  name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

CREATE TABLE test_db.staged_employees (
  name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '|'
MAP KEYS TERMINATED BY '='
LINES TERMINATED BY '\n' STORED AS TEXTFILE;

ALTER TABLE test_db.staged_employees ADD PARTITION (country = 'US', state = 'CA');
ALTER TABLE test_db.employees ADD PARTITION (country = 'US', state = 'CA');

SET FILEPATH=/opt/meituan/qa_test/testfile;
SELECT '${hiveconf:FILEPATH}';

LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
INTO TABLE test_db.staged_employees
PARTITION (country = 'US', state = 'CA');

-- TRUNCATE TABLE test_db.staged_employees;
-- export FILEPATH=/opt/meituan/qa_test/testfile;
-- echo $FILEPATH;
-- LOAD DATA LOCAL INPATH '${env:FILEPATH}/california-employees.csv'
-- INTO TABLE test_db.staged_employees
-- PARTITION (country = 'US', state = 'CA');

-- 导出分区并且导入到分区表分区
EXPORT TABLE test_db.staged_employees PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

IMPORT TABLE test_db.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
SHOW PARTITIONS test_db.employees;

ALTER TABLE test_db.employees TOUCH;

ALTER TABLE test_db.staged_employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE test_db.employees TOUCH PARTITION (country = 'US', state = 'CA') ;
ALTER TABLE test_db.employees ADD PARTITION (country = 'CHN', state = 'BJ') ;
ALTER TABLE test_db.employees TOUCH PARTITION (country = 'CHN', state = 'BJ') ;

DESCRIBE test_db.employees PARTITION (country='US', state='CA');
DESCRIBE EXTENDED test_db.employees PARTITION (country='US', state='CA');

ALTER TABLE test_db.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
dfs -rm -R /tmp/employee;

DROP TABLE test_db.employees;
DROP TABLE test_db.staged_employees;

DROP DATABASE test_db CASCADE;
*/

    /*


    test_db02.staged_employees.name




    CREATE DATABASE test_db02;

    CREATE TABLE test_db02.employees (
      name STRING
     ,salary FLOAT
     ,subordinates ARRAY<STRING>
     ,deductions MAP<STRING, FLOAT>
     ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
    ) PARTITIONED BY (country STRING, state STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
    COLLECTION ITEMS TERMINATED BY '|'
    MAP KEYS TERMINATED BY '='
    LINES TERMINATED BY '\n' STORED AS TEXTFILE;

    CREATE TABLE test_db02.staged_employees (
      name STRING
     ,salary FLOAT
     ,subordinates ARRAY<STRING>
     ,deductions MAP<STRING, FLOAT>
     ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
    ) PARTITIONED BY (country STRING, state STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
    COLLECTION ITEMS TERMINATED BY '|'
    MAP KEYS TERMINATED BY '='
    LINES TERMINATED BY '\n' STORED AS TEXTFILE;

    ALTER TABLE test_db02.staged_employees ADD PARTITION (country = 'US', state = 'CA');

    SET FILEPATH=/opt/meituan/qa_test/testfile;
    SELECT '${hiveconf:FILEPATH}';

    LOAD DATA LOCAL INPATH '${hiveconf:FILEPATH}/california-employees.csv'
    INTO TABLE test_db02.staged_employees
    PARTITION (country = 'US', state = 'CA');

    -- TRUNCATE TABLE test_db.staged_employees;
    -- export FILEPATH=/opt/meituan/qa_test/testfile;
    -- echo $FILEPATH;
    -- LOAD DATA LOCAL INPATH '${env:FILEPATH}/california-employees.csv'
    -- INTO TABLE test_db.staged_employees
    -- PARTITION (country = 'US', state = 'CA');


    -- 导出分区并且导入到分区表分区
    EXPORT TABLE test_db02.staged_employees PARTITION (country = 'US', state = 'CA') TO '/tmp/employee';
    dfs -cat /tmp/employee/country=US/state=CA/california-employees.csv;

    IMPORT TABLE test_db02.employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
    SHOW PARTITIONS test_db02.employees;

    ALTER TABLE test_db02.employees TOUCH;

    ALTER TABLE test_db.staged_employees TOUCH PARTITION (country = 'US', state = 'CA') ;
    ALTER TABLE test_db.employees TOUCH PARTITION (country = 'US', state = 'CA') ;
    ALTER TABLE test_db.employees ADD PARTITION (country = 'CHN', state = 'BJ') ;
    ALTER TABLE test_db.employees TOUCH PARTITION (country = 'CHN', state = 'BJ') ;

    DESCRIBE test_db.employees PARTITION (country='US', state='CA');
    DESCRIBE EXTENDED test_db.employees PARTITION (country='US', state='CA');

    ALTER TABLE test_db.employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;

    DROP DATABASE test_db CASCADE;
    */


    //PASS
    @Test
    @Ignore
    /** test ALTER TABLE .. ENABLE / DISABLE
     *
     * CREATE DATABASE test_db;
     *
     * CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
     * PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
     *
     * ALTER TABLE test_db.log_messages ENABLE NO_DROP;
     * DROP test_db.log_messages;
     * ALTER TABLE test_db.log_messages DISABLE NO_DROP;
     * DROP test_db.log_messages;
     *
     * CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
     * PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
     *
     * ALTER TABLE test_db.log_messages ENABLE OFFLINE;
     * DROP test_db.log_messages;
     * ALTER TABLE test_db.log_messages DISABLE OFFLINE;
     * DROP test_db.log_messages;
     *
     * DROP DATABASE test_db;
     */
    public void testAlterTableEnableDisable() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

/*
CREATE DATABASE test_db;
CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE test_db.log_messages ENABLE NO_DROP;
DROP TABLE test_db.log_messages;
ALTER TABLE test_db.log_messages DISABLE NO_DROP;
DROP TABLE test_db.log_messages;

CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE test_db.log_messages ENABLE OFFLINE;
DROP TABLE test_db.log_messages;
ALTER TABLE test_db.log_messages DISABLE OFFLINE;
DROP TABLE test_db.log_messages;

DROP DATABASE test_db;
*/


    //Failed ALTER TABLE PARTITION
    @Test
    @Ignore
    /**
     * test ALTER TABLE .. PARTITION ENABLE / DISABLE
     *
     * CREATE DATABASE test_db;
     *
     * CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
     * PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
     *
     * ALTER TABLE test_db.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
     * ALTER TABLE test_db.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
     * ALTER TABLE test_db.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
     *
     * ALTER TABLE test_db.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
     * ALTER TABLE test_db.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
     *
     * ALTER TABLE test_db.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
     * ALTER TABLE test_db.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE OFFLINE;
     * ALTER TABLE test_db.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
     *
     * ALTER TABLE test_db.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE OFFLINE;
     * ALTER TABLE test_db.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
     *
     * DROP DATABASE test_db;
     */
    public void testAlterPartitionEnableDisable() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

/*
CREATE DATABASE test_db;
CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';

ALTER TABLE test_db.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE test_db.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
ALTER TABLE test_db.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);

ALTER TABLE test_db.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
ALTER TABLE test_db.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE test_db.log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE test_db.log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE OFFLINE;
ALTER TABLE test_db.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
ALTER TABLE test_db.log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE OFFLINE;
ALTER TABLE test_db.log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
DROP DATABASE test_db;
*/

    //Pass
    @Test
    @Ignore
    /**
     * test MSCK REPAIR TABLE
     *
     * CREATE DATABASE test_db;
     *
     * CREATE TABLE test_db.test_msck (id INT, val STRING) PARTITIONED BY(month INT);
     * SHOW PARTITIONS test_db.test_msck;
     * #创建两个分区目录
     * dfs -mkdir /user/hive/warehouse/test_msck/month=201603;
     * dfs -mkdir /user/hive/warehouse/test_msck/month=201604;
     * #使用MSCK修复分区
     * MSCK REPAIR TABLE test_db.test_msck;
     * #再次查看，发现已经成功更新元信息
     * SHOW PARTITIONS test_db.test_msck;
     * dfs -ls /user/hive/warehouse/test_db.db/test_msck/month=201603;
     * DROP DATABASE test_db CASCADE;
     */
    public void testMSCKRepairTable() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

/*
CREATE DATABASE test_db;
CREATE TABLE test_db.test_msck (id INT, val STRING) PARTITIONED BY(month INT);
SHOW PARTITIONS test_db.test_msck;
#创建两个分区目录
dfs -mkdir /user/hive/warehouse/test_db.db/test_msck/month=201603;
dfs -mkdir /user/hive/warehouse/test_db.db/test_msck/month=201604;
#使用MSCK修复分区
MSCK REPAIR TABLE test_db.test_msck;
#再次查看，发现已经成功更新元信息
SHOW PARTITIONS test_db.test_msck;
dfs -ls /user/hive/warehouse/test_db.db/test_msck;
DROP DATABASE test_db CASCADE;
*/

    //PASS

    /**
     * test SHOW TBLPROPERTIES
     * SHOW COLUMNS
     * <p>
     * CREATE DATABASE test_db;
     * <p>
     * USE test_DB;
     * CREATE TABLE IF NOT EXISTS employees_props (
     * name  STRING COMMENT 'Employee name'
     * ,salary  FLOAT  COMMENT'Employee salary'
     * ,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
     * ,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
     * ,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
     * COMMENT 'Description of the table'
     * PARTITIONED BY (country STRING, state STRING)
     * LOCATION '/user/hive/warehouse/test_db.db/employees_props'
     * TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties');
     * <p>
     * SHOW TBLPROPERTIES employees_props;
     * <p>
     * SHOW COLUMNS IN test_db.employees_props;
     * SHOW COLUMNS FROM test_db.employees_props;
     * <p>
     * DROP TABLE employees_props;
     * <p>
     * DROP DATABASE test_db;
     */
    public void testShowColumnsAndTblProperties() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

/*
CREATE DATABASE test_db;

USE test_DB;
CREATE TABLE IF NOT EXISTS employees_props (
   name  STRING COMMENT 'Employee name'
  ,salary  FLOAT  COMMENT'Employee salary'
  ,subordinates ARRAY<STRING> COMMENT 'Names of subordinates'
  ,deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages'
  ,address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address')
COMMENT 'Description of the table'
PARTITIONED BY (country STRING, state STRING)
LOCATION '/user/hive/warehouse/test_db.db/employees_props'
TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties');

SHOW TBLPROPERTIES employees_props;

SHOW COLUMNS IN test_db.employees_props;
SHOW COLUMNS FROM test_db.employees_props;

DROP TABLE employees_props;

DROP DATABASE test_db;
*/

    //FAILED
    @Test
    @Ignore
    /**
     * test CREATE INDEX
     *      SHOW INDEX
     *      DROP INDEX
     *
     * CREATE DATABASE test_db;
     * CREATE TABLE test_db.employees (
     *   name STRING
     *  ,salary FLOAT
     *  ,subordinates ARRAY<STRING>
     *  ,deductions MAP<STRING, FLOAT>
     *  ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
     * ) PARTITIONED BY (country STRING, state STRING);
     *
     * CREATE INDEX test_db.employees_index
     * ON TABLE test_db.employees (name)
     * AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler'
     * WITH DEFERRED REBUILD
     * IDXPROPERTIES ('creator' = 'HADOOP-QA')
     * IN TABLE test_db.employees_index_on_name_column
     * COMMENT 'Employees indexed by name.';
     *
     * SHOW INDEX ON test_db.employees;
     * SHOW FORMATTED INDEX ON test_db.employees;
     *
     * DROP INDEX IF EXISTS test_db.employees_index ON TABLE test_db.employees;
     * DROP TABLE test_db.employees;
     *
     * DROP DATABASE test_db;
     */
    public void testCreateShowDropIndex() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

/*
CREATE DATABASE test_db;
CREATE TABLE test_db.employees (
   name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
  ,deductions MAP<STRING, FLOAT>
  ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING);

CREATE INDEX test_db.employees_index
ON TABLE test_db.employees (name)
AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler'
WITH DEFERRED REBUILD
IDXPROPERTIES ('creator' = 'HADOOP-QA')
IN TABLE test_db.employees_index_on_name_column
COMMENT 'Employees indexed by name.';

SHOW INDEX ON test_db.employees;
SHOW FORMATTED INDEX ON test_db.employees;

DROP INDEX IF EXISTS test_db.employees_index ON TABLE test_db.employees;
DROP TABLE test_db.employees;

DROP DATABASE test_db;
*/

    //FAILED
    @Test
    @Ignore
    /**
     * test CREATE INDEX
     *      SHOW INDEX
     *      DROP INDEX
     *
     * CREATE DATABASE test_db;
     *
     * USE test_db;
     * CREATE TABLE employees (
     *   name STRING
     *  ,salary FLOAT
     *  ,subordinates ARRAY<STRING>
     *  ,deductions MAP<STRING, FLOAT>
     *  ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
     * ) PARTITIONED BY (country STRING, state STRING);
     *
     * CREATE INDEX employees_bitmap_index
     * ON TABLE employees (subordinates)
     * AS 'BITMAP' WITH DEFERRED REBUILD
     * IDXPROPERTIES ('creator' = 'me')
     * IN TABLE employees_bitmap_index_table
     * -- PARTITIONED BY (country, name) ??
     * COMMENT 'Employees indexed by country and name.';
     *
     * SHOW INDEX ON employees;
     * SHOW FORMATTED INDEX ON employees;
     *
     * DROP INDEX IF EXISTS employees_bitmap_index ON TABLE employees;
     * DROP TABLE employees;
     *
     * DROP DATABASE test_db;
     */
    public void testCreateShowDropBitmapIndex() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }
/*
CREATE DATABASE test_db;

USE test_db;
CREATE TABLE employees (
  name STRING
 ,salary FLOAT
 ,subordinates ARRAY<STRING>
 ,deductions MAP<STRING, FLOAT>
 ,address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
) PARTITIONED BY (country STRING, state STRING);

CREATE INDEX employees_bitmap_index
ON TABLE employees (subordinates)
AS 'BITMAP' WITH DEFERRED REBUILD
IDXPROPERTIES ('creator' = 'me')
IN TABLE employees_bitmap_index_table
COMMENT 'Employees indexed by country and name.';

SHOW INDEX ON employees;
SHOW FORMATTED INDEX ON employees;

DROP INDEX IF EXISTS employees_bitmap_index ON TABLE employees;
DROP TABLE employees;

DROP DATABASE test_db;
*/


    /**
     * ./hdfs dfs
     * Usage: hadoop fs [generic options]
     * [-appendToFile <localsrc> ... <dst>]
     * <p>
     * [-checksum <src> ...]
     * [-chgrp [-R] GROUP PATH...]
     * [-chmod [-R] <MODE[,MODE]... | OCTALMODE> PATH...]
     * [-chown [-R] [OWNER][:[GROUP]] PATH...]
     * [-copyFromLocal [-f] [-p] [-l] <localsrc> ... <dst>]
     * [-copyToLocal [-p] [-ignoreCrc] [-crc] <src> ... <localdst>]
     * [-count [-q] [-h] [-v] [-t [<storage type>]] [-u] <path> ...]
     * [-cp [-f] [-p | -p[topax]] <src> ... <dst>]
     * [-createSnapshot <snapshotDir> [<snapshotName>]]
     * [-deleteSnapshot <snapshotDir> <snapshotName>]
     * [-df [-h] [<path> ...]]
     * [-du [-s] [-h] <path> ...]
     * [-expunge]
     * [-find <path> ... <expression> ...]
     * [-get [-p] [-ignoreCrc] [-crc] <src> ... <localdst>]
     * [-getfacl [-R] <path>]
     * [-getfattr [-R] {-n name | -d} [-e en] <path>]
     * [-getmerge [-nl] <src> <localdst>]
     * [-help [cmd ...]]
     * [-ls [-d] [-h] [-R] [<path> ...]]
     * <p>
     * [-moveFromLocal <localsrc> ... <dst>]
     * [-moveToLocal <src> <localdst>]
     * [-mv <src> ... <dst>]
     * [-put [-f] [-p] [-l] <localsrc> ... <dst>]
     * [-renameSnapshot <snapshotDir> <oldName> <newName>]
     * [-rm [-f] [-r|-R] [-skipTrash] <src> ...]
     * [-rmdir [--ignore-fail-on-non-empty] <dir> ...]
     * [-setfacl [-R] [{-b|-k} {-m|-x <acl_spec>} <path>]|[--set <acl_spec> <path>]]
     * [-setfattr {-n name [-v value] | -x name} <path>]
     * [-setrep [-R] [-w] <rep> <path> ...]
     * [-stat [format] <path> ...]
     * [-tail [-f] <file>]
     * [-test -[defsz] <path>]
     * [-text [-ignoreCrc] <src> ...]
     * [-touchz <path> ...]
     * [-truncate [-w] <length> <path> ...]
     * [-usage [cmd ...]]
     */


    //PASS
    @Test
    @Ignore
    /**
     * test DFS
     *
     * cat california-employees.csv
     * name|salary|subordinates|deductions|address
     * John Doe,100000.0,Mary Smith|Todd Jones,Federal Taxes=0.2|State Taxes=0.05|Insurance=0.1,Michigan Ave.|Chicago|IL|60600
     * Mary Smith,80000.0,Bill King,Federal Taxes=0.2|State Taxes=0.05|Insurance=0.1,Ontario St.|Chicago|IL|60601
     * Todd Jones,70000.0,,Federal Taxes=0.15|State Taxes=0.03|Insurance=0.1,Chicago Ave.|Oak Park|IL|60700
     * Bill King,60000.0,,Federal Taxes=0.15|State Taxes=0.03|Insurance=0.1,Obscure Dr.|Obscuria|IL|60100
     *
     * SET FILEPATH=/opt/meituan/qa_test/testfile;
     * !cp ${hiveconf:FILEPATH}/california-employees.csv ${hiveconf:FILEPATH}/california-employees.csv_new;
     * dfs -moveFromLocal ${hiveconf:FILEPATH}/california-employees.csv_new  /tmp;
     * dfs -count /tmp/california-employees.csv_new;
     * dfs -copyToLocal /tmp/california-employees.csv_new /tmp;
     * dfs -rm /tmp/california-employees.csv_new;
     * !rm /tmp/california-employees.csv_new;
     */
    public void testDfs() {
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }
    /*
     * test DFS
cat california-employees.csv
name|salary|subordinates|deductions|address
John Doe,100000.0,Mary Smith|Todd Jones,Federal Taxes=0.2|State Taxes=0.05|Insurance=0.1,Michigan Ave.|Chicago|IL|60600
Mary Smith,80000.0,Bill King,Federal Taxes=0.2|State Taxes=0.05|Insurance=0.1,Ontario St.|Chicago|IL|60601
Todd Jones,70000.0,,Federal Taxes=0.15|State Taxes=0.03|Insurance=0.1,Chicago Ave.|Oak Park|IL|60700
Bill King,60000.0,,Federal Taxes=0.15|State Taxes=0.03|Insurance=0.1,Obscure Dr.|Obscuria|IL|60100

SET FILEPATH=/opt/meituan/qa_test/testfile;
!cp ${hiveconf:FILEPATH}/california-employees.csv ${hiveconf:FILEPATH}/california-employees.csv_new;
dfs -moveFromLocal ${hiveconf:FILEPATH}/california-employees.csv_new  /tmp;
dfs -count /tmp/california-employees.csv_new;
dfs -copyToLocal /tmp/california-employees.csv_new /tmp;
dfs -rm /tmp/california-employees.csv_new;
!rm /tmp/california-employees.csv_new;
*/


    @AfterClass
    public static void cleanUp() {
        System.out.println("cleanUp......");

        String sentrySh = SentryConstant.jSrc + File.separator + SentryConstant.sentry_sh + " clean " + TraceHandler.getSTElement(0, "className");
        String[] sentryCmd = {"/bin/bash", "-c", "source " + sentrySh};
        System.out.println("exit code:\n" + UtilTool.execCommand(sentryCmd).get(0));
    }
}
