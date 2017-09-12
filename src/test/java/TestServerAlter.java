import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
//import static org.junit.Asstert.*;


public class TestServerAlter {

    /**
     *  Add role, group and privilege
     *
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -create_role -r server_alter
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml -add_role_group -r server_alter -g server_alter_group
     * /opt/meituan/sentry/bin/sentryShell --conf /opt/meituan/sentry/conf/sentry-site.xml --grant_privilege_role --role server_alter --privilege server=server1->action=alter
     */

    /**
     * Remove role, group and privilege
     *
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --revoke_privilege_role -r server_alter -p server=server1->action=alter
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --delete_role_group -r server_alter -g server_alter_group
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --drop_role -r server_alter
     */

    /**
     * Check role, group and privilege
     *
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_role
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_role -g server_alter_group
     * /opt/meituan/sentry/bin/sentryShell -conf /opt/meituan/sentry/conf/sentry-site.xml --list_privilege -r server_alter
     */

    @Before
    public void setUp() {
/*
    sudo -iusankuai
    source /etc/profile
    source /etc/bashrc
    source ~/.bashrc
    source ~/.bash_profile
    export HADOOP_JAR_AUTHENTICATION=KERBEROS
    export HADOOP_JAR_KERBEROS_KEYTAB_FILE=/etc/hadoop/keytabs/hadoop-launcher.keytab
    export HADOOP_JAR_KERBEROS_PRINCIPAL=hadoop-launcher/_HOST@SANKUAI.COM
    export HADOOP_PROXY_USER=hadoop-hdp
    export HADOOP_PROXY_USER=hadoop-hdp@hadoop-hdp
    /opt/meituan/versions/mthive-1.2.1-package.sentry2/bin/hive --hiveconf hive.mt.metastore.auth.enable=true --hiveconf hive.mt.metastore.audit.id=TEST-1234-ABCD-5678
*/
    }

    @Test
    /**
     * test CREATE DATABASE
     *      DROP DATABASE
     *      SHOW DATABASES
     *
     * CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
     * SHOW DATABASES LIKE 'test_db';
     * DROP DATABASE test_db;
     * SHOW DATABASES LIKE 'test_db';
     */
    public void testCreateDropDB(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }

    @Test
    /**
     * test CREATE DATABASE
     *      DROP DATABASE CASCADE
     *      SHOW DATABASES
     *      CREATE TABLE
     *      CREATE VIEW
     *
     * CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
     * SHOW DATABASES LIKE 'test_db';
     * CREATE TABLE test_db.test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
     * CREATE VIEW test_db.test_view AS SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM test_db.test_tbl;
     * DROP DATABASE test_db CASCADE;
     * SHOW DATABASES LIKE 'test_db';
     */
    public void testCreateDropDBCascade(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }


    @Test
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
     * DROP TABLE test_tbl;
     * DROP DATABASE test_db;
     */
    public void testCreateDropTable(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }

    @Test
    /**
     * test CREATE DATABASE
     *      USE <dbName>
     *      CREATE TABLE
     *      CREATE VIEW
     *      CREATE INDEX
     *      DROP TABLE CASCADE (WITH VIEW)
     *      DROP DATABASE
     *
     * CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
     * USE test_db;
     * CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
     * CREATE VIEW test_view AS SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM test_tbl;
     *
     * CREATE INDEX test_tbl_index ON TABLE test_tbl (col3)
     * AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler'
     * WITH DEFERRED REBUILD IDXPROPERTIES ('creator' = 'HADOOP-QA')
     * IN TABLE test_tbl_index_on_col3_column
     * COMMENT 'test_tbl indexed by col3.';
     *
     * DROP TABLE test_tbl CASCADE;
     * DROP DATABASE test_db;
     */
    public void testCreateDropTableCascade(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }

