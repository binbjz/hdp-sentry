# Sentry Hive, Spark Framework of Automation Test: sentry-test


It's simple framework of automation test for sentry hive, spark.

This project was written in **bash shell** and **java**.



### sentry-test _does..._

* Allow you to run **sentry, hive** automated testing.
* Allow you to run **sentry, spark** automated testing.
* Allow you to run **Single test case** or **All test cases**.


----


## Table of Contents

* **[How It Works](#how-it-works)**
* **[How To Run It](#how-to-run-it)**
* **[How To Run It Step By Step](#how-to-run-it-step-by-step)**
* **[How To Check Running Log](#how-to-check-running-log)**


----


## How It Works

* sentry will grant user, role and group privileges
* hive or spark will execute sql with authorized End-user


----


## How To Run It

The command will run sentry hive, spark test cases. All test cases will be defined in the script.
You can specify single test case or multiple test cases to run.

* /usr/bin/time -f "Time: %U" bash sentry_dispatcher.sh


----


## How To Run It Step By Step

You can also run it by manually.

1. **grant user with super privilege.**
   super privilege will be granted to user mt_qa .
    ```sh
    $ source ./sentry-test/src/main/resources/sentry_super_env.sh setup SuperPrivil
    ```

   **NOTE:** Usage: sentry_super_env.sh (setup|clean|check) SuperPrivil

2. **grant user with normal privilege.**
    You should specify the test name which need to be granted, if you need to run test case with ServerAll privilege.
    ```sh
    $ source ./sentry-test/src/main/resources/sentry_env.sh setup ServerAll
    ```

   **NOTE:** Usage: sentry_env.sh (setup|clean|check) ServerAll

3. **login hive shell with super user to execute prepare sql.**
    To execute prepare sql, you need to login hive shell with super user (mt_qa).
    ```sh
    $ source ./sentry-test/src/main/resources/hive_env.sh proxy_user_t1 super
    $ /opt/meituan/hive-1.2/bin/hive --hiveconf hive.cli.errors.ignore=true -f ./sentry-test/src/test/resources/hive-sql/common-sql/prepareAll.sql
    ```

   **NOTE:** Usage: hive_env.sh (keytab_auth|proxy_user_t1|proxy_user_t2_1|proxy_user_t2_2|proxy_user_group1|proxy_user_group2|clean_proxy_user) (super|normal|hive)"

4. **login hive shell with normal user and run single test case.**
   You can now login hive shell with normal user and run specify test case. For example: ServerAll
    ```sh
    $ source sentry-test/src/main/resources/hive_env.sh proxy_user_t1 normal
    $ /usr/bin/time -f "Time: %U" java -Djava.ext.dirs=./data_bin/test-lib/ -cp ./sentry-test/target/classes:./sentry-test/target/test-classes/ org.junit.runner.JUnitCore ServerAll
    ```

5. **login hive shell with super user to execute post sql..**
    To execute post sql, you need to login hive shell with super user (mt_qa).
    ```sh
    $ source ./sentry-test/src/main/resources/hive_env.sh proxy_user_t1 super
    $ /opt/meituan/hive-1.2/bin/hive --hiveconf hive.cli.errors.ignore=true -f ./sentry-test/src/test/resources/hive-sql/common-sql/post.sql
    ```

6. **clean proxy env.**
     You need to clean proxy env, if you login hive with proxy approach.
      ```sh
      $ source ./sentry-test/src/main/resources/hive_env.sh clean_proxy_user hive
      ```     

   **NOTE:** login hive with ```proxy``` approach, we need to revoke privileges otherwise it will throw exception.
   **NOTE:** login hive with ```keytab``` approach, this step is not needed. 

7. **revoke user with super privilege.**
   super privilege will be granted to user mt_qa .
    ```sh
    $ source ./sentry-test/src/main/resources/sentry_super_env.sh clean SuperPrivil
    ```

8. **revoke user with normal privilege.**
    You should specify the test name which need to be granted, if you need to run test case with ServerAll privilege.
    ```sh
    $ source ./sentry-test/src/main/resources/sentry_env.sh clean ServerAll
    ```


----


## How To Check Running Log

* check sentry-test/src/test/log directory, all running logs will be generated in the directory dynamically.