    @Test
    /**
     * test CREATE DATABASE
     *      USE <dbName>
     *      CREATE TABLE
     *      CREATE VIEW
     *      CREATE INDEX
     *      DROP TABLE CASCADE (WITH VIEW)
     *      DROP DATABASE
     *
     * CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
     * USE test_db;
     * CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
     * CREATE VIEW test_view AS SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM test_tbl;
     *
     * CREATE INDEX test_tbl_index ON TABLE test_tbl (col3)
     * AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler'
     * WITH DEFERRED REBUILD IDXPROPERTIES ('creator' = 'HADOOP-QA')
     * IN TABLE test_tbl_index_on_col3_column
     * COMMENT 'test_tbl indexed by col3.';
     *
     * SHOW TABLES 'test_db.*'
     *
     * DROP TABLE test_tbl CASCADE;
     * DROP DATABASE test_db;
     */
    public void testCreateDropIndex(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }

    @Test
    /**
     * test CREATE DATABASE
     *      USE <dbName>
     *      CREATE TABLE
     *      CREATE VIEW
     *      CREATE INDEX
     *      DROP TABLE CASCADE (WITH VIEW)
     *      DROP DATABASE
     *
     * CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
     * USE test_db;
     * CREATE TABLE test_tbl (col1 TINYINT, col2 SMALLINT, col3 INT, col4 BIGINT, col5 BOOLEAN, col6 FLOAT, col7 DOUBLE, col8 STRING, col9 TIMESTAMP);
     * CREATE VIEW test_view AS SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM test_tbl;
     *
     * CREATE INDEX test_tbl_index ON TABLE test_tbl (col3)
     * AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler'
     * WITH DEFERRED REBUILD IDXPROPERTIES ('creator' = 'HADOOP-QA')
     * IN TABLE test_tbl_index_on_col3_column
     * COMMENT 'test_tbl indexed by col3.';
     *
     * DROP TABLE test_tbl CASCADE;
     * DROP DATABASE test_db;
     */
    public void testCreateDropTableWithViewIndexCascade(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }

    @Test
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
     * DESCRIBE test_view;
     * SHOW TABLE test_view;
     * DROP VIEW test_view;
     * DROP TABLE test_tbl;
     * DROP DATABASE test_db;
     */
    public void testCreateAlterDescribeShowDropView(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }

    @Test
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
     * ALTER TABLE test_tbl REPLACE COLUMNS (new_col1 INT COMMENT 'new column 1' , new_col2 STRING COMMENT 'new column 2', new_col3 STRING COMMENT ' new column3');
     * SHOW TABLE test_tbl;
     * ALTER TABLE test_tbl CHANGE new_col1 new_col1to2 INT COMMENT "put column1 to position 2nd" AFTER new_col2;
     * ALTER TABLE test_tbl CHANGE new_col3 new_col3to1 INT COMMENT "put last column to position 1st" FIRST;
     * DESCRIBE TABLE test_tbl;
     * ALTER TABLE test_tbl RENAME TO test_tbl_new;
     * ALTER TABLE test_tbl_new SET TBLPROPERTIES ('notes' = 'Test for set tblproperties');
     * DESCRIBE EXTENDED TABLE test_tbl_new;
     * DROP DATABASE test_db;
     */
    public void testAlterDescribeTable11(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }

    @Test
    /**
     * test CREATE TABLE
     *      ALTER TABLE .. SET FILEFORMAT
     *      DESCRIBE EXTENDED TABLE
     *      ALTER TABLE .. ADD PARTITION location
     *
     * CREATE TABLE test_db;
     * CREATE TABLE IF NOT EXISTS test_db.log_messages (hms INT, severity STRING, server STRING, process_id INT, message STRING)
     * PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
     *
     * ALTER TABLE test_db.log_messages SET FILEFORMAT SEQUENCEFILE;
     * DESCRIBE EXTENDED test_db.log_messages;
     * DESCRIBE test_db.log_messages;
     *
     *
     * ALTER TABLE test_db.log_messages ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan/user/hive/warehouse/test_db.db/log_messages/2012/01/02';
     * CREATE EXTERNAL TABLE IF NOT EXISTS test_db.log_messages_external (hms INT, severity STRING, server STRING, process_id INT, message STRING) PARTITIONED BY (year INT, month INT, day INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t';
     * ALTER TABLE test_db.log_messages_external ADD PARTITION(year = 2012, month = 1, day = 2) LOCATION 'viewfs://hadoop-meituan/user/hive/warehouse/test_db.db/log_messages_external/2012/01/02';
     * DESCRIBE EXTENDED test_db.log_messages_external;
     * DESCRIBE test_db.log_messages_external;
     *
     * DROP TABLE test_db.log_messages;
     * DROP DATABASE test_db.test_db CASCADE;
     */
    public void testAlterDescribeTable2 (){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

    }

    @Test
    /**
     * test ALTER TABLE .. PARTITION SET FILEFORMAT
     *      SHOW CREATE TABLE
     *      SHOW PARTITIONS
     *      DESCRIBE TABLE
     *
     * ALTER TABLE log_messages PARTITION (year = 2011, month = 1, day = 1) SET FILEFORMAT SEQUENCEFILE;
     * SHOW CREATE TABLE log_messages;
     * SHOW PARTITIONS log_messages;
     * DESCRIBE EXTENDED log_messages;
     * DESCRIBE log_messages;
     */
    public void testAlterDescribeTable12(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }



/**
    命令行结合SQL执行
-- 1014 ALTER TABLE ..SET LOCATION
    ALTER TABLE log_messages ADD PARTITION (year = 2011, month = 1, day = 1);
    ALTER TABLE log_messages ADD PARTITION (year = 2011, month = 1, day = 2);
    ALTER TABLE log_messages ADD PARTITION (year = 2011, month = 2, day = 1);

--将要移动的分区的数据复制到新路径
    hadoop distcp 命令：
    hadoop distcp /user/hive/warehouse/test_db_new.db/log_messages/2011/02/01 /user/hive/warehouse/test_db_new.db/log_messages_new/2011/02/01
            --更改TABLE以将分区指向新位置：
    ALTER TABLE log_messages PARTITION (year = 2011, month = 1, day = 1) SET LOCATION 'viewfs://hadoop-meituan/user/hive/warehouse/test_db_new.db/log_messages_new/2011/01/01';
    ALTER TABLE log_messages PARTITION (year = 2011, month = 1, day = 2) SET LOCATION 'viewfs://hadoop-meituan/user/hive/warehouse/test_db_new.db/log_messages_new/2011/01/02';
--获取table的真实hdfs路径
    desc formatted log_messages;
--获取partition的真实hdfs路径
    desc formatted log_messages partition (year = 2011, month = 1, day =1);
    desc formatted log_messages partition (year = 2011, month = 1, day =2);
    desc formatted log_messages partition (year = 2011, month = 2, day =2);
--使用hadoop fs -rmr 命令删除分区的HDFS副本：
    hadoop fs -rmr /user/hive/warehouse/test_db_new.db/log_messages/2011/01/01
    hadoop fs -rmr /user/hive/warehouse/test_db_new.db/log_messages/2011/01/02
*/
public void testAlterDescribeTable13(){
    Assert.assertEquals("hello", "hello");
    System.out.println("~~~~~~~~~~~");

}



    @Test
    /**
     *  ALTER TABLE .. ADD PARTITION
     *  ALTER TABLE .. DROP PARTITION
     *  ALTER TABLE .. DROP PARTITION
     *
     *  CREATE TABLE supply (id INT, part STRING, quantity INT)  PARTITIONED BY (day INT);
     *  ALTER TABLE supply ADD PARTITION (day = 20110102);
     *  ALTER TABLE supply ADD PARTITION (day = 20110103)
     *  ALTER TABLE supply ADD PARTITION (day = 20110104);
     *  SHOW PARTITIONS supply;
     *  SELECT id, part, quantity FROM supply WHERE day >= 20110102 AND day < 20110103 AND quantity < 4 ;
     *  ALTER TABLE supply DROP PARTITION (day = 20110102);
     *  ALTER TABLE supply DROP PARTITION (day = 20110103)
     *  ALTER TABLE supply DROP PARTITION (day = 20110104);
     *  SHOW PARTITIONS supply;
     *  DROP TABLE supply；
     */
     public void testAddDropShowPartition(){
         Assert.assertEquals("hello", "hello");
         System.out.println("~~~~~~~~~~~");
     }

/**
 * test SHOW TABLES
    SHOW TABLES;
    SHOW TABLES LIKE 'e*';
        -- 1022 SHOW GRANT ROLE
            单独测试
*/
public void testAlterDescribeTable14(){
    Assert.assertEquals("hello", "hello");
    System.out.println("~~~~~~~~~~~");

}


/**
    单独测试
    test LOAD DATA

    CREATE TABLE serde_regex （

    LOAD DATA LOCAL INPATH “../data/files/apache.access.log” INTO TABLE serde_regex ;
    LOAD DATA LOCAL INPATH “../data/files/apache.access.2.log” INTO TABLE serde_regex ;
    SELECT * FROM serde_regex ORDER BY time ;

    export TMP=/tmp
    $TMP/kv_data.txt  that looks like:
    k1=v1,k2=v2
            k4=v4,k5=v5,k6=v6
    k7=v7,k7=v7,k3=v7
    Create this Perl script and save it as $TMP/split_kv.pl :
            #!/usr/bin/perl
while (<STDIN>) {
        my $line = $_;
        chomp($line);
        my @kvs = split(/,/, $line);
        foreach my $p (@kvs) {
            my @kv = split(/=/, $p);
            print $kv[0] . "\t" . $kv[1] . "\n";
        }
    }
    CREATE TABLE kv_data ( line STRING );
    LOAD DATA LOCAL INPATH '${env:TMP}/kv_data.txt' INTO TABLE kv_data;
    SELECT TRANSFORM (line) USING 'perl split_kv.pl' AS (key, value) FROM kv_data;
    k1 v1
    k2 v2
    k4 v4
    k5 v5
    k6 v6
    k7 v7
    k7 v7
    k3 v7

    CREATE TABLE sum (number INT);
    LOAD DATA LOCAL INPATH '$ {env：HOME} /data_to_sum.txt'INTO TABLE sum ;

    dfs -cat $HOME/afile.txt;
    twelve 12
    twelve 1
    eleven 11
    eleven 10
    CREATE TABLE collecttest (str STRING, countVal INT)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY '09' LINES TERMINATED BY '10';
    LOAD DATA LOCAL INPATH '${env:HOME}/afile.txt' INTO TABLE collecttest;
    SELECT str, concat_ws( ',' , collect(cast(countVal AS STRING)))
    FROM collecttest GROUP BY str;
    eleven 11,10
    twelve 12,1
            --------------------------------------------------------------------
            -- 1025 SELECT
    SELECT * FROM test_tbl;
    SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM test_tbl;
    SELECT col1, col2, col3, col4, col5, col6, col7, col8, col9 FROM test_view;
*/
public void testAlterDescribeTable15(){
    Assert.assertEquals("hello", "hello");
    System.out.println("~~~~~~~~~~~");

}


/**
 * INSERT OVERWRITE TABLE
 *
 *
    name|salary|subordinates|deductions|address
    John Doe,100000.0,Mary Smith|Todd Jones,Federal Taxes=0.2|State Taxes=0.05|Insurance=0.1,1|Michigan Ave.|Chicago|IL|60600
    Mary Smith,80000.0,Bill King,Federal Taxes=0.2|State Taxes=0.05|Insurance=0.1,100|Ontario St.|Chicago|IL|60601
    Todd Jones,70000.0,,Federal Taxes=0.15|State Taxes=0.03|Insurance=0.1,200|Chicago Ave.|Oak Park|IL|60700
    Bill King,60000.0,,Federal Taxes=0.15|State Taxes=0.03|Insurance=0.1,300|Obscure Dr.|Obscuria|IL|60100

    CREATE TABLE staged_employees (
            name STRING,
            salary FLOAT,
            subordinates ARRAY<STRING>,
            deductions MAP<STRING, FLOAT>,
            address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
    ) PARTITIONED BY (country STRING, state STRING)
    row format delimited fields terminated by '\t'
    collection items terminated by '|'
    map keys terminated by '='
    lines terminated by '\n' stored as textfile;
    export TMP=/tmp
    echo $TMP
    LOAD DATA LOCAL INPATH '${env:TMP}/california-employees.csv'
    INTO TABLE staged_employees
    PARTITION (country = 'US', state = 'CA');

    INSERT OVERWRITE TABLE employees
    PARTITION (country = 'US', state = 'OR')
    SELECT * FROM staged_employees se
    WHERE se.cnty = 'US' AND se.st = 'OR';

    FROM staged_employees se
    INSERT OVERWRITE TABLE employees
    PARTITION (country = 'US', state = 'OR')
    SELECT * WHERE se.cnty = 'US' AND se.st = 'OR'
    INSERT OVERWRITE TABLE employees
    PARTITION (country = 'US', state = 'CA')
    SELECT * WHERE se.cnty = 'US' AND se.st = 'CA'
    INSERT OVERWRITE TABLE employees
    PARTITION (country = 'US', state = 'IL')
    SELECT * WHERE se.cnty = 'US' AND se.st = 'IL';

    INSERT OVERWRITE TABLE employees
    PARTITION (country = 'US', state)
    SELECT se.*
    FROM staged_employees se
    WHERE se.cnty = 'US';
*/
public void testAlterDescribeTable16(){
    Assert.assertEquals("hello", "hello");
    System.out.println("~~~~~~~~~~~");

}

    /**
     * test CREATE TABLE .. AS SELECT
     *
     * DROP DATABASE test_db;
     * CREATE TABLE test_db.session_test (
     * st_user_id STRING,
     * st_pageview_id STRING,
     * st_page_url STRING,
     * st_referrer_url STRING,
     * st_timestamp DOUBLE);
     *
     * CREATE TABLE test_db.sessionization_step_one_origins AS
     * SELECT c.c_user_id as ssoo_user_id,
     *        c.c_pageview_id as ssoo_pageview_id,
     *        c.c_timestamp as ssoo_timestamp
     * FROM
     * (SELECT a.a_user_id as c_user_id,
     *         a.a_pageview_id as c_pageview_id,
     *         a.a_timestamp as c_timestamp,
     *         SUM(IF(a.a_timestamp + 1800 >= b.b_timestamp AND a.a_timestamp < b.b_timestamp,1,0)) AS c_nonorigin_flags
     * FROM (SELECT st_user_id as a_user_id,
     *              st_pageview_id as a_pageview_id,
     *              st_timestamp as a_timestamp
     *       FROM test_db.session_test ) a
     * JOIN (SELECT st_user_id as b_user_id,
     *              st_timestamp as b_timestamp
     *       FROM test_db.session_test ) b
     * ON a.a_user_id = b.b_user_id
     * GROUP BY a.a_user_id,
     *          a.a_pageview_id,
     *          a.a_timestamp) c;
     *
     * DESCRIBE TABLE test_db.sessionization_step_one_origins;
     *
     * DROP DATABASE test_db;
     */
    public void testCreateTableAsSelect(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

    /**
     * test CREATE TABLE LIKE
     *      SET
     *      INSERT OVERWRITE TABLE
     *
     * CREATE TABLE partition_table001 (name STRING, ip STRING)
     * PARTITIONED BY (dt STRING, ht STRING)
     * ROW FORMAT DELIMITED FIELDS TERMINATED BY "\t";
     *
     * SET hive.exec.dynamic.partition=true;
     * SET hive.exec.dynamic.partition.mode=nonstrict;
     *
     * CREATE TABLE IF NOT EXISTS partition_table002 LIKE partition_table001;
     * INSERT OVERWRITE TABLE partition_table002 PARTITION (dt='20150617', ht='00') SELECT name, ip FROM partition_table001 WHERE dt='20150617' and ht='00';
     * INSERT OVERWRITE TABLE partition_table002 PARTITION (dt, ht) SELECT * FROM partition_table001 WHERE dt='20150617';
     * INSERT OVERWRITE TABLE partition_table002 PARTITION (dt, ht='00') SELECT name, ip, '20150617' dt FROM partition_table001 WHERE dt='20150617' and ht='00';
     */
    public void testCreateTableLike(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

    /**
     * test ADD JAR
     *      CREATE FUNCTION
     *
     * ADD JAR /tmp/hive_qa_udf.jar;
     * LIST JARS;
     * CREATE TEMPORARY FUNCTION my_lower AS 'com.example.hive.udf.LowerCase';
     * CREATE TABLE teacher (name STRING);
     * INSERT INTO teacher VALUES ('TEACHER QA');
     * SELECT LowerCase(name) FROM teacher;
     * TOUCH /tmp/afile
     * ADD FILE afile;
     * LIST FILES;
     * DROP TABLE teacher;
     * REMOVE afile;
     * REMOVE hive_qa_udf.jar;
     */
    public void testAddJarCreateTmpFunction17(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

    /**
     * test ADD FILE
     *
     * #!/bin/bash
     * echo "hello, $*"
     *
     * CREATE TABLE whoyouare(who string);
     * LOAD DATA LOCAL INPATH '/tmp/who.txt' OVERWRITE INTO TABLE whoyouare;
     * SELECT * FROM whoyouare;
     * ADD FILE /tmp/test.sh;
     * LIST FILES;
     * SELECT TRANSFORM (who) USING 'sh hello.sh' AS (who) FROM whoyouare;
     * REMOVE test.sh;
     * DROP TABLE whoyouare;
     */
    public void testAddFile(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

    /**
     * test ALTER TABLE ..SET SERDEPROPERTIES
     *
     * CREATE TABLE test_serde (c0 string, c1 string, c2 string) ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
     * WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;
     *
     * ALTER TABLE test_serde SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s')
     *
     * DROP TABLE test_serde;
     */
     public void testAlterSerDeTable(){
         Assert.assertEquals("hello", "hello");
         System.out.println("~~~~~~~~~~~");
     }


    /**
     * test ALTER TABLE .. PARTITION SET SERDEPROPERTIES
     *
     * CREATE TABLE test_serde(c0 string, c1 string, c2 string)
     * PARTITIONED BY (col10 STRING, col20 STRING)
     * ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.RegexSerDe'
     * WITH SERDEPROPERTIES ('input.regex' = 'bduid\\[(.*)\\]uid\\[(\\d+)\\]uname\\[(.*)\\]', 'output.format.string' = '%1$s\t%2$s') STORED AS TEXTFILE;
     *
     * ALTER TABLE test_serde ADD PARTITION (col10='abc', col20='123');
     * DESCRIBE EXTENDED test_serde PARTITION (col10='abc', col20='123');
     *
     * ALTER TABLE test_serde PARTITION (col10='abc', col20='123') SET SERDEPROPERTIES ('charset' = 'GBK', 'input.regex'='bduid\\[(.*)\\]uid\\[(\\d+)\\]', 'output.format.string' = '%1$s\t%2$s');
     * DESCRIBE EXTENDED test_serde PARTITION (col10='abc', col20='123');
     *
     * DROP TABLE test_serde;
     */
    public void testAlterDescribeTable(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }



    /** test Analyze TABLE
     *       INSERT OVERWRITE DIRECTORY
     *
     * INSERT OVERWRITE DIRECTORY
     * FROM staged_employees se
     * INSERT OVERWRITE DIRECTORY '/tmp/or_employees'
     * SELECT * WHERE se.country = 'US' and se.state = 'OR'
     * INSERT OVERWRITE DIRECTORY '/tmp/ca_employees'
     * SELECT * WHERE se.country = 'US' and se.state = 'CA'
     * INSERT OVERWRITE DIRECTORY '/tmp/il_employees'
     * SELECT * WHERE se.country = 'US' and se.state = 'IL';
     *
     * FROM (
     *        SELECT emp.name, emp.salary FROM employees emp WHERE emp.salary < 6000
     *        UNION ALL
     *        SELECT emp.name, emp.salary FROM employees emp WHERE emp.salary > 7000
     * ) unioninput
     * INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*
     *
     * ANALYZE TABLE employees COMPUTE STATISTICS FOR columns name, salary;
     */
    public void testAlterDescribeTable18(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

    /**
     * test IMPORT TABLE
     *      EXPORT TABLE
     *
     * -- 导出分区并且导入到分区表分区
     * EXPORT TABLE staged_employees PARTITIONS (country = 'US', state = 'CA') TO '/tmp/employee';
     * -- '/user/hive/warehouse/test_db_new.db/export/employee'
     * ALTER TABLE employees ADD PARTITION (country = 'US', state = 'CA');
     * IMPORT TABLE employees PARTITION (country = 'US', state = 'CA') FROM '/tmp/employee';
     */
    public void testAlterDescribeTable19(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }


   /**
    * test ALTER TABLE TOUCH
    *
    * ALTER TABLE employees TOUCH;
    */
   public void testAddJarCreateTmpFunction(){
       Assert.assertEquals("hello", "hello");
       System.out.println("~~~~~~~~~~~");
   }

    /**
     * test ALTER TABLE TOUCH PARTITION
     *      DESCRIBE TABLE .. PARTITION
     *
     * ALTER TABLE employees ADD PARTITION (country = 'CHN', state = 'BJ') ;
     * ALTER TABLE employees TOUCH PARTITION (country = 'CHN', state = 'BJ') ;
     * ALTER TABLE employees TOUCH PARTITION (country = 'CHN', state = 'BJ') ;
     *
     * DESCRIBE employees PARTITION (country='US', state='CA');
     * DESCRIBE EXTENDED employees PARTITION (country='US', state='CA');
     */
    public void testAlterTouchDescribeTable(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

    /**
     * test ALTER TABLE .. CLUSTERED BY SORTED BY
     * ALTER TABLE employees CLUSTERED BY (name, address) SORTED BY (salary) INTO 48 BUCKETS;
     */
    public void testAlterTableClusteredBySortedBy(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

        /** test ALTER TABLE .. ENABLE / DISABLE
         *
         * ALTER TABLE log_messages ENABLE NO_DROP;
         * DROP log_messages;
         * ALTER TABLE log_messages DISABLE NO_DROP;
         * DROP log_messages;

         * ALTER TABLE log_messages ENABLE OFFLINE;
         * DROP log_messages;
         * ALTER TABLE log_messages DISABLE OFFLINE;
         * DROP log_messages;
         */
    public void testAlterTableEnableDisable(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }


    /**
     * test ALTER TABLE .. PARTITION ENABLE / DISABLE
     *
     * ALTER TABLE log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
     * ALTER TABLE log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE NO_DROP;
     * ALTER TABLE log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
     *
     * ALTER TABLE log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE NO_DROP;
     * ALTER TABLE log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
     *
     * ALTER TABLE log_messages ADD PARTITION (year = 2017, month = 8, day = 1);
     * ALTER TABLE log_messages PARTITION(year = 2017, month = 8, day = 1) ENABLE OFFLINE;
     * ALTER TABLE log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
     *
     * ALTER TABLE log_messages PARTITION(year = 2017, month = 8, day = 1) DISABLE OFFLINE;
     * ALTER TABLE log_messages DROP PARTITION (year = 2017, month = 8, day = 1);
     */
    public void testAlterPartitionEnableDisable(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

    /**
     * test ALTER TABLE .. PARTITION .. RENAME TO PARTITION
     * ALTER TABLE employees PARTITION(country='CHN',STATE='BJ') RENAME TO PARTITION(country='CHINA',STATE='BEIJING');
     */



    /**
     * test MSCK REPAIR TABLE
     *
     * CREATE TABLE test_msck (id INT, val STRING) PARTITIONED BY(month INT);
     * SHOW PARTITIONS test_msck;
     * #创建两个分区目录
     * dfs -mkdir /user/hive/warehouse/test_msck/month=201603;
     * dfs -mkdir /user/hive/warehouse/test_msck/month=201604;
     * #使用MSCK修复分区
     * MSCK REPAIR TABLE test_msck;
     * #再次查看，发现已经成功更新元信息
     * SHOW PARTITIONS test_msck;
     */
    public void testMSCKRepairTable(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }


    /**
     * test ALTER DATABASE
     *      DESCRIBE DATABASE
     *
     * CREATE DATABASE test_db WITH DBPROPERTIES ('creator' = 'hadoop-QA', 'date' = '2017-10-02');
     * ALTER DATABASE test_db SET DBPROPERTIES ('edited-by' = 'hadoop-new-qa');
     * DESCRIBE DATABASE test_db;
     * DESCRIBE DATABASE EXTENDED test_db;
     * DROP DATABASE test_db;
     */
    public void testAlterPropertiesDescribeDB(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
    }

    /**
     * test SHOW COLUMNS
     *
     * SHOW COLUMNS IN employees;
     * SHOW COLUMNS FROM employees;
     */
     public void testShowColumnsTable(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
     }

    /**
     * test CREATE INDEX
     *      SHOW INDEX
     *      DROP INDEX
     *
     * CREATE TABLE employees (
     * name STRING,
     * salary FLOAT,
     * subordinates ARRAY<STRING>,
     * deductions MAP<STRING, FLOAT>,
     * address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
     * ) PARTITIONED BY (country STRING, state STRING);
     *
     * CREATE INDEX employees_index
     * ON TABLE employees (name)
     * AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler'
     * WITH DEFERRED REBUILD
     * IDXPROPERTIES ('creator' = 'HADOOP-QA')
     * IN TABLE employees_index_on_name_column
     * COMMENT 'Employees indexed by name.';
     *
     * SHOW INDEX ON employees;
     * SHOW FORMATTED INDEX ON employees;
     *
     * DROP INDEX IF EXISTS employees_index ON TABLE employees;
     * DROP TABLE employees;
     */
     public void testCreateShowDropIndex(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
     }

     /**
      * test CREATE INDEX
      *      SHOW INDEX
      *      DROP INDEX
      *
      * CREATE TABLE employees (
      * name STRING,
      * salary FLOAT,
      * subordinates ARRAY<STRING>,
      * deductions MAP<STRING, FLOAT>,
      * address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
      * ) PARTITIONED BY (country STRING, state STRING);
      *
      * CREATE INDEX employees_bitmap_index
      * ON TABLE employees (subordinates)
      * AS 'BITMAP'
      * WITH DEFERRED REBUILD
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
      */
      public void testCreateShowDropBitmapIndex(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
      }

     /**
      * test SHOW TBLPROPERTIES
      *
      * CREATE TABLE IF NOT EXISTS employees_props (
      * name  STRING COMMENT 'Employee name',
      * salary  FLOAT  COMMENT'Employee salary',
      * subordinates ARRAY<STRING> COMMENT 'Names of subordinates',
      * deductions  MAP<STRING, FLOAT> COMMENT  'Keys are deductions names, values are percentages',
      * address  STRUCT<street:STRING,city:STRING, state:STRING, zip:INT> COMMENT 'Home address') COMMENT 'Description of the table'
      * LOCATION '/user/hive/warehouse/test_db.db/employees_props'
      * TBLPROPERTIES ('creator'='HADOOP-QA','created_at'='2017-9-10 10:00:00', 'notes'='test show tblproperties');
      *
      * SHOW TBLPROPERTIES employees_props;
      *
      * DROP TABLE employees_props;
      */
     public void testShowTBLPROPERTIES(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");
     }




    /**
     * dfs
     dfs -ls /
     */
public void testAlterDescribeTable20(){
        Assert.assertEquals("hello", "hello");
        System.out.println("~~~~~~~~~~~");

        }


    @After
    public void cleanUp() {

    }
}